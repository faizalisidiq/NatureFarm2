<?php

namespace App\Filament\Resources\ArtikelResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\ArtikelResource;
use App\Filament\Resources\ArtikelResource\Api\Requests\UpdateArtikelRequest;

class UpdateHandler extends Handlers
{
    public static string | null $uri = '/{id}';
    public static string | null $resource = ArtikelResource::class;
    public static bool $public = true;

    public static function getMethod()
    {
        return Handlers::PUT;
    }

    public static function getModel()
    {
        return static::$resource::getModel();
    }


    /**
     * Update Artikel
     *
     * @param UpdateArtikelRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(UpdateArtikelRequest $request)
    {
        $id = $request->route('id');

        $model = static::getModel()::find($id);

        if (!$model) return static::sendNotFoundResponse();

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Update Resource");
    }
}
