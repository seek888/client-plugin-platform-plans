// Work calendar plugin runtime bundle.
// Generated from src/* for the current single-bundle QuickJS runtime.

let calendarState = {
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

const LOCALES = ['zh-CN', 'en-US'];

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

function onActivate() {
  ensureCalendarData();
}

function onDeactivate() {}

function renderPage() {
  ensureCalendarData();
  return renderCalendarPage();
}

function renderCard() {
  ensureCalendarData();
  return renderTodayCard();
}

function handleGoToday() {
  calendarState.currentDate = new Date();
  calendarState.selectedDate = new Date();
  return fullUpdate();
}

function handlePreviousMonth() {
  calendarState.currentDate = new Date(
    calendarState.currentDate.getFullYear(),
    calendarState.currentDate.getMonth() - 1,
    1
  );
  calendarState.selectedDate = new Date(calendarState.currentDate);
  return fullUpdate();
}

function handleNextMonth() {
  calendarState.currentDate = new Date(
    calendarState.currentDate.getFullYear(),
    calendarState.currentDate.getMonth() + 1,
    1
  );
  calendarState.selectedDate = new Date(calendarState.currentDate);
  return fullUpdate();
}

function handleDateClick(state) {
  const date = state && state.props ? state.props.date : null;
  if (date) {
    calendarState.selectedDate = parseDate(date);
  }
  return fullUpdate();
}

function handleCreateEvent() {
  const base = calendarState.selectedDate || new Date();
  const id = 'evt_' + (calendarState.events.length + 1);
  calendarState.events.push({
    id,
    title: '新建跟进事项',
    titleKey: 'event.newTask.title',
    type: 'task',
    startTime: new Date(base.getFullYear(), base.getMonth(), base.getDate(), 17, 0, 0).toISOString(),
    endTime: new Date(base.getFullYear(), base.getMonth(), base.getDate(), 18, 0, 0).toISOString(),
    location: '待确认',
    locationKey: 'event.newTask.location',
    attendees: ['我'],
    attendeeKeys: ['event.currentUser'],
    notes: '从插件快速创建的临时事项',
    notesKey: 'event.newTask.notes'
  });
  showToast(t('calendar.toastCreated'));
  return fullUpdate();
}

function handleToggleLocale() {
  toggleLocale();
  return fullUpdate();
}

function handleFilter() {
  return fullUpdate();
}

function handleEventDetail() {
  return fullUpdate();
}

function fullUpdate() {
  return {
    type: 'full',
    schema: renderCalendarPage()
  };
}

function renderCalendarPage() {
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
      crossAxisAlignment: 'stretch'
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
      actionPanel()
    ]
  };
}

function renderTodayCard() {
  const todayEvents = getEventsForDate(calendarState.events, new Date());
  return {
    schemaVersion: '1.0',
    type: 'card',
    children: [
      text(t('plugin.name'), 18, '#111827', '700'),
      text(t('calendar.todaySummary', { count: todayEvents.length }), 14, '#4B5563', '400'),
      ...todayEvents.slice(0, 3).map(eventRow)
    ]
  };
}

function header(year, month) {
  return {
    type: 'card',
    style: { margin: '0,0,12,0' },
    children: [
      {
        type: 'row',
        children: [
          {
            type: 'expanded',
            children: [text(t('plugin.name'), 22, '#111827', '700')]
          },
          {
            type: 'button',
            props: { text: t('language.switch') },
            style: { margin: '0,6,0,0' },
            events: { onTap: 'handleToggleLocale' }
          },
          {
            type: 'iconButton',
            props: { icon: 'Icons.today' },
            events: { onTap: 'handleGoToday' }
          },
          {
            type: 'iconButton',
            props: { icon: 'Icons.event' },
            events: { onTap: 'handleCreateEvent' }
          }
        ]
      },
      {
        type: 'row',
        children: [
          {
            type: 'iconButton',
            props: { icon: 'Icons.chevron_left' },
            events: { onTap: 'handlePreviousMonth' }
          },
          {
            type: 'expanded',
            children: [
              text(formatMonthLabel(year, month), 18, '#1F2937', '700', 'center')
            ]
          },
          {
            type: 'iconButton',
            props: { icon: 'Icons.chevron_right' },
            events: { onTap: 'handleNextMonth' }
          }
        ]
      }
    ]
  };
}

