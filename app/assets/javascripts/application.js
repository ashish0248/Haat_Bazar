// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require_tree .
//= require jquery.jpostal

$(window).scroll(function() {
 　　// .animation 配下の　.anm_modを対象に見る
 $(".animation .anm_mod").each(function() {
  // スクロール中、各UIパーツ　.anm_modがブラウザ画面内に入ったら activeクラスが付与される
  const position = $(this).offset().top;
  const scroll = $(window).scrollTop();
  const windowHeight = $(window).height();
  if (scroll > position - windowHeight) {
   $(this).addClass("active");
  }
  // スクロール中、トップ画面付近まで戻ったら activeクラスを解除 ＝ 何度でもスクロールアニメが表現可能。一度しかアニメーションしたく無ければここを削除してください。
  if (scroll < 100) {
   $(this).removeClass("active");
  }
 });
});

