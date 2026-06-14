import { calendarState } from '../../state/calendar_state.js';
import { getEventsForDate } from '../../services/calendar_service.js';
import { header } from '../components/header.js';
import { statsPanel } from '../components/stats_panel.js';
import { weekdayHeader, generateCalendarGrid } from '../components/calendar_grid.js';
import { selectedDayPanel } from '../components/event_list.js';
import { t } from '../../i18n.js';
import { text } from '../tokens.js';

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
      text(t('calendar.futureTitle'), 16, '#111827', '700'),
      text(t('calendar.futureDescription'), 13, '#4B5563', '400')
    ]
  };
}
