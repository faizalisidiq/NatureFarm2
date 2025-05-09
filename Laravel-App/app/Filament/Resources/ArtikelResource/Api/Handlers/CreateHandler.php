<?php

namespace App\Filament\Resources\ArtikelResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\ArtikelResource;
use App\Filament\Resources\ArtikelResource\Api\Requests\CreateArtikelRequest;

class CreateHandler extends Handlers
{
    public static string | null $uri = '/';
    public static string | null $resource = ArtikelResource::class;
    public static bool $public = true;


    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }

    /**
     * Create Artikel
     *
     * @param CreateArtikelRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(CreateArtikelRequest $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Create Resource");
    }
}
