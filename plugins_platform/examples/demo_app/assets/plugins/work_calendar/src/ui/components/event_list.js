import { calendarState } from '../../state/calendar_state.js';
import { formatDate, formatTime } from '../../utils/date.js';
import { getCategoryName, getEventAttendees, getEventText, listSeparator, t } from '../../i18n.js';
import { text, sizedBox } from '../tokens.js';

export function selectedDayPanel(events) {
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

export function eventRow(evt) {
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
