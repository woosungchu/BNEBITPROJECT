package com.bnebit.sms.util;

import java.util.List;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

public class ValidationUtil {
	public static RestResult formValidationResult(BindingResult bindingResult) {
		RestResult result = new RestResult();
		if (bindingResult.hasErrors()) {
			List<FieldError> fieldErrorList = bindingResult.getFieldErrors();
			result.setCode("fail");
			result.setMessage(fieldErrorList.get(0).getDefaultMessage());
			result.setField(fieldErrorList.get(0).getField());
		}
		return result;
	}
}
