<?php

namespace App\Filament\Resources\ArtikelResource\Api\Handlers;

use App\Filament\Resources\SettingResource;
use App\Filament\Resources\ArtikelResource;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;
use Illuminate\Http\Request;
use App\Filament\Resources\ArtikelResource\Api\Transformers\ArtikelTransformer;

class DetailHandler extends Handlers
{
    public static string | null $uri = '/{id}';
    public static string | null $resource = ArtikelResource::class;
    public static bool $public = true;


    /**
     * Show Artikel
     *
     * @param Request $request
     * @return ArtikelTransformer
     */
    public function handler(Request $request)
    {
        $id = $request->route('id');
        
        $query = static::getEloquentQuery();

        $query = QueryBuilder::for(
            $query->where(static::getKeyName(), $id)
        )
            ->first();

        if (!$query) return static::sendNotFoundResponse();

        return new ArtikelTransformer($query);
    }
}
