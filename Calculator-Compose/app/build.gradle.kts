import org.gradle.api.tasks.testing.logging.TestExceptionFormat
import org.gradle.api.tasks.testing.logging.TestLogEvent

plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

android {
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.calculator_compose"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlin {
        jvmToolchain(17)
    }
    buildFeatures.compose = true

    composeOptions {
        kotlinCompilerExtensionVersion = libs.versions.kotlinCompilerCompose.get()
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
    namespace = "com.example.calculator_compose"
}

dependencies {
    implementation(libs.core.ktx)
    implementation(libs.appcompat)
    implementation(libs.material)
    implementation(libs.compose.ui)
    implementation(libs.compose.material)
    implementation(libs.compose.ui.tooling.preview)
    implementation(libs.lifecycle.runtime.ktx)
    implementation(libs.activity.compose)

    testImplementation(libs.junit)

    androidTestImplementation(libs.ext.junit)
    androidTestImplementation(libs.espresso.core)
    androidTestImplementation(libs.ui.test.junit4)

    debugImplementation(libs.ui.tooling)
    debugImplementation(libs.ui.test.manifest)
}

// Log Gradle test results
tasks.withType<Test> {
    testLogging {
        exceptionFormat = TestExceptionFormat.FULL
        events(
            TestLogEvent.PASSED,
            TestLogEvent.SKIPPED,
            TestLogEvent.FAILED,
            TestLogEvent.STANDARD_OUT,
            TestLogEvent.STANDARD_ERROR
        )
        showStandardStreams = true
    }
}
