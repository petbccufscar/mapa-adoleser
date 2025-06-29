Rotas implementadas até o momento:


api/register/
api/login/
api/login/refresh/
api/logout/
api/profile
api/password-reset/confirm/
api/password-reset/request/

/api/locations/ adoleserbackend.views.LocationViewSet   location-list
/api/locations/<pk>/    adoleserbackend.views.LocationViewSet   location-detail
/api/locations/<pk>\.<format>/  adoleserbackend.views.LocationViewSet   location-detail
/api/locations\.<format>/       adoleserbackend.views.LocationViewSet   location-list

/api/location-reviews/  adoleserbackend.views.LocationReviewViewSet     locationreview-list
/api/location-reviews/<pk>/     adoleserbackend.views.LocationReviewViewSet     locationreview-detail
/api/location-reviews/<pk>\.<format>/   adoleserbackend.views.LocationReviewViewSet     locationreview-detail
/api/location-reviews\.<format>/        adoleserbackend.views.LocationReviewViewSet     locationreview-list
