import { text } from '../tokens.js';

export function header(year, month) {
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
