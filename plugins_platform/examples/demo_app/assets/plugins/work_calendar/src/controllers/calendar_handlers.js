import { calendarState, cloneEvent, createDraft } from '../state/calendar_state.js';
import { pickContacts, sendNotification, showPicker, showToast, submitApproval } from '../services/host_api.js';
import { parseDate } from '../utils/date.js';
import { renderCalendarPage } from '../ui/pages/calendar_page.js';
import { t, toggleLocale } from '../i18n.js';

export function handleGoToday() {
  calendarState.currentDate = new Date();
  calendarState.selectedDate = new Date();
  syncDraftForSelectedDay();
  return fullUpdate();
}

export function handlePreviousMonth() {
  calendarState.currentDate = new Date(
    calendarState.currentDate.getFullYear(),
    calendarState.currentDate.getMonth() - 1,
    1
  );
  calendarState.selectedDate = new Date(calendarState.currentDate);
  syncDraftForSelectedDay();
  return fullUpdate();
}

export function handleNextMonth() {
  calendarState.currentDate = new Date(
    calendarState.currentDate.getFullYear(),
    calendarState.currentDate.getMonth() + 1,
    1
  );
  calendarState.selectedDate = new Date(calendarState.currentDate);
  syncDraftForSelectedDay();
  return fullUpdate();
}

export function handleDateClick(state) {
  const date = state && state.props ? state.props.date : null;
  if (date) {
    calendarState.selectedDate = parseDate(date);
    syncDraftForSelectedDay();
  }
  return fullUpdate();
}

export function handleEventDetail(state) {
  const eventId = state && state.props ? state.props.eventId : null;
  const event = calendarState.events.find(item => item.id === eventId);
  if (event) {
    calendarState.selectedEventId = event.id;
    calendarState.editorMode = 'edit';
    calendarState.draft = cloneEvent(event);
    calendarState.editorKey = event.id;
    calendarState.selectedDate = new Date(event.startTime);
  }
  return fullUpdate();
}

export function handleCreateEvent() {
  const base = calendarState.selectedDate || new Date();
  calendarState.selectedEventId = null;
  calendarState.editorMode = 'create';
  calendarState.draft = createDraft(base);
  calendarState.editorKey = calendarState.draft.id;
  showToast(t('calendar.toastEditStart'));
  return fullUpdate();
}

export function handleSwitchModule(state) {
  const next = state && state.props ? state.props.module : 'schedule';
  calendarState.activeModule = next;
  return fullUpdate();
}

export function handleEditorChange(state) {
  const form = (state && state.form) || {};
  const field = state && state.props ? state.props.field : null;
  const value = state && state.props ? state.props.value : null;
  if (!field) {
    return fullUpdate();
  }
  calendarState.draft = {
    ...calendarState.draft,
    ...form,
    [field]: value
  };
  if (field === 'type' && value === 'approval') {
    calendarState.draft = {
      ...calendarState.draft,
      approvalStatus: 'draft',
      taskStatus: 'open'
    };
  }
  return fullUpdate();
}

export function handlePickContacts() {
  const selectedIds = calendarState.draft.attendeeIds || [];
  const result = pickContacts(selectedIds);
  if (!result) {
    const fallback = [
      { id: 'local_1', name: '张三' },
      { id: 'local_2', name: '李四' }
    ];
    calendarState.contacts = fallback;
    calendarState.draft = {
      ...calendarState.draft,
      attendees: fallback.map(item => item.name),
      attendeeIds: fallback.map(item => item.id)
    };
    return fullUpdate();
  }
  return Promise.resolve(result).then(data => {
    const items = extractItems(data);
    calendarState.contacts = items;
    calendarState.draft = {
      ...calendarState.draft,
      attendees: items.map(item => item.name),
      attendeeIds: items.map(item => item.id)
    };
    return fullUpdate();
  });
}

export function handlePickDateTime(state) {
  const field = state && state.props ? state.props.field : null;
  if (!field || (field !== 'startTime' && field !== 'endTime')) {
    return fullUpdate();
  }

  const currentValue = calendarState.draft[field];
  const initialValue = currentValue ? new Date(currentValue).toISOString() : new Date().toISOString();

  const result = showPicker('datetime', { initialValue });

  if (!result) {
    showToast(t('calendar.pickerNotAvailable'));
    return fullUpdate();
  }

  return Promise.resolve(result).then(data => {
    if (data && data.data && !data.data.cancelled && data.data.value) {
      calendarState.draft = {
        ...calendarState.draft,
        [field]: data.data.value
      };
      showToast(t('calendar.timeUpdated'));
    }
    return fullUpdate();
  }).catch(err => {
    console.error('Picker error:', err);
    return fullUpdate();
  });
}

export function handleSaveEvent(state) {
  const form = (state && state.form) || {};
  const draft = normalizeDraft({
    ...calendarState.draft,
    ...form
  });
  const existingIndex = calendarState.events.findIndex(item => item.id === draft.id);
  if (existingIndex >= 0) {
    calendarState.events[existingIndex] = draft;
  } else {
    calendarState.events = [draft, ...calendarState.events];
  }
  calendarState.selectedEventId = draft.id;
  calendarState.editorMode = 'edit';
  calendarState.draft = cloneEvent(draft);
  if (draft.type === 'approval') {
    calendarState.approvals = [
      {
        id: draft.id,
        title: draft.title,
        owner: draft.location || '流程发起人',
        status: draft.approvalStatus || 'pending',
        createdAt: new Date().toISOString()
      },
      ...calendarState.approvals.filter(item => item.id !== draft.id)
    ];
    submitApproval({
      id: draft.id,
      title: draft.title,
      owner: draft.location || '流程发起人',
      attendees: draft.attendees
    });
  }
  if (draft.reminderEnabled) {
    sendNotification(
      t('calendar.reminderTitle', { title: draft.title }),
      t('calendar.reminderBody', { time: formatReminderTime(draft), location: draft.location || t('calendar.locationTbd') }),
      { eventId: draft.id }
    );
  }
  showToast(t('calendar.toastSaved'));
  return fullUpdate();
}

