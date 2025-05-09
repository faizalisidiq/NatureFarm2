<?php
namespace App\Filament\Resources\TransaksiHewanResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\TransaksiHewanResource;
use Illuminate\Routing\Router;


class TransaksiHewanApiService extends ApiService
{
    protected static string | null $resource = TransaksiHewanResource::class;

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
