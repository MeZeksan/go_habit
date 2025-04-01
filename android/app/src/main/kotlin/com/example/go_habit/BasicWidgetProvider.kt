package com.example.go_habit

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class BasicWidgetProvider : AppWidgetProvider() {
    
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // Обновляем все экземпляры виджета
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }
    
    companion object {
        internal fun updateAppWidget(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetId: Int
        ) {
            // Создаем RemoteViews для нашего виджета
            val views = RemoteViews(context.packageName, R.layout.basic_widget_layout)
            
            // Создаем Intent, который будет запускать основное активити при клике на виджет
            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(
                context, 
                0, 
                intent, 
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            
            // Устанавливаем pendingIntent на весь виджет
            views.setOnClickPendingIntent(R.id.widget_layout, pendingIntent)
            
            // Обновляем виджет
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
} 