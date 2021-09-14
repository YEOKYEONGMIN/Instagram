<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="../img/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="css/message.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

</head>

<body>
   <jsp:include page="/include/header.jsp" />
    <main class="main">
        <section class="message__container">
            <article class="message">
                <div class="message__friendlist">
                    <div class="my__id">
                        <div class="id__btn">
                            <button>myAccount <i class="fas fa-chevron-down"></i></button>
                        </div>
                        <div class="write__btn">
                            <button><i class="far fa-edit"></i></button>
                        </div>
                    </div>
                    <div class="friend__id">
                        <ul class="friend__id__list">
                            <li>
                                <div class="friend__profile"><img src="images/profile.jpeg" alt=""></div>
                                <div class="friend__state">
                                    <p>이름</p>
                                    <p>상태메세지</p>
                                </div>
                            </li>
                            <li>
                                <div class="friend__profile"><img src="images/profile.jpeg" alt=""></div>
                                <div class="friend__state">
                                    <p>이름</p>
                                    <p>상태메세지</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="message__view">
                    <div class="message__list">
                        <div class="start">
                            <div><i class="far fa-paper-plane"></i></div>
                            <h2>내 메시지</h2>
                            <p>친구나 그룹에 비공개 사진과 메시지를 보내보세요.</p>
                            <button>메세지 보내기</button>
                        </div>
                    </div>
                </div>
            </article>
        </section>
    </main>
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
    <script src="js/follow.js"></script>
</body>

</html>