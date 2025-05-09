<?php
namespace App\Filament\Resources\PakanResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\PakanResource;
use Illuminate\Routing\Router;


class PakanApiService extends ApiService
{
    protected static string | null $resource = PakanResource::class;

    public static function handlers() : array
    {
        return [
            Handlers\CreateHandler::class,
            Handlers\UpdateHandler::class,
            Handlers\DeleteHandler::class,
            Handlers\PaginationHandler::class,
            Handlers\DetailHandler::class
        ];

    }
}
