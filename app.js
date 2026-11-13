const toast = document.querySelector('#toast');
let toastTimer;

function showToast(message) {
  toast.textContent = message;
  toast.classList.add('show');
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => toast.classList.remove('show'), 2600);
}

document.querySelectorAll('[data-action]').forEach((button) => {
  button.addEventListener('click', () => {
    const labels = {
      transfer: 'Tính năng chuyển tiền chỉ là minh hoạ trong bản demo.',
      bill: 'Tính năng thanh toán hoá đơn chỉ là minh hoạ trong bản demo.',
      topup: 'Tính năng nạp tiền chỉ là minh hoạ trong bản demo.',
      qr: 'Trình quét QR không được kết nối trong bản demo.'
    };
    showToast(labels[button.dataset.action]);
  });
});

const balanceValue = document.querySelector('#balanceValue');
document.querySelector('#toggleBalance').addEventListener('click', (event) => {
  const hidden = balanceValue.dataset.hidden === 'true';
  balanceValue.dataset.hidden = String(!hidden);
  balanceValue.innerHTML = hidden ? '24.680.000 <small>₫</small>' : '•••••••• <small>₫</small>';
  event.currentTarget.textContent = hidden ? '◉' : '◌';
});

document.querySelector('#viewAll').addEventListener('click', () => showToast('Đang hiển thị 4 giao dịch mẫu gần nhất.'));

document.querySelectorAll('.nav-item[data-section]').forEach((item) => {
  item.addEventListener('click', () => {
    document.querySelectorAll('.nav-item[data-section]').forEach((nav) => nav.classList.remove('active'));
    item.classList.add('active');
    if (item.dataset.section !== 'overview') {
      showToast(`${item.textContent.trim()} đang được phát triển trong bản demo.`);
    }
  });
});