function statsPanel() {
  const todayCount = getEventsForDate(calendarState.events, new Date()).length;
  return {
    type: 'row',
    children: [
      statCard(t('calendar.today'), todayCount + t('calendar.itemUnit'), '#2563EB'),
      sizedBox(8, 0),
      statCard(t('calendar.weekTasks'), String(countWeekTasks(calendarState.events)), '#16A34A'),
      sizedBox(8, 0),
      statCard(t('calendar.meetingHours'), meetingHoursForDate(calendarState.events, new Date()) + 'h', '#EA580C')
    ]
  };
}

function statCard(label, value, color) {
  return {
    type: 'expanded',
    children: [
      {
        type: 'container',
        style: {
          backgroundColor: '#F9FAFB',
          borderRadius: 8,
          padding: '10,8,10,8',
          margin: '0,0,12,0'
        },
        children: [
          text(value, 18, color, '700', 'center'),
          text(label, 12, '#6B7280', '400', 'center')
        ]
      }
    ]
  };
}

function weekdayHeader() {
  const names = getWeekdayNames();
  return {
    type: 'row',
    children: names.map(name => ({
      type: 'expanded',
      children: [text(name, 12, '#6B7280', '600', 'center')]
    }))
  };
}

function generateCalendarGrid() {
  const year = calendarState.currentDate.getFullYear();
  const month = calendarState.currentDate.getMonth();
  const firstDay = new Date(year, month, 1);
  const totalDays = new Date(year, month + 1, 0).getDate();
  const grid = [];

  for (let i = 0; i < firstDay.getDay(); i++) {
    grid.push(emptyCell());
  }

  for (let day = 1; day <= totalDays; day++) {
    const date = new Date(year, month, day);
    grid.push(dayCell(date));
  }

  while (grid.length % 7 !== 0) {
    grid.push(emptyCell());
  }

  return grid;
}

function emptyCell() {
  return {
    type: 'container',
    style: { backgroundColor: '#F9FAFB', borderRadius: 8 }
  };
}

function dayCell(date) {
  const events = getEventsForDate(calendarState.events, date);
  const isToday = sameDay(date, new Date());
  const selected = sameDay(date, calendarState.selectedDate);
  const color = selected ? '#DBEAFE' : (isToday ? '#EFF6FF' : '#FFFFFF');

  return {
    type: 'container',
    props: { date: formatDate(date) },
    style: {
      backgroundColor: color,
      borderRadius: 8,
      padding: '6,4,6,4'
    },
    events: { onTap: 'handleDateClick' },
    children: [
      text(String(date.getDate()), 13, selected ? '#1D4ED8' : '#111827', selected ? '700' : '500', 'center'),
      ...events.slice(0, 2).map(eventDot),
      events.length > 2 ? text('+' + (events.length - 2), 10, '#6B7280', '500', 'center') : text('', 10, '#6B7280', '400', 'center')
    ]
  };
}

function eventDot(evt) {
  const category = calendarState.categories[evt.type] || calendarState.categories.task;
  return {
    type: 'container',
    style: {
      backgroundColor: category.color,
      borderRadius: 4,
      padding: '2,2,2,2',
      margin: '2,0,0,0'
    },
    children: [
      text(getEventText(evt, 'title'), 9, '#FFFFFF', '500', 'center')
    ]
  };
}

