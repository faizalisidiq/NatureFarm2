<?php
namespace App\Filament\Resources\PakanResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\PakanResource;
use App\Filament\Resources\PakanResource\Api\Requests\CreatePakanRequest;

class CreateHandler extends Handlers {
    public static string | null $uri = '/';
    public static string | null $resource = PakanResource::class;
    public static bool $public = true;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel() {
        return static::$resource::getModel();
    }

    /**
     * Create Pakan
     *
     * @param CreatePakanRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(CreatePakanRequest $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Create Resource");
    }
}