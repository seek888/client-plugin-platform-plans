import { calendarState } from '../../state/calendar_state.js';
import { countWeekTasks, getEventsForDate, meetingHoursForDate } from '../../services/calendar_service.js';
import { t } from '../../i18n.js';
import { text, sizedBox } from '../tokens.js';

export function statsPanel() {
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
