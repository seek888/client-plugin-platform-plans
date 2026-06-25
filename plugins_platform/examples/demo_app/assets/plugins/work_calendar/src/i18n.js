import { calendarState } from './state/calendar_state.js';

export const LOCALES = ['zh-CN', 'en-US'];

const messages = {
  'zh-CN': {
    'plugin.name': '工作日历',
    'plugin.description': '集成日程管理、会议安排、审批提醒',
    'language.switch': 'EN',
    'calendar.today': '今日',
    'calendar.weekTasks': '本周待办',
    'calendar.meetingHours': '会议时长',
    'calendar.itemUnit': '项',
    'calendar.todaySummary': '今日有 {count} 项日程',
    'calendar.monthLabel': '{year}年{month}月',
    'calendar.selectedDateTitle': '{date} 日程',
    'calendar.emptyDay': '暂无安排，可点击右上角创建跟进事项。',
    'calendar.location': '地点：{location}',
    'calendar.attendees': '参与人：{attendees}',
    'calendar.attendeeIds': '联系人ID：{ids}',
    'calendar.reminderTitle': '提醒：{title}',
    'calendar.reminderBody': '{time} | {location}',
    'calendar.locationTbd': '待确认',
    'calendar.toastEditStart': '已进入编辑模式',
    'calendar.toastSaved': '日程已保存',
    'calendar.toastDeleted': '日程已删除',
    'calendar.todaySchedule': '今日日程',
    'calendar.editorTitle': '编辑日程',
    'calendar.editorSubtitle': '创建、修改重复规则、提醒、审批联动与联系人',
    'calendar.fieldTitle': '标题',
    'calendar.fieldLocation': '地点',
    'calendar.fieldStartTime': '开始时间',
    'calendar.fieldEndTime': '结束时间',
    'calendar.fieldNotes': '备注',
    'calendar.save': '保存',
    'calendar.delete': '删除',
    'calendar.pickContacts': '选择联系人',
    'calendar.repeat': '重复规则',
    'calendar.reminder': '提醒',
    'calendar.pickerNotAvailable': '日期选择器不可用',
    'calendar.timeUpdated': '时间已更新',
    'calendar.recurrence.none': '不重复',
    'calendar.recurrence.daily': '每天',
    'calendar.recurrence.weekly': '每周',
    'calendar.recurrence.monthly': '每月',
    'calendar.modules': '模块',
    'calendar.module.schedule': '日程',
    'calendar.module.approval': '审批',
    'calendar.module.task': '任务',
    'calendar.module.contacts': '联系人',
    'calendar.module.notifications': '提醒',
    'approval.title': '审批模块',
    'approval.empty': '暂无审批事项',
    'approval.owner': '发起人：{owner}',
    'approval.status.pending': '待审批',
    'approval.status.approved': '已通过',
    'approval.status.rejected': '已拒绝',
    'approval.approve': '通过',
    'approval.reject': '拒绝',
    'approval.toastApproved': '审批已通过',
    'approval.toastRejected': '审批已拒绝',
    'task.title': '任务模块',
    'task.empty': '暂无任务',
    'task.dueAt': '截止：{time}',
    'task.status.open': '待办',
    'task.status.doing': '进行中',
    'task.status.done': '已完成',
    'task.start': '开始',
    'task.finish': '完成',
    'task.toastUpdated': '任务状态已更新',
    'contact.title': '联系人',
    'contact.search': '搜索联系人',
    'contact.empty': '暂无联系人',
    'contact.choose': '选中联系人',
    'contact.department': '部门：{department}',
    'notification.title': '提醒通知',
    'notification.empty': '暂无提醒',
    'notification.read': '已读',
    'notification.unread': '未读',
    'calendar.futureTitle': '后续可扩展能力',
    'calendar.futureDescription': '创建/编辑日程、重复规则、提醒通知、审批与任务模块联动、联系人选择。',
    'calendar.toastCreated': '已创建新日程',
    'category.meeting': '会议',
    'category.task': '任务',
    'category.approval': '审批',
    'category.reminder': '提醒',
    'category.businessTrip': '出差',
    'event.weeklyMeeting.title': '周例会',
    'event.weeklyMeeting.location': '会议室A',
    'event.weeklyMeeting.attendee1': '张三',
    'event.weeklyMeeting.attendee2': '李四',
    'event.weeklyMeeting.attendee3': '王五',
    'event.projectReview.title': '项目评审',
    'event.projectReview.location': '会议室B',
    'event.projectReview.attendee1': '产品',
    'event.projectReview.attendee2': '研发',
    'event.projectReview.attendee3': '审批人',
    'event.customerSync.title': '客户需求沟通',
    'event.customerSync.location': '线上会议',
    'event.customerSync.attendee1': '客户A',
    'event.customerSync.attendee2': '产品经理',
    'event.weeklyReport.title': '提交周报',
    'event.weeklyReport.location': '待办列表',
    'event.currentUser': '我',
    'event.contractApproval.title': '合同审批截止',
    'event.contractApproval.location': '审批中心',
    'event.contractApproval.attendee1': '法务',
    'event.businessTrip.title': '上海出差',
    'event.businessTrip.location': '上海',
    'event.businessTrip.attendee1': '销售一组',
    'event.newTask.title': '新建跟进事项',
    'event.newTask.location': '待确认',
    'event.newTask.notes': '从插件快速创建的临时事项'
  },
  'en-US': {
    'plugin.name': 'Work Calendar',
    'plugin.description': 'Manage schedules, meetings, and approval reminders',
    'language.switch': '中文',
    'calendar.today': 'Today',
    'calendar.weekTasks': 'This Week',
    'calendar.meetingHours': 'Meeting Hours',
    'calendar.itemUnit': ' items',
    'calendar.todaySummary': '{count} events today',
    'calendar.monthLabel': '{monthName} {year}',
    'calendar.selectedDateTitle': '{date} Schedule',
    'calendar.emptyDay': 'No events yet. Use the top-right action to create a follow-up.',
    'calendar.location': 'Location: {location}',
    'calendar.attendees': 'Attendees: {attendees}',
    'calendar.attendeeIds': 'Contact IDs: {ids}',
    'calendar.reminderTitle': 'Reminder: {title}',
    'calendar.reminderBody': '{time} | {location}',
    'calendar.locationTbd': 'TBD',
    'calendar.toastEditStart': 'Edit mode enabled',
    'calendar.toastSaved': 'Event saved',
    'calendar.toastDeleted': 'Event deleted',
    'calendar.todaySchedule': 'Today',
    'calendar.editorTitle': 'Edit Event',
    'calendar.editorSubtitle': 'Create, repeat, remind, approve, and assign contacts',
    'calendar.fieldTitle': 'Title',
    'calendar.fieldLocation': 'Location',
    'calendar.fieldStartTime': 'Start Time',
    'calendar.fieldEndTime': 'End Time',
    'calendar.fieldNotes': 'Notes',
    'calendar.save': 'Save',
    'calendar.delete': 'Delete',
    'calendar.pickContacts': 'Pick Contacts',
    'calendar.repeat': 'Repeat',
    'calendar.reminder': 'Reminder',
    'calendar.pickerNotAvailable': 'Picker not available',
    'calendar.timeUpdated': 'Time updated',
    'calendar.recurrence.none': 'None',
    'calendar.recurrence.daily': 'Daily',
    'calendar.recurrence.weekly': 'Weekly',
    'calendar.recurrence.monthly': 'Monthly',
    'calendar.modules': 'Modules',
    'calendar.module.schedule': 'Schedule',
    'calendar.module.approval': 'Approval',
    'calendar.module.task': 'Task',
    'calendar.module.contacts': 'Contacts',
    'calendar.module.notifications': 'Reminders',
    'approval.title': 'Approvals',
    'approval.empty': 'No approvals yet',
    'approval.owner': 'Owner: {owner}',
    'approval.status.pending': 'Pending',
    'approval.status.approved': 'Approved',
    'approval.status.rejected': 'Rejected',
    'approval.approve': 'Approve',
    'approval.reject': 'Reject',
    'approval.toastApproved': 'Approval approved',
    'approval.toastRejected': 'Approval rejected',
    'task.title': 'Tasks',
    'task.empty': 'No tasks yet',
    'task.dueAt': 'Due: {time}',
    'task.status.open': 'Open',
    'task.status.doing': 'Doing',
    'task.status.done': 'Done',
    'task.start': 'Start',
    'task.finish': 'Finish',
    'task.toastUpdated': 'Task updated',
    'contact.title': 'Contacts',
    'contact.search': 'Search contacts',
    'contact.empty': 'No contacts',
    'contact.choose': 'Selected Contacts',
    'contact.department': 'Department: {department}',
    'notification.title': 'Notifications',
    'notification.empty': 'No notifications',
    'notification.read': 'Read',
    'notification.unread': 'Unread',
    'calendar.futureTitle': 'Planned Extensions',
    'calendar.futureDescription': 'Create/edit events, recurrence rules, reminders, approval and task integrations, and contact selection.',
    'calendar.toastCreated': 'New event created',
    'category.meeting': 'Meeting',
    'category.task': 'Task',
    'category.approval': 'Approval',
    'category.reminder': 'Reminder',
    'category.businessTrip': 'Business Trip',
    'event.weeklyMeeting.title': 'Weekly Meeting',
    'event.weeklyMeeting.location': 'Room A',
    'event.weeklyMeeting.attendee1': 'Alex Zhang',
    'event.weeklyMeeting.attendee2': 'Li Li',
    'event.weeklyMeeting.attendee3': 'Wang Wei',
    'event.projectReview.title': 'Project Review',
    'event.projectReview.location': 'Room B',
    'event.projectReview.attendee1': 'Product',
    'event.projectReview.attendee2': 'Engineering',
    'event.projectReview.attendee3': 'Approver',
    'event.customerSync.title': 'Customer Requirements Sync',
    'event.customerSync.location': 'Online Meeting',
    'event.customerSync.attendee1': 'Customer A',
    'event.customerSync.attendee2': 'Product Manager',
    'event.weeklyReport.title': 'Submit Weekly Report',
    'event.weeklyReport.location': 'Task List',
    'event.currentUser': 'Me',
    'event.contractApproval.title': 'Contract Approval Deadline',
    'event.contractApproval.location': 'Approval Center',
    'event.contractApproval.attendee1': 'Legal',
    'event.businessTrip.title': 'Shanghai Business Trip',
    'event.businessTrip.location': 'Shanghai',
    'event.businessTrip.attendee1': 'Sales Team 1',
    'event.newTask.title': 'New Follow-up',
    'event.newTask.location': 'TBD',
    'event.newTask.notes': 'Temporary event created from the plugin'
  }
};

