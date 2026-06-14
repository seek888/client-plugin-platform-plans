import { calendarState } from '../../state/calendar_state.js';
import { formatDate, formatTime } from '../../utils/date.js';
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

export function eventRow(evt) {
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
