<?php
namespace App\Filament\Resources\TransaksiHewanResource\Api\Handlers;

use Illuminate\Http\Request;
use Rupadana\ApiService\Http\Handlers;
use App\Filament\Resources\TransaksiHewanResource;
use App\Filament\Resources\TransaksiHewanResource\Api\Requests\CreateTransaksiHewanRequest;

class CreateHandler extends Handlers {
    public static string | null $uri = '/';
    public static string | null $resource = TransaksiHewanResource::class;
    public static bool $public = true;

    public static function getMethod()
    {
        return Handlers::POST;
    }

    public static function getModel() {
        return static::$resource::getModel();
    }

    /**
     * Create TransaksiHewan
     *
     * @param CreateTransaksiHewanRequest $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function handler(CreateTransaksiHewanRequest $request)
    {
        $model = new (static::getModel());

        $model->fill($request->all());

        $model->save();

        return static::sendSuccessResponse($model, "Successfully Create Resource");
    }
}