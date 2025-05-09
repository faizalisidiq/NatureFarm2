<?php
namespace App\Filament\Resources\HewanResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\HewanResource;
use Illuminate\Routing\Router;


class HewanApiService extends ApiService
{
    protected static string | null $resource = HewanResource::class;

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
