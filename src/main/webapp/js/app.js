/* ================================================================
   DEADLY SHOP — Frontend JavaScript
   ================================================================ */

'use strict';

/* ── Mobile Nav Toggle ── */
function toggleMobileNav() {
  const links = document.querySelector('.ds-nav-links');
  if (!links) return;
  links.style.display = links.style.display === 'flex' ? 'none' : 'flex';
  links.style.flexDirection = 'column';
  links.style.position = 'absolute';
  links.style.top = '60px';
  links.style.right = '20px';
  links.style.background = '#16213e';
  links.style.border = '1px solid #2a2a4a';
  links.style.borderRadius = '12px';
  links.style.padding = '14px 20px';
  links.style.gap = '12px';
  links.style.zIndex = '999';
}

/* ── Add to Cart via AJAX (used on product pages) ── */
function addToCartAjax(productId, qty) {
  const cp = getContextPath();
  fetch(cp + '/cart', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    },
    body: 'action=add&productId=' + productId + '&qty=' + (qty || 1)
  })
  .then(r => r.json())
  .then(data => {
    if (data.success) {
      updateCartBadge(data.cartCount);
      showToast('Added to cart!', 'success');
    } else {
      showToast('Could not add to cart.', 'error');
    }
  })
  .catch(() => showToast('Network error.', 'error'));
}

/* ── Update Cart Badge Count ── */
function updateCartBadge(count) {
  const badge = document.querySelector('.ds-cart-badge');
  if (count > 0) {
    if (badge) {
      badge.textContent = count;
    } else {
      const cartBtn = document.querySelector('.ds-cart-btn');
      if (cartBtn) {
        const span = document.createElement('span');
        span.className = 'ds-cart-badge';
        span.textContent = count;
        cartBtn.appendChild(span);
      }
    }
  } else if (badge) {
    badge.remove();
  }
}

/* ── Toast Notification ── */
function showToast(message, type) {
  const existing = document.querySelector('.ds-toast');
  if (existing) existing.remove();

  const toast = document.createElement('div');
  toast.className = 'ds-toast ds-toast-' + (type || 'success');
  toast.textContent = message;
  toast.style.cssText = `
    position: fixed;
    bottom: 30px;
    right: 24px;
    z-index: 9999;
    background: ${type === 'error' ? '#c0392b' : '#27ae60'};
    color: #fff;
    padding: 13px 22px;
    border-radius: 50px;
    font-weight: 600;
    font-size: .92rem;
    box-shadow: 0 6px 24px rgba(0,0,0,.4);
    animation: slideUp .3s ease;
    font-family: 'Segoe UI', sans-serif;
  `;
  document.body.appendChild(toast);
  setTimeout(() => toast.remove(), 3000);
}

/* ── Inject CSS for Toast Animation ── */
(function injectToastCSS() {
  const s = document.createElement('style');
  s.textContent = `
    @keyframes slideUp {
      from { opacity:0; transform:translateY(20px); }
      to   { opacity:1; transform:translateY(0); }
    }
  `;
  document.head.appendChild(s);
})();

/* ── Get Context Path from meta or default ── */
function getContextPath() {
  const meta = document.querySelector('meta[name="ctx"]');
  return meta ? meta.getAttribute('content') : '';
}

/* ── Fetch Cart Count on Load ── */
document.addEventListener('DOMContentLoaded', function () {
  const userId = document.body.getAttribute('data-user');
  if (userId) {
    const cp = getContextPath();
    fetch(cp + '/cart', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json'
      },
      body: 'action=count'
    })
    .then(r => r.json())
    .then(data => updateCartBadge(data.cartCount))
    .catch(() => {});
  }

  /* Smooth scroll for anchor links */
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', function (e) {
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth' });
      }
    });
  });

  /* Auto-dismiss alerts */
  document.querySelectorAll('.ds-alert').forEach(el => {
    setTimeout(() => {
      el.style.transition = 'opacity .6s';
      el.style.opacity = '0';
      setTimeout(() => el.remove(), 600);
    }, 5000);
  });

  /* Product image zoom on hover */
  document.querySelectorAll('.ds-detail-img-wrap img').forEach(img => {
    img.addEventListener('mouseenter', () => img.style.transform = 'scale(1.03)');
    img.addEventListener('mouseleave', () => img.style.transform = 'scale(1)');
    img.style.transition = 'transform .35s ease';
  });

  /* Confirm before form submits with data-confirm attr */
  document.querySelectorAll('form[data-confirm]').forEach(form => {
    form.addEventListener('submit', function (e) {
      if (!confirm(this.getAttribute('data-confirm'))) e.preventDefault();
    });
  });

  /* Admin status select highlight */
  document.querySelectorAll('.ds-select-sm').forEach(sel => {
    sel.addEventListener('change', function () {
      this.style.borderColor = '#e94560';
    });
  });
});