function selectedDayPanel(events) {
  const dateLabel = formatDate(calendarState.selectedDate);
  return {
    type: 'card',
    style: { margin: '12,0,12,0' },
    children: [
      {
        type: 'row',
        children: [
          {
            type: 'expanded',
            children: [text(t('calendar.selectedDateTitle', { date: dateLabel }), 17, '#111827', '700')]
          },
          text(events.length + t('calendar.itemUnit'), 13, '#6B7280', '500')
        ]
      },
      ...(events.length === 0
        ? [text(t('calendar.emptyDay'), 14, '#6B7280', '400')]
        : events.map(eventRow))
    ]
  };
}

function eventRow(evt) {
  const category = calendarState.categories[evt.type] || calendarState.categories.task;
  const location = getEventText(evt, 'location');
  const attendees = getEventAttendees(evt);
  const start = new Date(evt.startTime);
  const end = new Date(evt.endTime);

  return {
    type: 'container',
    style: {
      backgroundColor: '#F9FAFB',
      borderRadius: 8,
      padding: '10,10,10,10',
      margin: '8,0,0,0'
    },
    children: [
      {
        type: 'row',
        children: [
          {
            type: 'container',
            style: {
              backgroundColor: category.color,
              borderRadius: 3,
              width: 5,
              height: 38
            }
          },
          sizedBox(8, 0),
          {
            type: 'expanded',
            children: [
              text(getEventText(evt, 'title'), 15, '#111827', '700'),
              text(formatTime(start) + '-' + formatTime(end) + ' / ' + getCategoryName(evt.type), 12, '#6B7280', '400')
            ]
          }
        ]
      },
      location ? text(t('calendar.location', { location }), 12, '#6B7280', '400') : text('', 1, '#FFFFFF', '400'),
      attendees.length > 0 ? text(t('calendar.attendees', { attendees: attendees.join(listSeparator()) }), 12, '#6B7280', '400') : text('', 1, '#FFFFFF', '400')
    ]
  };
}

function actionPanel() {
  return {
    type: 'card',
    children: [
      text(t('calendar.futureTitle'), 16, '#111827', '700'),
      text(t('calendar.futureDescription'), 13, '#4B5563', '400')
    ]
  };
}

function text(value, size, color, weight, align) {
  return {
    type: 'text',
    props: { text: value },
    style: {
      fontSize: size,
      color: color,
      fontWeight: weight || '400',
      textAlign: align || 'start'
    }
  };
}

function sizedBox(width, height) {
  return {
    type: 'sizedBox',
    props: { width: width, height: height }
  };
}

function t(key, params) {
  const locale = calendarState.locale || 'zh-CN';
  const template = (messages[locale] && messages[locale][key]) || messages['zh-CN'][key] || key;
  if (!params) {
    return template;
  }
  return template.replace(/\{(\w+)\}/g, function(_, name) {
    return params[name] === undefined ? '' : String(params[name]);
  });
}

function toggleLocale() {
  const index = LOCALES.indexOf(calendarState.locale);
  calendarState.locale = LOCALES[(index + 1) % LOCALES.length];
}

function formatMonthLabel(year, month) {
  const locale = calendarState.locale || 'zh-CN';
  return t('calendar.monthLabel', {
    year,
    month,
    monthName: monthNames[locale][month - 1]
  });
}

function getWeekdayNames() {
  return weekdayNames[calendarState.locale || 'zh-CN'];
}

function getCategoryName(type) {
  return t('category.' + type);
}

function getEventText(evt, field) {
  const key = evt[field + 'Key'];
  return key ? t(key) : evt[field];
}

function getEventAttendees(evt) {
  if (evt.attendeeKeys) {
    return evt.attendeeKeys.map(key => t(key));
  }
  return evt.attendees || [];
}

function listSeparator() {
  return (calendarState.locale || 'zh-CN') === 'zh-CN' ? '、' : ', ';
}

