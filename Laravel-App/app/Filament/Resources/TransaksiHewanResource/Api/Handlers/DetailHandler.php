<?php

namespace App\Filament\Resources\TransaksiHewanResource\Api\Handlers;

use App\Filament\Resources\SettingResource;
use App\Filament\Resources\TransaksiHewanResource;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;
use Illuminate\Http\Request;
use App\Filament\Resources\TransaksiHewanResource\Api\Transformers\TransaksiHewanTransformer;

class DetailHandler extends Handlers
{
    public static string | null $uri = '/{id}';
    public static string | null $resource = TransaksiHewanResource::class;
    public static bool $public = true;


    /**
     * Show TransaksiHewan
     *
     * @param Request $request
     * @return TransaksiHewanTransformer
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

        return new TransaksiHewanTransformer($query);
    }
}
