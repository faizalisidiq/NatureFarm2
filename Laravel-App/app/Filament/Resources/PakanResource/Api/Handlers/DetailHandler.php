<?php

namespace App\Filament\Resources\PakanResource\Api\Handlers;

use App\Filament\Resources\SettingResource;
use App\Filament\Resources\PakanResource;
use Rupadana\ApiService\Http\Handlers;
use Spatie\QueryBuilder\QueryBuilder;
use Illuminate\Http\Request;
use App\Filament\Resources\PakanResource\Api\Transformers\PakanTransformer;

class DetailHandler extends Handlers
{
    public static string | null $uri = '/{id}';
    public static string | null $resource = PakanResource::class;
    public static bool $public = true;


    /**
     * Show Pakan
     *
     * @param Request $request
     * @return PakanTransformer
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

        return new PakanTransformer($query);
    }
}
