<?php

namespace App\Filament\Resources;

use App\Filament\Resources\TransaksiHewanResource\Pages;
use App\Filament\Resources\TransaksiHewanResource\RelationManagers;
use App\Models\TransaksiHewan;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class TransaksiHewanResource extends Resource
{
    protected static ?string $model = TransaksiHewan::class;

    protected static ?string $pluralLabel = 'Transaksi Hewan';

    protected static ?string $navigationIcon = 'icon-cart';

    public static function getNavigationBadge(): ?string
    {
        return static::getModel()::count();
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('id_customer')
                    ->relationship('customer', 'nama')
                    ->required(),
                Forms\Components\Select::make('id_hewan')
                    ->relationship('hewan', 'nama_hewan')
                    ->required(),
                Forms\Components\TextInput::make('harga')
                    ->required()
                    ->prefix('Rp')
                    ->numeric(),
                Forms\Components\Select::make('status')
                    ->required()
                    ->options([
                        'dikemas' => 'Dikemas',
                        'dikirim' => 'Dikirim',
                    ])
                    ->default('dikemas'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('customer.nama')
                    ->sortable(),
                Tables\Columns\TextColumn::make('hewan.nama_hewan')
                    ->sortable(),
                Tables\Columns\TextColumn::make('harga')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('status')
                    ->sortable()
                    ->badge()
                    ->icon(fn(string $state): string => match ($state) {
                        'dikemas' => 'heroicon-o-clock',
                        'dikirim' => 'heroicon-o-check-circle',
                    })
                    ->color(fn(string $state): string => match ($state) {
                        'dikemas' => 'warning',
                        'dikirim' => 'success',
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
            'index' => Pages\ListTransaksiHewans::route('/'),
            'create' => Pages\CreateTransaksiHewan::route('/create'),
            'edit' => Pages\EditTransaksiHewan::route('/{record}/edit'),
        ];
    }
}
