// Work calendar plugin runtime bundle.
// Generated from src/* for the current single-bundle QuickJS runtime.

let calendarState = {
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
    type: 'task',
    startTime: new Date(base.getFullYear(), base.getMonth(), base.getDate(), 17, 0, 0).toISOString(),
    endTime: new Date(base.getFullYear(), base.getMonth(), base.getDate(), 18, 0, 0).toISOString(),
    location: '待确认',
    attendees: ['我'],
    notes: '从插件快速创建的临时事项'
  });
  showToast('已创建新日程');
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
    title: '工作日历',
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
      text('工作日历', 18, '#111827', '700'),
      text('今日有 ' + todayEvents.length + ' 项日程', 14, '#4B5563', '400'),
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
            children: [text('工作日历', 22, '#111827', '700')]
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
              text(year + '年' + month + '月', 18, '#1F2937', '700', 'center')
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
  return {
    type: 'row',
    children: [
      statCard('今日', getEventsForDate(calendarState.events, new Date()).length + '项', '#2563EB'),
      sizedBox(8, 0),
      statCard('本周待办', String(countWeekTasks(calendarState.events)), '#16A34A'),
      sizedBox(8, 0),
      statCard('会议时长', meetingHoursForDate(calendarState.events, new Date()) + 'h', '#EA580C')
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
  const names = ['日', '一', '二', '三', '四', '五', '六'];
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
      text(evt.title, 9, '#FFFFFF', '500', 'center')
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
            children: [text(dateLabel + ' 日程', 17, '#111827', '700')]
          },
          text(events.length + '项', 13, '#6B7280', '500')
        ]
      },
      ...(events.length === 0
        ? [text('暂无安排，可点击右上角创建跟进事项。', 14, '#6B7280', '400')]
        : events.map(eventRow))
    ]
  };
}

function eventRow(evt) {
  const category = calendarState.categories[evt.type] || calendarState.categories.task;
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
              text(evt.title, 15, '#111827', '700'),
              text(formatTime(start) + '-' + formatTime(end) + ' / ' + category.name, 12, '#6B7280', '400')
            ]
          }
        ]
      },
      evt.location ? text('地点：' + evt.location, 12, '#6B7280', '400') : text('', 1, '#FFFFFF', '400'),
      evt.attendees ? text('参与人：' + evt.attendees.join('、'), 12, '#6B7280', '400') : text('', 1, '#FFFFFF', '400')
    ]
  };
}

function actionPanel() {
  return {
    type: 'card',
    children: [
      text('后续可扩展能力', 16, '#111827', '700'),
      text('创建/编辑日程、重复规则、提醒通知、审批与任务模块联动、联系人选择。', 13, '#4B5563', '400')
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

function ensureCalendarData() {
  if (calendarState.events.length > 0) {
    return;
  }

  const today = new Date();
  const y = today.getFullYear();
  const m = today.getMonth();
  const d = today.getDate();

  calendarState.events = [
    createCalendarEvent('evt_1', '周例会', 'meeting', y, m, d, 9, 0, 10, 0, '会议室A', ['张三', '李四', '王五']),
    createCalendarEvent('evt_2', '项目评审', 'approval', y, m, d, 14, 0, 15, 30, '会议室B', ['产品', '研发', '审批人']),
    createCalendarEvent('evt_3', '客户需求沟通', 'meeting', y, m, d, 16, 0, 17, 0, '线上会议', ['客户A', '产品经理']),
    createCalendarEvent('evt_4', '提交周报', 'task', y, m, d + 1, 12, 0, 18, 0, '待办列表', ['我']),
    createCalendarEvent('evt_5', '合同审批截止', 'reminder', y, m, d + 2, 11, 0, 11, 30, '审批中心', ['法务']),
    createCalendarEvent('evt_6', '上海出差', 'businessTrip', y, m, d + 5, 9, 0, 18, 0, '上海', ['销售一组'])
  ];
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
