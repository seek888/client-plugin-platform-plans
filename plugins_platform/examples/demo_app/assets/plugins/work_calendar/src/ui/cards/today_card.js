import { calendarState } from '../../state/calendar_state.js';
import { getEventsForDate } from '../../services/calendar_service.js';
import { eventRow } from '../components/event_list.js';
import { text } from '../tokens.js';

export function renderTodayCard() {
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
