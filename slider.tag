
<slider>

  <form onsubmit={ add }>
    Количество элементов в галерее <input name="input" value="" onkeyup={ edit }>
    <button disabled={ !text } onclick="{ renderSlider }">Перерисовать</button>
  </form>
  <div id="slider">
    <div class="slider-box">
      <ul name="ul" style="margin-left: { marginLeft }px">
        <li each={ item, index in items }>
          <div class="preview" style="width: { item.width }px">
            { index }
          </div>
        </li>
      </ul>
    </div>
    <div class="slide-contorl">
      <div class="prev btn" onclick="{ prevSlide }"><</div>
      <div class="next btn" onclick="{ nextSlide }">></div>
    </div>
  </div>


  <script>
    var self = this;
    self.items = opts.items;
    self.marginLeft = 0;
    self.on('mount', function() {
      var elem = self.ul;
      if (elem.addEventListener) {
      if ('onwheel' in document) {
        // IE9+, FF17+, Ch31+
        elem.addEventListener("wheel", self.onWheel);
      } else if ('onmousewheel' in document) {
        // устаревший вариант события
        elem.addEventListener("mousewheel", self.onWheel);
      } else {
        // Firefox < 17
        elem.addEventListener("MozMousePixelScroll", self.onWheel);
      }
      } else { // IE8-
      elem.attachEvent("onmousewheel", self.onWheel);
      }
    })

    onWheel(e) {
      e = e || window.event;
      var delta = e.deltaY || e.detail || e.wheelDelta;
      if (delta > 0) {
        self.nextSlide();
      } else {
        self.prevSlide();
      }
    }
    edit(e) {
      self.text = Number(e.target.value);
    }
    renderSlider() {
      var arr = [];
      var rndWidth = 200;
      var min = 100;
      var max = 200;
      for(i = 0; i<self.input.value; i++){
        rndWidth = self.getRandom(min, max);
        arr.push( { width: rndWidth } );
      }
      self.marginLeft = 0;
      self.items = arr;
    }
    getRandom(min, max) {
      return Math.random() * (max - min) + min;
    }
    getWidth() {
      self.scrollWidth = self.ul.scrollWidth;
      self.sliderWidth = self.slider.offsetWidth;
    }
    nextSlide() {
      self.getWidth();
      if(self.scrollWidth > self.sliderWidth && -self.marginLeft < (self.scrollWidth-self.sliderWidth)){
        self.marginLeft -= self.sliderWidth;
        this.update({ marginLeft: self.marginLeft })
      }
    }
    prevSlide() {
      self.getWidth();
      if(self.scrollWidth > self.sliderWidth && self.marginLeft < 0){
        self.marginLeft += self.sliderWidth;
        this.update({ marginLeft: self.marginLeft })
      }
    }
  </script>

</slider>
