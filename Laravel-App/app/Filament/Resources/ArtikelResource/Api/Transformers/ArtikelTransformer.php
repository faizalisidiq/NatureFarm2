<?php
namespace App\Filament\Resources\ArtikelResource\Api\Transformers;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Artikel;

/**
 * @property Artikel $resource
 */
class ArtikelTransformer extends JsonResource
{

    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return $this->resource->toArray();
    }
}
