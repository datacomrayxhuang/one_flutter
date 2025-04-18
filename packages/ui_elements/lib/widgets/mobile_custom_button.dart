// import 'package:flutter/material.dart';
// import 'package:rockgas/bloc/abstract_generic_bloc_state.dart';
// import 'package:rockgas/helper.dart';
// import 'package:rockgas/ui/strings.dart';
// import 'package:rockgas/ui/styles/color_constants.dart';
// import 'package:rockgas/ui/styles/dimension_constants.dart';
// import 'package:rockgas/ui/styles/style_constants.dart';
// import 'package:rockgas/ui/widgets/shared/custom_button.dart';
// import 'package:rockgas/ui/widgets/shared/custom_svg_icon.dart';

// class MobileCustomPrimaryButton extends CustomButton {
//   const MobileCustomPrimaryButton({
//     super.key,
//     required super.onPressed,
//     super.disabled,
//     required super.text,
//     super.margin,
//     super.padding,
//     super.constraints,
//     super.overlayColor,
//     super.borderSide,
//     super.borderRadius,
//     super.mainAxisAlignment,
//     super.leadingIcon,
//     super.trailingIcon,
//     super.wrapTextWithExpandedWidget,
//   })
//     : super(
//       textStyle: kSubTitleWhiteTextStyle,
//       backgroundColor: kRockgasBlueColor,
//     );
// }

// class MobileCustomSecondaryButton extends CustomButton {
//   const MobileCustomSecondaryButton({
//     super.key,
//     required super.onPressed,
//     super.disabled,
//     required super.text,
//     super.margin,
//     super.padding,
//     super.constraints,
//     super.overlayColor,
//     // super.borderSide,
//     super.borderRadius,
//     super.mainAxisAlignment,
//     super.leadingIcon,
//     super.trailingIcon,
//     bool? isSkeleton,
//     super.wrapTextWithExpandedWidget,
//   })
//     : super(
//       textStyle: kSubTitleBlueTextStyle,
//       backgroundColor: kWhiteColor,
//       borderSide: isSkeleton != null && isSkeleton
//         ? BorderSide.none
//         : const BorderSide(color: kRockgasBlueColor),
//     );
// }

// class MobileLogInPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileLogInPrimaryButton({
//     super.key,
//     required bool isLoading,
//     required VoidCallback onPressed,
//   }) : super(
//           text: isLoading ? const Text(UIStrings.genericLogInButtonLoadingLabel) : const Text(UIStrings.genericLogInButtonLabel),
//           onPressed: isLoading ? null : onPressed,
//           trailingIcon: isLoading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : null,
//         );
// }

// class MobileFetchDataPrimaryButtonWithLoadingIcon extends MobileCustomPrimaryButton {
//   const MobileFetchDataPrimaryButtonWithLoadingIcon({
//     super.key,
//     required bool isLoading,
//     required VoidCallback onPressed,
//   }) : super(
//           text: isLoading ? const Text(UIStrings.genericFetchingDataButtonLabel) : const Text(UIStrings.genericTryAgainButtonLabel),
//           onPressed: isLoading ? null : onPressed,
//           trailingIcon: isLoading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : null,
//         );
// }

// class MobileLogOutSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileLogOutSecondaryButton({
//     super.key,
//     required super.onPressed,
//     required super.disabled,
//   }) : super(
//           text: const Text(UIStrings.genericLogOutButtonLabel),
//         );
// }

// class MobileSignUpToRockgasSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileSignUpToRockgasSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericSignUpToRockgasButtonLabel),
//         );
// }

// class MobileRegisterForTheAppSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileRegisterForTheAppSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericRegisterForTheAppButtonLabel),
//         );
// }

// class MobileMakePaymentPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileMakePaymentPrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.paymentMakePaymentButtonLabel),
//         );
// }

// class MobileMakePaymentSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileMakePaymentSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.paymentMakePaymentButtonLabel),
//         );
// }

// class MobileCloseSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileCloseSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericCloseButtonLabel),
//         );
// }

// class MobileContinuePrimaryButtonWithIcon extends MobileCustomPrimaryButton {
//   const MobileContinuePrimaryButtonWithIcon({
//     super.key,
//     required super.onPressed,
//     super.disabled,
//   }) : super(
//           text: const Text(UIStrings.genericContinueButtonLabel),
//           trailingIcon: const SvgIcon.small(
//             icon: '${Helper.imageRootPath}general${Helper.imageSharedPrefix}forward-arrow-white-icon.svg',
//           ),
//         );
// }

// class MobileRegisterContinuePrimaryButtonWithLoadingIcon extends MobileCustomPrimaryButton {
//   const MobileRegisterContinuePrimaryButtonWithLoadingIcon({
//     super.key,
//     required super.onPressed,
//     required bool isLoading,
//     super.disabled,
//   }) : super(
//           text: isLoading ? const Text(UIStrings.registerContinueButtonLoadingLabel) : const Text(UIStrings.genericContinueButtonLabel),
//           trailingIcon: isLoading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : null,
//         );
// }

