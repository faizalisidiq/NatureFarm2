<?php
namespace App\Filament\Resources\PakanResource\Api\Transformers;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Pakan;

/**
 * @property Pakan $resource
 */
class PakanTransformer extends JsonResource
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
