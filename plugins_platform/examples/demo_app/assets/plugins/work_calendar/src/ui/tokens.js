export const colors = {
  text: '#111827',
  textMuted: '#6B7280',
  panel: '#F9FAFB',
  selected: '#DBEAFE',
  today: '#EFF6FF',
  white: '#FFFFFF'
};

export function text(value, size, color, weight, align) {
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

export function sizedBox(width, height) {
  return {
    type: 'sizedBox',
    props: { width: width, height: height }
  };
}
