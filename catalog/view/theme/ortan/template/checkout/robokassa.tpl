<!DOCTYPE html>
<html lang="ru">

<head></head>

<body>
    <div style="opacity:0;">
        <?php echo $payment ?>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                document.getElementById('form-robokassa').submit()
            })
        </script>
    </div>
</body>

</html>