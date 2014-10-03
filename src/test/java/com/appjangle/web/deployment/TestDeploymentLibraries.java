package com.appjangle.web.deployment;

import org.junit.Test;

import com.appjangle.qunit.QUnit;

public class TestDeploymentLibraries {

	@Test
	public void test() {
		QUnit.run(this, "tests.html");
	}
	
}