// class MobileRegisterContactDetailsContinuePrimaryButtonWithLoadingIcon extends MobileCustomPrimaryButton {
//   const MobileRegisterContactDetailsContinuePrimaryButtonWithLoadingIcon({
//     super.key,
//     required super.onPressed,
//     required bool isLoading,
//     super.disabled,
//   }) 
//     : super(
//       text: isLoading 
//         ? const Text (UIStrings.registerContactDetailsContinueButtonLoadingLabel)
//         : const Text (UIStrings.genericContinueButtonLabel),
//       trailingIcon: 
//         isLoading
//           ? const SizedBox.square(
//             dimension: kSmallIconSize,
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               color: kRockgasOrangeColor,
//             ),
//           )
//           : null,
//     );
// }

// class MobilePaymentContinuePrimaryButtonWithLoadingIcon extends MobileCustomPrimaryButton {
//   const MobilePaymentContinuePrimaryButtonWithLoadingIcon({
//     super.key,
//     required super.onPressed,
//     required bool isLoading,
//     super.disabled,
//   }) : super(
//           text: isLoading ? const Text(UIStrings.paymentGenerateTransactionButtonLoadingLabel) : const Text(UIStrings.genericContinueButtonLabel),
//           trailingIcon: isLoading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : const SvgIcon.small(
//                   icon: '${Helper.imageRootPath}general${Helper.imageSharedPrefix}forward-arrow-white-icon.svg',
//                 ),
//         );
// }

// class MobilePlaceOrderPrimaryButton extends MobileCustomPrimaryButton {
//   const MobilePlaceOrderPrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.orderPlaceOrderButtonLabel),
//         );
// }

// class MobileHomePrimaryButton extends MobileCustomPrimaryButton {
//   const MobileHomePrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.navigationHomeButtonLabel),
//         );
// }

// class MobileBackToHomePrimaryButton extends MobileCustomPrimaryButton {
//   const MobileBackToHomePrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.navigationBackToHomeButtonLabel),
//         );
// }

// class MobileBackToHomeSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileBackToHomeSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.navigationBackToHomeButtonLabel),
//         );
// }

// class MobileTryAgainPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileTryAgainPrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericTryAgainButtonLabel),
//         );
// }

// // Note: Inconsistency? Other button's leading icon has a spacing of 12 but this button
// // on Figma has a spacing of 10
// class MobileRequestNewLocationPrimaryButtonWithIcon extends MobileCustomPrimaryButton {
//   MobileRequestNewLocationPrimaryButtonWithIcon({
//     super.key,
//     required super.onPressed,
//     required bool isSkeleton,
//     required bool isBranch,
//   }) : super(
//           text: isBranch
//             ? const Text(UIStrings.locationRequestNewLocationBranchButtonLabel)
//             : const Text(UIStrings.locationRequestNewLocationFranchiseButtonLabel),
//           leadingIcon: SvgIcon.standard(
//             isSkeleton: isSkeleton,
//             icon: '${Helper.imageRootPath}general${Helper.imageSharedPrefix}request-new-location-white-icon.svg',
//           ),
//         );
// }

// class MobileEditSecondaryButtonWithIcon extends MobileCustomSecondaryButton {
//   const MobileEditSecondaryButtonWithIcon({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericEditButtonLabel),
//           leadingIcon: const SvgIcon.standard(
//             icon: '${Helper.imageRootPath}account${Helper.imagePlatformPrefix}location-edit-icon.svg',
//           ),
//         );
// }

// class MobileEditPersonalDetailsSecondaryButtonWithIcon extends MobileCustomSecondaryButton {
//   const MobileEditPersonalDetailsSecondaryButtonWithIcon({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.accountEditPersonalDetialsButtonLabel),
//           leadingIcon: const SvgIcon.standard(
//             icon: '${Helper.imageRootPath}account${Helper.imagePlatformPrefix}location-edit-icon.svg',
//           ),
//         );
// }

// class MobileMovingLocationSecondaryButtonWithIcon extends MobileCustomSecondaryButton {
//   const MobileMovingLocationSecondaryButtonWithIcon({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.locationMovingLocationButtonLabel),
//           leadingIcon: const SvgIcon.standard(
//             icon: '${Helper.imageRootPath}account${Helper.imagePlatformPrefix}location-moving-icon.svg',
//           ),
//         );
// }

// class MobileRemoveLocationSecondaryButtonWithIcon extends MobileCustomSecondaryButton {
//   const MobileRemoveLocationSecondaryButtonWithIcon({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.locationRemoveLocationButtonLabel),
//           leadingIcon: const SvgIcon.standard(
//             icon: '${Helper.imageRootPath}account${Helper.imagePlatformPrefix}location-remove-icon.svg',
//           ),
//         );
// }

