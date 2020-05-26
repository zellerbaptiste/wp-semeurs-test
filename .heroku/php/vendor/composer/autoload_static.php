<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit403841d145acc3f1dd5b099093fe7434
{
    public static $prefixLengthsPsr4 = array (
        'H' => 
        array (
            'Heroku\\Buildpack\\PHP\\' => 21,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Heroku\\Buildpack\\PHP\\' => 
        array (
            0 => __DIR__ . '/..' . '/heroku/installer-plugin/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit403841d145acc3f1dd5b099093fe7434::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit403841d145acc3f1dd5b099093fe7434::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