export function handleDeleteEvent(state) {
  const id = state && state.props ? state.props.id : calendarState.draft.id;
  calendarState.events = calendarState.events.filter(item => item.id !== id);
  calendarState.approvals = calendarState.approvals.filter(item => item.id !== id);
  calendarState.tasks = calendarState.tasks.filter(item => item.id !== id);
  calendarState.selectedEventId = null;
  calendarState.editorMode = 'create';
  calendarState.draft = createDraft(calendarState.selectedDate || new Date());
  showToast(t('calendar.toastDeleted'));
  return fullUpdate();
}

export function handleToggleRepeat(state) {
  const form = (state && state.form) || {};
  const value = state && state.props ? state.props.value : 'none';
  calendarState.draft = {
    ...calendarState.draft,
    ...form,
    recurrence: value
  };
  return fullUpdate();
}

export function handleToggleReminder(state) {
  const form = (state && state.form) || {};
  const value = state && state.props ? state.props.value : false;
  calendarState.draft = {
    ...calendarState.draft,
    ...form,
    reminderEnabled: Boolean(value)
  };
  return fullUpdate();
}

export function handleChangeReminderMinutes(state) {
  const form = (state && state.form) || {};
  const value = state && state.props ? Number(state.props.value) : 15;
  calendarState.draft = {
    ...calendarState.draft,
    ...form,
    reminderMinutes: value
  };
  return fullUpdate();
}

export function handleToggleLocale() {
  toggleLocale();
  return fullUpdate();
}

export function handleFilter() {
  return fullUpdate();
}

export function handleApprovalAction(state) {
  const id = state && state.props ? state.props.id : null;
  const action = state && state.props ? state.props.action : 'approve';
  const item = calendarState.approvals.find(entry => entry.id === id);
  if (item) {
    item.status = action === 'reject' ? 'rejected' : 'approved';
    showToast(t(action === 'reject' ? 'approval.toastRejected' : 'approval.toastApproved'));
  }
  return fullUpdate();
}

export function handleTaskAction(state) {
  const id = state && state.props ? state.props.id : null;
  const action = state && state.props ? state.props.action : 'done';
  const item = calendarState.tasks.find(entry => entry.id === id);
  if (item) {
    item.status = action === 'done' ? 'done' : 'doing';
    showToast(t('task.toastUpdated'));
  }
  return fullUpdate();
}

function syncDraftForSelectedDay() {
  if (calendarState.editorMode === 'edit' && calendarState.selectedEventId) {
    const event = calendarState.events.find(item => item.id === calendarState.selectedEventId);
    if (event) {
      calendarState.draft = cloneEvent(event);
      return;
    }
  }
  calendarState.draft = createDraft(calendarState.selectedDate || new Date());
}

function normalizeDraft(draft) {
  const base = calendarState.selectedDate || new Date();
  const start = parseDateTime(base, draft.startTime, 9, 0);
  const end = parseDateTime(base, draft.endTime, 10, 0);
  const attendees = draft.attendees || [];
  const attendeeIds = draft.attendeeIds || [];
  const title = draft.title || '新建跟进事项';
  return {
    ...draft,
    id: draft.id || `evt_${Date.now()}`,
    title,
    type: draft.type || 'task',
    startTime: start.toISOString(),
    endTime: end.toISOString(),
    location: draft.location || '',
    attendees,
    attendeeIds,
    notes: draft.notes || '',
    recurrence: draft.recurrence || 'none',
    reminderEnabled: draft.reminderEnabled !== false,
    reminderMinutes: Number(draft.reminderMinutes ?? 15),
    approvalStatus: draft.approvalStatus || 'draft',
    taskStatus: draft.taskStatus || 'open'
  };
}

function formatReminderTime(draft) {
  const start = new Date(draft.startTime || new Date());
  return `${start.getHours().toString().padStart(2, '0')}:${start.getMinutes().toString().padStart(2, '0')}`;
}

function extractItems(payload) {
  if (!payload) {
    return [];
  }
  const root = payload.data || payload;
  if (Array.isArray(root.items)) {
    return root.items;
  }
  if (Array.isArray(root)) {
    return root;
  }
  return [];
}

function parseDateTime(baseDate, timeText, defaultHour, defaultMinute) {
  if (!timeText || typeof timeText !== 'string' || !timeText.includes(':')) {
    return new Date(
      baseDate.getFullYear(),
      baseDate.getMonth(),
      baseDate.getDate(),
      defaultHour,
      defaultMinute,
      0
    );
  }
  const [hourText, minuteText] = timeText.split(':');
  const hour = Number(hourText);
  const minute = Number(minuteText);
  if (Number.isNaN(hour) || Number.isNaN(minute)) {
    return new Date(
      baseDate.getFullYear(),
      baseDate.getMonth(),
      baseDate.getDate(),
      defaultHour,
      defaultMinute,
      0
    );
  }
  return new Date(
    baseDate.getFullYear(),
    baseDate.getMonth(),
    baseDate.getDate(),
    hour,
    minute,
    0
  );
}

function fullUpdate() {
  return {
    type: 'full',
    schema: renderCalendarPage()
  };
}
