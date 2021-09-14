console.clear()

track = document.querySelector('.track');
slides = Array.from(track.children);
prevBtn = document.querySelector('.btn.btn-back');
nextBtn = document.querySelector('.btn.btn-next');
navIndicator = document.querySelector('.nav-indicator');
dots = Array.from(navIndicator.children)
slideSize = slides[0].getBoundingClientRect();
slideWidth = slideSize.width;



var tl = new TimelineMax();
function blur(el, blur) {
	tl.fromTo(el, 0.55,
		{ filter: `blur(${blur}px)` },
		{ filter: 'blur(0px)' });
}

 slidePosition = (slide, index) => {
	slide.style.left = `${slideWidth * index}px`;
}
slides.forEach(slidePosition)


 slideToMove = (track, currentSlide, targetSlide) => {
	track.style.transform = `translateX(-${targetSlide.style.left})`;
	currentSlide.classList.remove('active');
	targetSlide.classList.add('active');
}

function updateDots(current, target) {
	current.classList.remove('active')
	target.classList.add('active')
}

function btnShowHide(targetIndex, prevBtn, nextBtn, slides) {
	if (targetIndex == 0) {
		prevBtn.classList.add('hidden')
		nextBtn.classList.remove('hidden')
	} else if (targetIndex == slides.length - 1) {
		prevBtn.classList.remove('hidden')
		nextBtn.classList.add('hidden')
	} else {
		prevBtn.classList.remove('hidden')
		nextBtn.classList.remove('hidden')
	}
}

nextBtn.addEventListener('click', (e) => {
	var currentSlide = track.querySelector('.active')
	var nextSlide = currentSlide.nextElementSibling;
	var currentDot = navIndicator.querySelector('.active');
	var nextDot = currentDot.nextElementSibling;
	var nextIndex = slides.findIndex(slide => slide === nextSlide)

	slideToMove(track, currentSlide, nextSlide);
	updateDots(currentDot, nextDot);
	btnShowHide(nextIndex, prevBtn, nextBtn, slides);
	if (e.detail > 1) return;
	blur(track, 5)
});

prevBtn.addEventListener('click', (e) => {
	var currentSlide = track.querySelector('.active')
	var prevSlide = currentSlide.previousElementSibling;
	var currentDot = navIndicator.querySelector('.active');
	var prevDot = currentDot.previousElementSibling;
	var prevIndex = slides.findIndex(slide => slide === prevSlide)

	slideToMove(track, currentSlide, prevSlide);
	updateDots(currentDot, prevDot);
	btnShowHide(prevIndex, prevBtn, nextBtn, slides)
	if (e.detail > 1) return;
	blur(track, 5)
});


