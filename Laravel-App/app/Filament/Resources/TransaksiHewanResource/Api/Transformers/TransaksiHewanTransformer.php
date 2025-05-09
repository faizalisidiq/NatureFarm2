<?php
namespace App\Filament\Resources\TransaksiHewanResource\Api\Transformers;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\TransaksiHewan;

/**
 * @property TransaksiHewan $resource
 */
class TransaksiHewanTransformer extends JsonResource
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