function ensureCalendarData() {
  if (calendarState.events.length > 0) {
    return;
  }

  const today = new Date();
  const y = today.getFullYear();
  const m = today.getMonth();
  const d = today.getDate();

  calendarState.events = [
    withI18n(
      createCalendarEvent('evt_1', '周例会', 'meeting', y, m, d, 9, 0, 10, 0, '会议室A', ['张三', '李四', '王五']),
      'event.weeklyMeeting.title',
      'event.weeklyMeeting.location',
      ['event.weeklyMeeting.attendee1', 'event.weeklyMeeting.attendee2', 'event.weeklyMeeting.attendee3']
    ),
    withI18n(
      createCalendarEvent('evt_2', '项目评审', 'approval', y, m, d, 14, 0, 15, 30, '会议室B', ['产品', '研发', '审批人']),
      'event.projectReview.title',
      'event.projectReview.location',
      ['event.projectReview.attendee1', 'event.projectReview.attendee2', 'event.projectReview.attendee3']
    ),
    withI18n(
      createCalendarEvent('evt_3', '客户需求沟通', 'meeting', y, m, d, 16, 0, 17, 0, '线上会议', ['客户A', '产品经理']),
      'event.customerSync.title',
      'event.customerSync.location',
      ['event.customerSync.attendee1', 'event.customerSync.attendee2']
    ),
    withI18n(
      createCalendarEvent('evt_4', '提交周报', 'task', y, m, d + 1, 12, 0, 18, 0, '待办列表', ['我']),
      'event.weeklyReport.title',
      'event.weeklyReport.location',
      ['event.currentUser']
    ),
    withI18n(
      createCalendarEvent('evt_5', '合同审批截止', 'reminder', y, m, d + 2, 11, 0, 11, 30, '审批中心', ['法务']),
      'event.contractApproval.title',
      'event.contractApproval.location',
      ['event.contractApproval.attendee1']
    ),
    withI18n(
      createCalendarEvent('evt_6', '上海出差', 'businessTrip', y, m, d + 5, 9, 0, 18, 0, '上海', ['销售一组']),
      'event.businessTrip.title',
      'event.businessTrip.location',
      ['event.businessTrip.attendee1']
    )
  ];
}

function withI18n(event, titleKey, locationKey, attendeeKeys) {
  event.titleKey = titleKey;
  event.locationKey = locationKey;
  event.attendeeKeys = attendeeKeys;
  return event;
}

function createCalendarEvent(id, title, type, y, m, d, sh, sm, eh, em, location, attendees) {
  return {
    id,
    title,
    type,
    startTime: new Date(y, m, d, sh, sm, 0).toISOString(),
    endTime: new Date(y, m, d, eh, em, 0).toISOString(),
    location,
    attendees
  };
}

function getEventsForDate(events, date) {
  const key = formatDate(date);
  return events.filter(evt => evt.startTime.substring(0, 10) === key);
}

function countWeekTasks(events) {
  const today = new Date();
  const start = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay());
  const end = new Date(start.getFullYear(), start.getMonth(), start.getDate() + 7);
  return events.filter(evt => {
    const date = new Date(evt.startTime);
    return date >= start && date < end && evt.type === 'task';
  }).length;
}

function meetingHoursForDate(events, date) {
  return getEventsForDate(events, date)
    .filter(evt => evt.type === 'meeting')
    .reduce((sum, evt) => {
      return sum + (new Date(evt.endTime) - new Date(evt.startTime)) / 3600000;
    }, 0);
}

function showToast(message) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('toast.show', { message });
}

function parseDate(value) {
  const parts = value.split('-').map(part => Number(part));
  return new Date(parts[0], parts[1] - 1, parts[2]);
}

function formatDate(date) {
  return date.getFullYear() + '-' +
    String(date.getMonth() + 1).padStart(2, '0') + '-' +
    String(date.getDate()).padStart(2, '0');
}

function formatTime(date) {
  return String(date.getHours()).padStart(2, '0') + ':' +
    String(date.getMinutes()).padStart(2, '0');
}

function sameDay(left, right) {
  return formatDate(left) === formatDate(right);
}
