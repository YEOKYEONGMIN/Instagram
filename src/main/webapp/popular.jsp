<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="images/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="css/popular.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
        rel="stylesheet">
</head>

<body>
   <jsp:include page="/include/header.jsp" />

    <main class="popular">
        <div class="container">
            <div class="popular-gallery popular-top">
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                    <i class="fas fa-images"></i>
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
            </div>
            <div class="popular-gallery">
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                    <i class="fas fa-images"></i>
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                    <i class="fas fa-images"></i>
                </div>
            </div>
            <div class="popular-gallery">
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                    <i class="fas fa-images"></i>
                </div>
            </div>
            <div class="popular-gallery">
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
                <div class="p-img-box">
                    <img src="images/profile.jpeg" alt="">
                </div>
            </div>
        </div>
    </main>



    <footer>
        <div class="container">
            <ul>
                <li><a href="#a">소개</a></li>
                <li><a href="#a">블로그</a></li>
                <li><a href="#a">채용 정보</a></li>
                <li><a href="#a">도움말</a></li>
                <li><a href="#a">API</a></li>
                <li><a href="#a">개인정보처리방침</a></li>
                <li><a href="#a">약관</a></li>
                <li><a href="#a">인기 계정</a></li>
                <li><a href="#a">해시태그</a></li>
                <li><a href="#a">위치</a></li>
            </ul>
            <div class="copy">
                <select name="" id="">
                    <option value="">한국어</option>
                </select>
                <p>© 2020 Instagram from Facebook</p>
            </div>
        </div>
    </footer>

    <div class="modal-heart">
        <div class="follow">
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
        </div>
    </div>
    <script defer src="../js/main.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="js/follow.js"></script>
</body>

</html>