// class MobileRemoveLocationPrimaryButtonWithIcon extends MobileCustomPrimaryButton {
//   const MobileRemoveLocationPrimaryButtonWithIcon({
//     super.key,
//     required super.onPressed,
//     required bool isLoading,
//   }) : super(
//           text: const Text(UIStrings.locationRemoveLocationButtonLabel),
//           trailingIcon: isLoading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : null,
//         );
// }

// class MobileSavePrimaryButton extends MobileCustomPrimaryButton {
//   const MobileSavePrimaryButton({
//     super.key,
//     required super.onPressed,
//     required super.disabled,
//   }) : super(
//           text: const Text(UIStrings.genericSaveButtonLabel),
//         );
// }

// class MobileSubmitPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileSubmitPrimaryButton({
//     super.key,
//     required super.onPressed,
//     required super.disabled,
//   }) : super(
//           text: const Text(UIStrings.genericSubmitButtonLabel),
//         );
// }

// class MobileSubmitPrimaryButtonWithLoadingIcon extends MobileCustomPrimaryButton {
//   const MobileSubmitPrimaryButtonWithLoadingIcon({
//     super.key,
//     required super.onPressed,
//     required super.disabled,
//     required bool isLoading,
//   }) : super(
//           text: isLoading ? const Text(UIStrings.genericSubmittingButtonLoadingLabel) : const Text(UIStrings.genericSubmitButtonLabel),
//           trailingIcon: isLoading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : null,
//         );
// }

// class MobileSubmitRequestPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileSubmitRequestPrimaryButton({
//     super.key,
//     required super.onPressed,
//     required super.disabled,
//   }) : super(
//           text: const Text(UIStrings.genericSubmitRequestButtonLabel),
//         );
// }

// class MobileSubmitChangeRequestPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileSubmitChangeRequestPrimaryButton({
//     super.key,
//     required super.onPressed,
//     required super.disabled,
//   }) : super(
//           text: const Text(UIStrings.genericSubmitChangeRequestButtonLabel),
//         );
// }

// class MobileCancelEditingSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileCancelEditingSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericCancelEditingButtonLabel),
//         );
// }

// class MobileCancelSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileCancelSecondaryButton({
//     super.key,
//     required super.onPressed,
//   }) : super(
//           text: const Text(UIStrings.genericCancelButtonLabel),
//         );
// }

// class MobileDonePrimaryButton extends MobileCustomPrimaryButton {
//   const MobileDonePrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericDoneButtonLabel),
//         );
// }

// class MobileDoneSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileDoneSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericDoneButtonLabel),
//         );
// }

// class MobileBackToLocationsSecondaryButton extends MobileCustomSecondaryButton {
//   const MobileBackToLocationsSecondaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.navigationBackToLocationsButtonLabel),
//         );
// }

// class MobileStartOffboardingProcessPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileStartOffboardingProcessPrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.navigationStartOffboardingProcessButtonLabel),
//         );
// }

// class MobileConfirmPrimaryButton extends MobileCustomPrimaryButton {
//   const MobileConfirmPrimaryButton({super.key, required super.onPressed})
//       : super(
//           text: const Text(UIStrings.genericConfirmButtonLabel),
//         );
// }

// class MobileRequestReceiptSecondaryButtonWithLoadingIcon extends MobileCustomSecondaryButton {
//   MobileRequestReceiptSecondaryButtonWithLoadingIcon({
//     super.key,
//     required super.onPressed,
//     required GenericBlocStatus status,
//   }) : super(
//           text: switch (status) {
//             GenericBlocStatus.initial => const Text(UIStrings.transactionRequestCopyOfReceiptButtonLabel),
//             GenericBlocStatus.loading => const Text(UIStrings.transactionRequestCopyOfReceiptLoadingLabel),
//             GenericBlocStatus.success => const Text(UIStrings.transactionRequestCopyOfReceiptSuccessLabel),
//             GenericBlocStatus.failure => const Text(UIStrings.transactionRequestCopyOfReceiptFailureLabel),
//           },
//           disabled: status != GenericBlocStatus.initial,
//           trailingIcon: status == GenericBlocStatus.loading
//               ? const SizedBox.square(
//                   dimension: kSmallIconSize,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: kRockgasOrangeColor,
//                   ),
//                 )
//               : null,
//         );
// }

// class MobileSetUpDirectDebitSecondaryButtonWithIcon extends MobileCustomSecondaryButton {
//   const MobileSetUpDirectDebitSecondaryButtonWithIcon({
//     super.key,
//     required super.onPressed,
//     required bool isSkeleton,
//   }) : super(
//           text: const Text(
//             UIStrings.setUpDirectDebitButtonLabel,
//             overflow: TextOverflow.ellipsis,
//           ),
//           isSkeleton: isSkeleton,
//           leadingIcon: isSkeleton
//               ? const SizedBox.square(dimension: kStandardIconSize)
//               : const SvgIcon.standard(
//                   icon: '${Helper.imageRootPath}account${Helper.imageSharedPrefix}account-external-link-blue-icon.svg',
//                 ),
//           wrapTextWithExpandedWidget: false,
//         );
// }
