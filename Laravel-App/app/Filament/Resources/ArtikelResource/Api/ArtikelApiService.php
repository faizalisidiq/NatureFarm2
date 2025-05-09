<?php
namespace App\Filament\Resources\ArtikelResource\Api;

use Rupadana\ApiService\ApiService;
use App\Filament\Resources\ArtikelResource;
use Illuminate\Routing\Router;


class ArtikelApiService extends ApiService
{
    protected static string | null $resource = ArtikelResource::class;

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
