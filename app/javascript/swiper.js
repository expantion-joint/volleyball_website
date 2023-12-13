document.addEventListener('DOMContentLoaded', function() { 
  const swiper = new Swiper(".swiper", {
    loop: true,    // ループ
    speed: 3000,   // 少しゆっくり(デフォルトは300)
    autoplay: {    // 自動再生
      delay: 4000, // 1000で1秒後に次のスライド
      disableOnInteraction: false, // 矢印をクリックしても自動再生を止めない
    },
    // ページネーション
    pagination: {
      el: ".swiper-pagination",
      clickable: true,
    },
    // 前後の矢印
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  })
});