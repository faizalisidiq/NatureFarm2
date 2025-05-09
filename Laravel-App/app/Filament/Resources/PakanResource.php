<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PakanResource\Pages;
use App\Filament\Resources\PakanResource\RelationManagers;
use App\Models\Pakan;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class PakanResource extends Resource
{
    protected static ?string $model = Pakan::class;

    protected static ?string $pluralLabel = 'Pakan';

    protected static ?string $navigationIcon = 'fluentui-food-grains-24-o';
    protected static ?string $navigationGroup = 'Produk';


    public static function getNavigationBadge(): ?string
    {
        return static::getModel()::count();
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('nama_pakan')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextArea::make('deskripsi')
                    ->required()
                    ->autosize()
                    ->maxLength(255),
                Forms\Components\TextInput::make('stok')
                    ->required()
                    ->numeric(),
                Forms\Components\Select::make('status')
                    ->required()
                    ->options([
                        'reviewing' => 'Reviewing',
                        'published' => 'Published',
                    ]),
                Forms\Components\FileUpload::make('gambar')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('gambar')
                    ->circular()
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('nama_pakan')
                    ->searchable(),
                Tables\Columns\TextColumn::make('deskripsi')
                    ->limit(50)
                    ->searchable(),
                Tables\Columns\TextColumn::make('stok')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('status')
                    ->sortable()
                    ->badge()
                    ->icon(fn(string $state): string => match ($state) {
                        'reviewing' => 'heroicon-o-clock',
                        'published' => 'heroicon-o-check-circle',
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'reviewing' => 'warning',
                        'published' => 'success',
                    }),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListPakans::route('/'),
            'create' => Pages\CreatePakan::route('/create'),
            'edit' => Pages\EditPakan::route('/{record}/edit'),
        ];
    }
}
