import { calendarState } from '../../state/calendar_state.js';
import { getEventsForDate } from '../../services/calendar_service.js';
import { header } from '../components/header.js';
import { statsPanel } from '../components/stats_panel.js';
import { weekdayHeader, generateCalendarGrid } from '../components/calendar_grid.js';
import { selectedDayPanel } from '../components/event_list.js';
import { formatDate, formatTime } from '../../utils/date.js';
import { getCategoryName, listSeparator, t } from '../../i18n.js';
import { text, sizedBox } from '../tokens.js';

export function renderCalendarPage() {
  const year = calendarState.currentDate.getFullYear();
  const month = calendarState.currentDate.getMonth() + 1;
  const selectedEvents = getEventsForDate(calendarState.events, calendarState.selectedDate);

  return {
    schemaVersion: '1.0',
    type: 'page',
    title: t('plugin.name'),
    layout: {
      type: 'column',
      padding: '12,12,12,12',
      scrollable: true,
      crossAxisAlignment: 'stretch',
      spacing: 10
    },
    children: [
      header(year, month),
      statsPanel(),
      weekdayHeader(),
      {
        type: 'gridView',
        props: {
          crossAxisCount: 7,
          spacing: 6,
          childAspectRatio: 0.82
        },
        children: generateCalendarGrid()
      },
      selectedDayPanel(selectedEvents),
      editorPanel(),
      moduleTabs(),
      modulePanel()
    ]
  };
}

function editorPanel() {
  const draft = calendarState.draft;
  const attendees = draft.attendees || [];

  return {
    type: 'card',
    style: { margin: '2,0,10,0' },
    children: [
      text(t('calendar.editorTitle'), 17, '#111827', '700'),
      text(t('calendar.editorSubtitle'), 12, '#6B7280', '400'),
      formField('title', t('calendar.fieldTitle'), draft.title),
      formField('location', t('calendar.fieldLocation'), draft.location),
      timePickerField('startTime', t('calendar.fieldStartTime'), formatTime(new Date(draft.startTime))),
      timePickerField('endTime', t('calendar.fieldEndTime'), formatTime(new Date(draft.endTime))),
      formField('notes', t('calendar.fieldNotes'), draft.notes, true),
      optionRow([
        eventTypeButton('meeting'),
        eventTypeButton('task'),
        eventTypeButton('approval'),
        eventTypeButton('reminder')
      ]),
      repeatRow(),
      reminderRow(),
      attendees.length > 0
        ? text(t('calendar.attendees', { attendees: attendees.join(listSeparator()) }), 12, '#4B5563', '400')
        : text(t('contact.empty'), 12, '#9CA3AF', '400'),
      {
        type: 'row',
        children: [
          actionButton(t('calendar.pickContacts'), 'handlePickContacts'),
          sizedBox(8, 0),
          actionButton(t('calendar.save'), 'handleSaveEvent'),
          sizedBox(8, 0),
          dangerButton(t('calendar.delete'), 'handleDeleteEvent', { id: draft.id })
        ]
      }
    ]
  };
}

function timePickerField(field, label, value) {
  return {
    type: 'container',
    style: {
      backgroundColor: '#F9FAFB',
      borderRadius: 8,
      padding: '12,12,12,12',
      margin: '8,0,8,0'
    },
    events: { onTap: 'handlePickDateTime' },
    props: { field },
    children: [
      {
        type: 'column',
        props: { crossAxisAlignment: 'start', spacing: 4 },
        children: [
          text(label, 12, '#6B7280', '500'),
          text(value || '--:--', 14, '#111827', '400')
        ]
      }
    ]
  };
}

function formField(field, label, value, multiline) {
  return {
    type: multiline ? 'textarea' : 'textFormField',
    id: field,
    props: {
      label,
      hint: label,
      initialValue: value || '',
      maxLines: multiline ? 4 : 1,
      keyboardType: field === 'startTime' || field === 'endTime' ? 'text' : 'text'
    }
  };
}

function eventTypeButton(type) {
  const active = calendarState.draft.type === type;
  const category = calendarState.categories[type] || calendarState.categories.task;
  return {
    type: 'expanded',
    children: [
      {
        type: 'container',
        props: { field: 'type', value: type },
        style: {
          backgroundColor: active ? category.color : '#F3F4F6',
          borderRadius: 8,
          padding: '8,4,8,4',
          margin: '8,4,0,0'
        },
        events: { onTap: 'handleEditorChange' },
        children: [
          text(getCategoryName(type), 12, active ? '#FFFFFF' : '#374151', active ? '700' : '500', 'center')
        ]
      }
    ]
  };
}

function repeatRow() {
  return optionRow([
    repeatButton('none'),
    repeatButton('daily'),
    repeatButton('weekly'),
    repeatButton('monthly')
  ]);
}

function repeatButton(value) {
  const active = calendarState.draft.recurrence === value;
  return chipButton(
    t('calendar.recurrence.' + value),
    active,
    'handleToggleRepeat',
    { value }
  );
}

function reminderRow() {
  return optionRow([
    chipButton(t('calendar.reminder'), calendarState.draft.reminderEnabled, 'handleToggleReminder', { value: !calendarState.draft.reminderEnabled }),
    chipButton('5m', calendarState.draft.reminderMinutes === 5, 'handleChangeReminderMinutes', { value: 5 }),
    chipButton('15m', calendarState.draft.reminderMinutes === 15, 'handleChangeReminderMinutes', { value: 15 }),
    chipButton('30m', calendarState.draft.reminderMinutes === 30, 'handleChangeReminderMinutes', { value: 30 })
  ]);
}