const monthNames = {
  'zh-CN': ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
  'en-US': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
};

const weekdayNames = {
  'zh-CN': ['日', '一', '二', '三', '四', '五', '六'],
  'en-US': ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
};

export function t(key, params) {
  const locale = calendarState.locale || 'zh-CN';
  const template = (messages[locale] && messages[locale][key]) || messages['zh-CN'][key] || key;
  if (!params) {
    return template;
  }
  return template.replace(/\{(\w+)\}/g, (_, name) => {
    return params[name] === undefined ? '' : String(params[name]);
  });
}

export function toggleLocale() {
  const index = LOCALES.indexOf(calendarState.locale);
  calendarState.locale = LOCALES[(index + 1) % LOCALES.length];
}

export function formatMonthLabel(year, month) {
  const locale = calendarState.locale || 'zh-CN';
  return t('calendar.monthLabel', {
    year,
    month,
    monthName: monthNames[locale][month - 1]
  });
}

export function getWeekdayNames() {
  return weekdayNames[calendarState.locale || 'zh-CN'];
}

export function getCategoryName(type) {
  return t('category.' + type);
}

export function getEventText(evt, field) {
  const key = evt[field + 'Key'];
  return key ? t(key) : evt[field];
}

export function getEventAttendees(evt) {
  if (evt.attendeeKeys) {
    return evt.attendeeKeys.map(key => t(key));
  }
  return evt.attendees || [];
}

export function listSeparator() {
  return (calendarState.locale || 'zh-CN') === 'zh-CN' ? '、' : ', ';
}
