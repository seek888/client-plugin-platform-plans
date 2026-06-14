import { createEvent } from '../services/calendar_service.js';

export const calendarState = {
  locale: 'zh-CN',
  currentDate: new Date(),
  selectedDate: new Date(),
  events: [],
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
}

function withI18n(event, titleKey, locationKey, attendeeKeys) {
  return {
    ...event,
    titleKey,
    locationKey,
    attendeeKeys
  };
}
