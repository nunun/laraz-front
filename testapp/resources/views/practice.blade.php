<!doctype html>
<html lang="{{ config('app.locale') }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Practice</title>

    {{-- css and js --}}
    {!! MaterializeCSS::include_full() !!}
</head>
<body>

This is practice.
please see <a href="http://materializecss.com/">document</a> of materialize-css.

{{-- html --}}
<div class="carousel carousel-slider center" data-indicators="true">
    <div class="carousel-fixed-item center">
        <a class="btn waves-effect white grey-text darken-text-2">button</a>
    </div>
    <div class="carousel-item red white-text" href="#one!">
        <h2>First Panel</h2>
        <p class="white-text">This is your first panel</p>
    </div>
    <div class="carousel-item amber white-text" href="#two!">
        <h2>Second Panel</h2>
        <p class="white-text">This is your second panel</p>
    </div>
    <div class="carousel-item green white-text" href="#three!">
        <h2>Third Panel</h2>
        <p class="white-text">This is your third panel</p>
    </div>
    <div class="carousel-item blue white-text" href="#four!">
        <h2>Fourth Panel</h2>
        <p class="white-text">This is your fourth panel</p>
    </div>
</div>

{{-- js --}}
<script type="text/javascript">
    $('.carousel.carousel-slider').carousel({fullWidth:true});
</script>

</body>
</html>
