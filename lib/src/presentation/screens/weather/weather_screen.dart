import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../di/injector.dart';
import '../../../domain/entities/weather_entity.dart';
import '../../common/components/app_button.dart';
import '../../common/components/app_field.dart';
import '../../common/components/app_text.dart';
import '../../common/components/app_toast.dart';
import '../../common/constants/app_colors.dart';
import '../../common/dialogs/loading_dialog.dart';
import '../../common/utils/format_utils.dart';
import 'weather_cubit/weather_cubit.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final TextEditingController cityController;
  bool loading = false;
  WeatherEntity? weatherEntity;

  final _cubit = getIt<WeatherCubit>();

  @override
  void initState() {
    cityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  bool validate() {
    if (cityController.text.trim().isEmpty) {
      AppToast.showErrorToast(context, 'Please enter city');
      return false;
    }
    return true;
  }

  void removeFocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: GestureDetector(
        onTap: () => removeFocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Weather App'),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  BlocBuilder<WeatherCubit, WeatherState>(
                    builder: (context, state) {
                      return AppField(
                        controller: cityController,
                        hintText: 'Enter city',
                        labelText: 'Enter city',
                        enabled: loading == false,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.done,
                      );
                    },
                  ),
                  20.verticalSpace,
                  AppButton(
                    onPressed: () {
                      if (validate()) {
                        removeFocus();
                        _cubit.fetchWeatherData(cityController.text.trim());
                      }
                    },
                    text: 'Get Weather',
                    isExpand: false,
                  ),
                  Expanded(
                    child: BlocConsumer<WeatherCubit, WeatherState>(
                      listener: (context, state) {
                        state.whenOrNull(
                          loading: () {
                            loading = true;
                            showLoadingDialog(context);
                          },
                          success: (weatherEntity) {
                            cityController.clear();
                            hideLoadingDialog(context);
                            this.weatherEntity = weatherEntity;
                            loading = false;
                          },
                          error: (errorEntity) {
                            hideLoadingDialog(context);
                            loading = false;
                            AppToast.showErrorToast(
                                context, errorEntity.message);
                          },
                        );
                      },
                      builder: (context, state) {
                        if (weatherEntity == null) {
                          return const SizedBox();
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                AppText(
                                  weatherEntity!.name,
                                  textAlign: TextAlign.center,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                Image.network(
                                  'https://openweathermap.org/img/wn/'
                                  '${weatherEntity!.icon}@4x.png',
                                  width: 100.w,
                                  height: 100.w,
                                ),
                                AppText(
                                  '${weatherEntity!.temperature} °C',
                                  textAlign: TextAlign.center,
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppText(
                                  weatherEntity!.description,
                                  textAlign: TextAlign.center,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            _buildDateTime(),
                            _buildDataBox(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTime() {
    return Column(
      children: [
        AppText(
          FormatUtils.getFormattedTime(DateTime.now()),
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
        AppText(
          FormatUtils.getFormattedDayAndDate(DateTime.now()),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _buildDataBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildDataRow('Max', '${weatherEntity!.temperatureMax} °C'),
              8.horizontalSpace,
              _buildDataRow('Min', '${weatherEntity!.temperatureMin} °C'),
            ],
          ),
          20.verticalSpace,
          Row(
            children: [
              _buildDataRow('Wind', '${weatherEntity!.windSpeed} m/s'),
              8.horizontalSpace,
              _buildDataRow('Humidity', '${weatherEntity!.humidity}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String title, String value) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            '$title: ',
            color: AppColors.white,
            fontWeight: FontWeight.w400,
          ),
          AppText(
            value,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
