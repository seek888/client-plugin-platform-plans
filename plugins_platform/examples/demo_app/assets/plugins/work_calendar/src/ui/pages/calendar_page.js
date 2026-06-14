import { calendarState } from '../../state/calendar_state.js';
import { getEventsForDate } from '../../services/calendar_service.js';
import { header } from '../components/header.js';
import { statsPanel } from '../components/stats_panel.js';
import { weekdayHeader, generateCalendarGrid } from '../components/calendar_grid.js';
import { selectedDayPanel } from '../components/event_list.js';
import { text } from '../tokens.js';

export function renderCalendarPage() {
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

function actionPanel() {
  return {
    type: 'card',
    children: [
      text('后续可扩展能力', 16, '#111827', '700'),
      text('创建/编辑日程、重复规则、提醒通知、审批与任务模块联动、联系人选择。', 13, '#4B5563', '400')
    ]
  };
}
