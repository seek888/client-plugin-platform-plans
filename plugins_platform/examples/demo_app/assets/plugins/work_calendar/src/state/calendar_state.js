import { createEvent } from '../services/calendar_service.js';

export const calendarState = {
  locale: 'zh-CN',
  currentDate: new Date(),
  selectedDate: new Date(),
  selectedEventId: null,
  editorMode: 'create',
  editorKey: 'draft_default',
  activeModule: 'schedule',
  events: [],
  approvals: [],
  tasks: [],
  contacts: [],
  notifications: [],
  draft: {
    id: 'draft_default',
    title: '新建跟进事项',
    type: 'task',
    startTime: '',
    endTime: '',
    location: '',
    attendees: [],
    attendeeIds: [],
    notes: '',
    recurrence: 'none',
    reminderEnabled: true,
    reminderMinutes: 15,
    approvalStatus: 'draft',
    taskStatus: 'open'
  },
  categories: {
    meeting: { name: '会议', color: '#2563EB' },
    task: { name: '任务', color: '#16A34A' },
    approval: { name: '审批', color: '#EA580C' },
    reminder: { name: '提醒', color: '#DC2626' },
    businessTrip: { name: '出差', color: '#7C3AED' }
  }
};

export function ensureCalendarData() {
  if (calendarState.events.length > 0) {
    return;
  }

  const today = new Date();
  const y = today.getFullYear();
  const m = today.getMonth();
  const d = today.getDate();

  calendarState.events = [
    withI18n(
      createEvent('evt_1', '周例会', 'meeting', y, m, d, 9, 0, 10, 0, '会议室A', ['张三', '李四', '王五']),
      'event.weeklyMeeting.title',
      'event.weeklyMeeting.location',
      ['event.weeklyMeeting.attendee1', 'event.weeklyMeeting.attendee2', 'event.weeklyMeeting.attendee3']
    ),
    withI18n(
      createEvent('evt_2', '项目评审', 'approval', y, m, d, 14, 0, 15, 30, '会议室B', ['产品', '研发', '审批人']),
      'event.projectReview.title',
      'event.projectReview.location',
      ['event.projectReview.attendee1', 'event.projectReview.attendee2', 'event.projectReview.attendee3']
    ),
    withI18n(
      createEvent('evt_3', '客户需求沟通', 'meeting', y, m, d, 16, 0, 17, 0, '线上会议', ['客户A', '产品经理']),
      'event.customerSync.title',
      'event.customerSync.location',
      ['event.customerSync.attendee1', 'event.customerSync.attendee2']
    ),
    withI18n(
      createEvent('evt_4', '提交周报', 'task', y, m, d + 1, 12, 0, 18, 0, '待办列表', ['我']),
      'event.weeklyReport.title',
      'event.weeklyReport.location',
      ['event.currentUser']
    ),
    withI18n(
      createEvent('evt_5', '合同审批截止', 'reminder', y, m, d + 2, 11, 0, 11, 30, '审批中心', ['法务']),
      'event.contractApproval.title',
      'event.contractApproval.location',
      ['event.contractApproval.attendee1']
    ),
    withI18n(
      createEvent('evt_6', '上海出差', 'businessTrip', y, m, d + 5, 9, 0, 18, 0, '上海', ['销售一组']),
      'event.businessTrip.title',
      'event.businessTrip.location',
      ['event.businessTrip.attendee1']
    )
  ];

  calendarState.approvals = [
    {
      id: 'apr_1',
      title: '合同审批',
      owner: '法务',
      status: 'pending',
      createdAt: new Date(y, m, d - 1, 10, 0, 0).toISOString()
    },
    {
      id: 'apr_2',
      title: '出差申请',
      owner: '销售一组',
      status: 'approved',
      createdAt: new Date(y, m, d - 2, 15, 0, 0).toISOString()
    }
  ];

  calendarState.tasks = [
    {
      id: 'task_1',
      title: '补充会议纪要',
      status: 'open',
      dueAt: new Date(y, m, d + 1, 18, 0, 0).toISOString()
    },
    {
      id: 'task_2',
      title: '确认审批附件',
      status: 'doing',
      dueAt: new Date(y, m, d + 2, 12, 0, 0).toISOString()
    }
  ];

  calendarState.notifications = [
    {
      id: 'ntf_1',
      title: '待审批提醒',
      read: false
    }
  ];

  if (calendarState.events.length > 0) {
    calendarState.selectedEventId = calendarState.events[0].id;
    calendarState.draft = cloneEvent(calendarState.events[0]);
    calendarState.editorKey = calendarState.draft.id;
    calendarState.editorMode = 'edit';
  }
}

function withI18n(event, titleKey, locationKey, attendeeKeys) {
  return {
    ...event,
    titleKey,
    locationKey,
    attendeeKeys
  };
}

export function cloneEvent(event, fallbackId) {
  const start = new Date(event.startTime);
  const end = new Date(event.endTime);
  const id = fallbackId || event.id || `draft_${Date.now()}`;
  return {
    id,
    title: event.title,
    titleKey: event.titleKey,
    type: event.type,
    startTime: start.toISOString(),
    endTime: end.toISOString(),
    location: event.location || '',
    locationKey: event.locationKey,
    attendees: [...(event.attendees || [])],
    attendeeKeys: [...(event.attendeeKeys || [])],
    attendeeIds: [...(event.attendeeIds || [])],
    notes: event.notes || '',
    notesKey: event.notesKey,
    recurrence: event.recurrence || 'none',
    reminderEnabled: event.reminderEnabled !== false,
    reminderMinutes: event.reminderMinutes ?? 15,
    approvalStatus: event.approvalStatus || 'draft',
    taskStatus: event.taskStatus || 'open'
  };
}

export function createDraft(baseDate, eventId) {
  const start = new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate(), 9, 0, 0);
  const end = new Date(baseDate.getFullYear(), baseDate.getMonth(), baseDate.getDate(), 10, 0, 0);
  return {
    id: eventId || `draft_${Date.now()}`,
    title: '新建跟进事项',
    type: 'task',
    startTime: start.toISOString(),
    endTime: end.toISOString(),
    location: '',
    attendees: [],
    attendeeIds: [],
    notes: '',
    recurrence: 'none',
    reminderEnabled: true,
    reminderMinutes: 15,
    approvalStatus: 'draft',
    taskStatus: 'open'
  };
}