function chipButton(label, active, handler, props) {
  return {
    type: 'expanded',
    children: [
      {
        type: 'container',
        props,
        style: {
          backgroundColor: active ? '#111827' : '#F3F4F6',
          borderRadius: 8,
          padding: '8,4,8,4',
          margin: '8,4,0,0'
        },
        events: { onTap: handler },
        children: [text(label, 12, active ? '#FFFFFF' : '#374151', active ? '700' : '500', 'center')]
      }
    ]
  };
}

function optionRow(children) {
  return {
    type: 'row',
    children
  };
}

function actionButton(label, handler, props) {
  return {
    type: 'expanded',
    children: [
      {
        type: 'button',
        props: { text: label, ...(props || {}) },
        events: { onTap: handler }
      }
    ]
  };
}

function dangerButton(label, handler, props) {
  return {
    type: 'expanded',
    children: [
      {
        type: 'container',
        props: props || {},
        style: {
          backgroundColor: '#FEE2E2',
          borderRadius: 8,
          padding: '10,4,10,4'
        },
        events: { onTap: handler },
        children: [text(label, 13, '#B91C1C', '700', 'center')]
      }
    ]
  };
}

function moduleTabs() {
  const modules = ['schedule', 'approval', 'task', 'contacts', 'notifications'];
  return {
    type: 'card',
    children: [
      text(t('calendar.modules'), 16, '#111827', '700'),
      {
        type: 'row',
        children: modules.map(moduleTab)
      }
    ]
  };
}

function moduleTab(module) {
  const active = calendarState.activeModule === module;
  return {
    type: 'expanded',
    children: [
      {
        type: 'container',
        props: { module },
        style: {
          backgroundColor: active ? '#DBEAFE' : '#F9FAFB',
          borderRadius: 8,
          padding: '8,2,8,2',
          margin: '8,2,0,0'
        },
        events: { onTap: 'handleSwitchModule' },
        children: [
          text(t('calendar.module.' + module), 11, active ? '#1D4ED8' : '#4B5563', active ? '700' : '500', 'center')
        ]
      }
    ]
  };
}

function modulePanel() {
  if (calendarState.activeModule === 'approval') {
    return approvalPanel();
  }
  if (calendarState.activeModule === 'task') {
    return taskPanel();
  }
  if (calendarState.activeModule === 'contacts') {
    return contactPanel();
  }
  if (calendarState.activeModule === 'notifications') {
    return notificationPanel();
  }
  return schedulePanel();
}

function schedulePanel() {
  return {
    type: 'card',
    children: [
      text(t('calendar.todaySchedule'), 16, '#111827', '700'),
      ...calendarState.events.slice(0, 4).map(item => text(item.title + ' / ' + getCategoryName(item.type), 13, '#4B5563', '400'))
    ]
  };
}

function approvalPanel() {
  return listPanel(
    t('approval.title'),
    calendarState.approvals,
    item => [
      text(item.title, 14, '#111827', '700'),
      text(t('approval.owner', { owner: item.owner }) + ' / ' + approvalStatus(item.status), 12, '#6B7280', '400'),
      {
        type: 'row',
        children: [
          actionButton(t('approval.approve'), 'handleApprovalAction', { id: item.id, action: 'approve' }),
          sizedBox(8, 0),
          actionButton(t('approval.reject'), 'handleApprovalAction', { id: item.id, action: 'reject' })
        ]
      }
    ],
    t('approval.empty')
  );
}

function taskPanel() {
  return listPanel(
    t('task.title'),
    calendarState.tasks,
    item => [
      text(item.title, 14, '#111827', '700'),
      text(t('task.status.' + item.status) + ' / ' + t('task.dueAt', { time: formatDate(new Date(item.dueAt)) }), 12, '#6B7280', '400'),
      {
        type: 'row',
        children: [
          actionButton(t('task.start'), 'handleTaskAction', { id: item.id, action: 'start' }),
          sizedBox(8, 0),
          actionButton(t('task.finish'), 'handleTaskAction', { id: item.id, action: 'done' })
        ]
      }
    ],
    t('task.empty')
  );
}

function contactPanel() {
  const items = (calendarState.draft.attendees || []).map((name, index) => ({
    id: calendarState.draft.attendeeIds[index] || name,
    name,
    department: ''
  }));
  return listPanel(
    t('contact.title'),
    items,
    item => [
      text(item.name, 14, '#111827', '700'),
      text(item.id, 12, '#6B7280', '400')
    ],
    t('contact.empty')
  );
}

function notificationPanel() {
  return listPanel(
    t('notification.title'),
    calendarState.notifications,
    item => [
      text(item.title, 14, '#111827', '700'),
      text(item.read ? t('notification.read') : t('notification.unread'), 12, '#6B7280', '400')
    ],
    t('notification.empty')
  );
}

function listPanel(title, items, renderItem, emptyText) {
  return {
    type: 'card',
    children: [
      text(title, 16, '#111827', '700'),
      ...(items.length === 0 ? [text(emptyText, 13, '#6B7280', '400')] : items.map(item => ({
        type: 'container',
        style: {
          backgroundColor: '#F9FAFB',
          borderRadius: 8,
          padding: '10,10,10,10',
          margin: '8,0,0,0'
        },
        children: renderItem(item)
      })))
    ]
  };
}

function approvalStatus(status) {
  if (status === 'approved') {
    return t('approval.status.approved');
  }
  if (status === 'rejected') {
    return t('approval.status.rejected');
  }
  return t('approval.status.pending');
}
