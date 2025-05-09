<?php
namespace App\Filament\Resources\HewanResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\HewanResource;
use App\Filament\Resources\HewanResource\Api\Requests\CreateHewanRequest;

class CreateHandler extends Handlers {
    public static string | null $uri = '/';
    public static string | null $resource = HewanResource::class;
    public static bool $public = true;


    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel() {
        return static::$resource::getModel();
    }

    /**
     * Create Hewan
     *
     * @param CreateHewanRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(CreateHewanRequest $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Create Resource");
    }
}