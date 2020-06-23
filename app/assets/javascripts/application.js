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


// トップ画像
$(document).ready(function () {
  $("#theTarget").skippr({
      // スライドショーの変化 ("fade" or "slide")
      transition : 'slide',
      // 変化に係る時間(ミリ秒)
      speed : 2000,
      // easingの種類
      easing : 'easeOutQuart',
      // ナビゲーションの形("block" or "bubble")
      navType : 'bubble',
      // 子要素の種類("div" or "img")
      childrenElementType : 'div',
      // ナビゲーション矢印の表示(trueで表示)
      arrows : false,
      // スライドショーの自動再生(falseで自動再生なし)
      autoPlay : true,
      // 自動再生時のスライド切替間隔(ミリ秒)
      autoPlayDuration : 6000,
      // キーボードの矢印キーによるスライド送りの設定(trueで有効)
      keyboardOnAlways : true,
      // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
      hidePrevious : false
  });
});

//アニメーション用
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

//ヘッダー用
var startPos = 0,winScrollTop = 0;
$(window).on('scroll',function(){
    winScrollTop = $(this).scrollTop();
    if (winScrollTop >= startPos) {
        if(winScrollTop >= 300){
            $('.header').addClass('hide');
        }
    } else {
        $('.header').removeClass('hide');
    }
    startPos = winScrollTop;
});


