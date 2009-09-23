From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 7/9] removing eclipse project files
Date: Wed, 23 Sep 2009 23:16:08 +0200
Message-ID: <1253740570-10718-7-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
 <1253740570-10718-3-git-send-email-struberg@yahoo.de>
 <1253740570-10718-4-git-send-email-struberg@yahoo.de>
 <1253740570-10718-5-git-send-email-struberg@yahoo.de>
 <1253740570-10718-6-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCv-0004mJ-0R
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbZIWVQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752764AbZIWVQU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:16:20 -0400
Received: from n7.bullet.re3.yahoo.com ([68.142.237.92]:25066 "HELO
	n7.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752492AbZIWVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:16:04 -0400
Received: from [68.142.237.87] by n7.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:07 -0000
Received: from [69.147.75.190] by t3.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:07 -0000
Received: from [127.0.0.1] by omp106.mail.re1.yahoo.com with NNFMP; 23 Sep 2009 21:16:07 -0000
X-Yahoo-Newman-Id: 239189.51887.bm@omp106.mail.re1.yahoo.com
Received: (qmail 22316 invoked from network); 23 Sep 2009 21:16:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=mlGZZApKvTJAVOAqHdLnLYXcVubPYaGsggymCflLRow9RkM0mV2nOUQbVxzOE1l1RowWUMPfVONIZRjCtwiZBvwslWtqFRYf/Og3FIKs6farcRVwexp4Y19cl8+OlGYmbNbMEveoTMYeWCGZlXFaDtqVUyIoI8XRyV7DhR+rI/o=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:16:05 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: warRFM0VM1m4Fd87_MsCKAnvaXef_TOnUOWqtg_Ekzsp1uBkWMrmFFTCvMHneK04lEzWlLcVweQ3Y7qAYYaqN2NsN0aIX1dZZDxHpUrJrlb8J9YeErzQpsxnSEJnXnm7BczYmgJXXsqqUrefCf9J3leXrbgQ6zN3eOmyfhhAp7ZM5PeitJDIKIbF_Vimg0Y_6Y83lG6EU_Ls_gbX1IxWMxSJpRbJO1R5Y.0hlCgPHVNtNmxlThMLQz4g6gIcn98FeBGbeEMbvkwXcCXmRG6L9fIrI0C3qcFA2ALyeJv4FoHEPHAflDOexOOAj2D5_lo.MbPN4ia4LHIvYKVmuS4kwaPWCisCANv0hbo-
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-6-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129007>

All information necessary to build jgit is already available in
the maven pom.xmls.

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 org.spearce.jgit.pgm/.classpath                    |    8 -
 org.spearce.jgit.pgm/.gitignore                    |    5 +
 org.spearce.jgit.pgm/.project                      |   17 -
 .../.settings/org.eclipse.core.resources.prefs     |    3 -
 .../.settings/org.eclipse.core.runtime.prefs       |    3 -
 .../.settings/org.eclipse.jdt.core.prefs           |  321 --------------------
 .../.settings/org.eclipse.jdt.ui.prefs             |    9 -
 org.spearce.jgit/.classpath                        |   10 -
 org.spearce.jgit/.gitignore                        |    6 +-
 org.spearce.jgit/.project                          |   34 --
 .../.settings/org.eclipse.core.resources.prefs     |    3 -
 .../.settings/org.eclipse.core.runtime.prefs       |    3 -
 .../.settings/org.eclipse.jdt.core.prefs           |  321 --------------------
 .../.settings/org.eclipse.jdt.ui.prefs             |    9 -
 .../.settings/org.maven.ide.eclipse.prefs          |    9 -
 15 files changed, 10 insertions(+), 751 deletions(-)
 delete mode 100644 org.spearce.jgit.pgm/.classpath
 delete mode 100644 org.spearce.jgit.pgm/.project
 delete mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
 delete mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
 delete mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
 delete mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
 delete mode 100644 org.spearce.jgit/.classpath
 delete mode 100644 org.spearce.jgit/.project
 delete mode 100644 org.spearce.jgit/.settings/org.eclipse.core.resources.prefs
 delete mode 100644 org.spearce.jgit/.settings/org.eclipse.core.runtime.prefs
 delete mode 100644 org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
 delete mode 100644 org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
 delete mode 100644 org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs

diff --git a/org.spearce.jgit.pgm/.classpath b/org.spearce.jgit.pgm/.classpath
deleted file mode 100644
index 50dd6d3..0000000
--- a/org.spearce.jgit.pgm/.classpath
+++ /dev/null
@@ -1,8 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<classpath>
-	<classpathentry kind="src" path="src"/>
-	<classpathentry exported="true" kind="lib" path="lib/args4j-2.0.9.jar" sourcepath="lib/args4j-2.0.9.zip"/>
-	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
-	<classpathentry combineaccessrules="false" exported="true" kind="src" path="/org.spearce.jgit"/>
-	<classpathentry kind="output" path="bin"/>
-</classpath>
diff --git a/org.spearce.jgit.pgm/.gitignore b/org.spearce.jgit.pgm/.gitignore
index ea8c4bf..60a813a 100644
--- a/org.spearce.jgit.pgm/.gitignore
+++ b/org.spearce.jgit.pgm/.gitignore
@@ -1 +1,6 @@
 /target
+/.classpath
+/.project
+/.settings
+/*.iwl
+/*.ipr
diff --git a/org.spearce.jgit.pgm/.project b/org.spearce.jgit.pgm/.project
deleted file mode 100644
index e642f9e..0000000
--- a/org.spearce.jgit.pgm/.project
+++ /dev/null
@@ -1,17 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<projectDescription>
-	<name>org.spearce.jgit.pgm</name>
-	<comment></comment>
-	<projects>
-	</projects>
-	<buildSpec>
-		<buildCommand>
-			<name>org.eclipse.jdt.core.javabuilder</name>
-			<arguments>
-			</arguments>
-		</buildCommand>
-	</buildSpec>
-	<natures>
-		<nature>org.eclipse.jdt.core.javanature</nature>
-	</natures>
-</projectDescription>
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
deleted file mode 100644
index 759548b..0000000
--- a/org.spearce.jgit.pgm/.settings/org.eclipse.core.resources.prefs
+++ /dev/null
@@ -1,3 +0,0 @@
-#Mon Aug 11 16:46:23 PDT 2008
-eclipse.preferences.version=1
-encoding/<project>=UTF-8
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
deleted file mode 100644
index 006e07e..0000000
--- a/org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
+++ /dev/null
@@ -1,3 +0,0 @@
-#Mon Mar 24 18:55:50 EDT 2008
-eclipse.preferences.version=1
-line.separator=\n
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
deleted file mode 100644
index f0c80d3..0000000
--- a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
+++ /dev/null
@@ -1,321 +0,0 @@
-#Sun Mar 15 19:46:39 CET 2009
-eclipse.preferences.version=1
-org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
-org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
-org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
-org.eclipse.jdt.core.compiler.compliance=1.5
-org.eclipse.jdt.core.compiler.debug.lineNumber=generate
-org.eclipse.jdt.core.compiler.debug.localVariable=generate
-org.eclipse.jdt.core.compiler.debug.sourceFile=generate
-org.eclipse.jdt.core.compiler.doc.comment.support=enabled
-org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
-org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
-org.eclipse.jdt.core.compiler.problem.autoboxing=warning
-org.eclipse.jdt.core.compiler.problem.deprecation=warning
-org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
-org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
-org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
-org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
-org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
-org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
-org.eclipse.jdt.core.compiler.problem.fieldHiding=warning
-org.eclipse.jdt.core.compiler.problem.finalParameterBound=warning
-org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
-org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
-org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
-org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
-org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
-org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
-org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsDeprecatedRef=enabled
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsNotVisibleRef=enabled
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
-org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
-org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
-org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingJavadocComments=error
-org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagDescription=return_tag
-org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=protected
-org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
-org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
-org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
-org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
-org.eclipse.jdt.core.compiler.problem.nullReference=warning
-org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
-org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
-org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
-org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
-org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
-org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
-org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
-org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
-org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
-org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
-org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
-org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
-org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
-org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
-org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
-org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=warning
-org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.unusedImport=error
-org.eclipse.jdt.core.compiler.problem.unusedLabel=error
-org.eclipse.jdt.core.compiler.problem.unusedLocal=error
-org.eclipse.jdt.core.compiler.problem.unusedParameter=warning
-org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=disabled
-org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
-org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
-org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
-org.eclipse.jdt.core.compiler.source=1.5
-org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_explicit_constructor_call=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_qualified_allocation_expression=16
-org.eclipse.jdt.core.formatter.alignment_for_assignment=0
-org.eclipse.jdt.core.formatter.alignment_for_binary_expression=16
-org.eclipse.jdt.core.formatter.alignment_for_compact_if=16
-org.eclipse.jdt.core.formatter.alignment_for_conditional_expression=80
-org.eclipse.jdt.core.formatter.alignment_for_enum_constants=0
-org.eclipse.jdt.core.formatter.alignment_for_expressions_in_array_initializer=16
-org.eclipse.jdt.core.formatter.alignment_for_multiple_fields=16
-org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation=16
-org.eclipse.jdt.core.formatter.alignment_for_superclass_in_type_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_type_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_constructor_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_method_declaration=16
-org.eclipse.jdt.core.formatter.blank_lines_after_imports=1
-org.eclipse.jdt.core.formatter.blank_lines_after_package=1
-org.eclipse.jdt.core.formatter.blank_lines_before_field=1
-org.eclipse.jdt.core.formatter.blank_lines_before_first_class_body_declaration=0
-org.eclipse.jdt.core.formatter.blank_lines_before_imports=1
-org.eclipse.jdt.core.formatter.blank_lines_before_member_type=1
-org.eclipse.jdt.core.formatter.blank_lines_before_method=1
-org.eclipse.jdt.core.formatter.blank_lines_before_new_chunk=1
-org.eclipse.jdt.core.formatter.blank_lines_before_package=0
-org.eclipse.jdt.core.formatter.blank_lines_between_type_declarations=1
-org.eclipse.jdt.core.formatter.brace_position_for_annotation_type_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_anonymous_type_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_array_initializer=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_block=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_block_in_case=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_enum_constant=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_enum_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_method_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_switch=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_type_declaration=end_of_line
-org.eclipse.jdt.core.formatter.comment.clear_blank_lines=false
-org.eclipse.jdt.core.formatter.comment.format_comments=true
-org.eclipse.jdt.core.formatter.comment.format_header=false
-org.eclipse.jdt.core.formatter.comment.format_html=true
-org.eclipse.jdt.core.formatter.comment.format_source_code=true
-org.eclipse.jdt.core.formatter.comment.indent_parameter_description=true
-org.eclipse.jdt.core.formatter.comment.indent_root_tags=true
-org.eclipse.jdt.core.formatter.comment.insert_new_line_before_root_tags=insert
-org.eclipse.jdt.core.formatter.comment.insert_new_line_for_parameter=insert
-org.eclipse.jdt.core.formatter.comment.line_length=80
-org.eclipse.jdt.core.formatter.compact_else_if=true
-org.eclipse.jdt.core.formatter.continuation_indentation=2
-org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer=2
-org.eclipse.jdt.core.formatter.format_guardian_clause_on_one_line=false
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_annotation_declaration_header=true
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_constant_header=true
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_declaration_header=true
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header=true
-org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases=true
-org.eclipse.jdt.core.formatter.indent_empty_lines=false
-org.eclipse.jdt.core.formatter.indent_statements_compare_to_block=true
-org.eclipse.jdt.core.formatter.indent_statements_compare_to_body=true
-org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases=true
-org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch=false
-org.eclipse.jdt.core.formatter.indentation.size=4
-org.eclipse.jdt.core.formatter.insert_new_line_after_annotation=insert
-org.eclipse.jdt.core.formatter.insert_new_line_after_opening_brace_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_catch_in_try_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_closing_brace_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_else_in_if_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_finally_in_try_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_while_in_do_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_annotation_declaration=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_anonymous_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_block=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_constant=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_declaration=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_method_body=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_after_and_in_type_parameter=insert
-org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation_type_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_binary_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_brace_in_block=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_paren_in_cast=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_assert=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_case=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_labeled_statement=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_allocation_expression=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_annotation=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_throws=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_constant_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_declarations=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_explicitconstructorcall_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_increments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_inits=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_throws=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_field_declarations=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_local_declarations=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_parameterized_type_reference=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_superinterfaces=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_ellipsis=insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_brace_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_cast=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_catch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_for=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_if=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_parenthesized_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_switch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_synchronized=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_while=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_postfix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_prefix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_question_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_after_question_in_wildcard=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_after_unary_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_and_in_type_parameter=insert
-org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_before_at_in_annotation_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_binary_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_brace_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_cast=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_catch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_for=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_if=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_parenthesized_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_switch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_synchronized=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_while=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_assert=insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_case=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_default=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_labeled_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_throws=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_constant_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_declarations=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_explicitconstructorcall_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_increments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_inits=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_throws=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_invocation_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_field_declarations=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_local_declarations=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_superinterfaces=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_ellipsis=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_annotation_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_anonymous_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_constructor_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_constant=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_switch=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation_type_member_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_catch=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_parenthesized_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_switch=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_synchronized=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while=insert
-org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_return=insert
-org.eclipse.jdt.core.formatter.insert_space_before_postfix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_prefix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_question_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_before_question_in_wildcard=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_semicolon=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_for=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_unary_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_brackets_in_array_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_braces_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_brackets_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_annotation_type_member_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line=false
-org.eclipse.jdt.core.formatter.keep_empty_array_initializer_on_one_line=false
-org.eclipse.jdt.core.formatter.keep_imple_if_on_one_line=false
-org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line=false
-org.eclipse.jdt.core.formatter.lineSplit=80
-org.eclipse.jdt.core.formatter.number_of_blank_lines_at_beginning_of_method_body=0
-org.eclipse.jdt.core.formatter.number_of_empty_lines_to_preserve=1
-org.eclipse.jdt.core.formatter.put_empty_statement_on_new_line=true
-org.eclipse.jdt.core.formatter.tabulation.char=tab
-org.eclipse.jdt.core.formatter.tabulation.size=4
-org.eclipse.jdt.core.formatter.use_tabs_only_for_leading_indentations=false
diff --git a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
deleted file mode 100644
index 709a440..0000000
--- a/org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
+++ /dev/null
@@ -1,9 +0,0 @@
-#Wed May 09 00:20:24 CEST 2007
-eclipse.preferences.version=1
-formatter_profile=_JGit
-formatter_settings_version=10
-org.eclipse.jdt.ui.ignorelowercasenames=true
-org.eclipse.jdt.ui.importorder=java;javax;org;com;
-org.eclipse.jdt.ui.ondemandthreshold=99
-org.eclipse.jdt.ui.staticondemandthreshold=99
-org.eclipse.jdt.ui.text.custom_code_templates=<?xml version\="1.0" encoding\="UTF-8"?><templates/>
diff --git a/org.spearce.jgit/.classpath b/org.spearce.jgit/.classpath
deleted file mode 100644
index c1c8f51..0000000
--- a/org.spearce.jgit/.classpath
+++ /dev/null
@@ -1,10 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<classpath>
-	<classpathentry kind="src" output="target/classes" path="src/main/java"/>
-	<classpathentry kind="src" output="target/test-classes" path="src/test/java"/>
-	<classpathentry excluding="**" kind="src" output="target/test-classes" path="src/test/resources"/>
-	<classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/J2SE-1.5"/>
-	<classpathentry kind="con" path="org.eclipse.pde.core.requiredPlugins"/>
-	<classpathentry kind="con" path="org.maven.ide.eclipse.MAVEN2_CLASSPATH_CONTAINER"/>
-	<classpathentry kind="output" path="target/classes"/>
-</classpath>
diff --git a/org.spearce.jgit/.gitignore b/org.spearce.jgit/.gitignore
index 934e0e0..60a813a 100644
--- a/org.spearce.jgit/.gitignore
+++ b/org.spearce.jgit/.gitignore
@@ -1,2 +1,6 @@
-/bin
 /target
+/.classpath
+/.project
+/.settings
+/*.iwl
+/*.ipr
diff --git a/org.spearce.jgit/.project b/org.spearce.jgit/.project
deleted file mode 100644
index da2f7cf..0000000
--- a/org.spearce.jgit/.project
+++ /dev/null
@@ -1,34 +0,0 @@
-<?xml version="1.0" encoding="UTF-8"?>
-<projectDescription>
-	<name>org.spearce.jgit</name>
-	<comment></comment>
-	<projects>
-	</projects>
-	<buildSpec>
-		<buildCommand>
-			<name>org.eclipse.jdt.core.javabuilder</name>
-			<arguments>
-			</arguments>
-		</buildCommand>
-		<buildCommand>
-			<name>org.eclipse.pde.ManifestBuilder</name>
-			<arguments>
-			</arguments>
-		</buildCommand>
-		<buildCommand>
-			<name>org.eclipse.pde.SchemaBuilder</name>
-			<arguments>
-			</arguments>
-		</buildCommand>
-		<buildCommand>
-			<name>org.maven.ide.eclipse.maven2Builder</name>
-			<arguments>
-			</arguments>
-		</buildCommand>
-	</buildSpec>
-	<natures>
-		<nature>org.maven.ide.eclipse.maven2Nature</nature>
-		<nature>org.eclipse.jdt.core.javanature</nature>
-		<nature>org.eclipse.pde.PluginNature</nature>
-	</natures>
-</projectDescription>
diff --git a/org.spearce.jgit/.settings/org.eclipse.core.resources.prefs b/org.spearce.jgit/.settings/org.eclipse.core.resources.prefs
deleted file mode 100644
index 66ac15c..0000000
--- a/org.spearce.jgit/.settings/org.eclipse.core.resources.prefs
+++ /dev/null
@@ -1,3 +0,0 @@
-#Mon Aug 11 16:46:12 PDT 2008
-eclipse.preferences.version=1
-encoding/<project>=UTF-8
diff --git a/org.spearce.jgit/.settings/org.eclipse.core.runtime.prefs b/org.spearce.jgit/.settings/org.eclipse.core.runtime.prefs
deleted file mode 100644
index cce0568..0000000
--- a/org.spearce.jgit/.settings/org.eclipse.core.runtime.prefs
+++ /dev/null
@@ -1,3 +0,0 @@
-#Mon Mar 24 18:55:50 EDT 2008
-eclipse.preferences.version=1
-line.separator=\n
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
deleted file mode 100644
index 22d560f..0000000
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.core.prefs
+++ /dev/null
@@ -1,321 +0,0 @@
-#Fri Sep 04 16:53:41 CEST 2009
-eclipse.preferences.version=1
-org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled
-org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.5
-org.eclipse.jdt.core.compiler.codegen.unusedLocal=preserve
-org.eclipse.jdt.core.compiler.compliance=1.5
-org.eclipse.jdt.core.compiler.debug.lineNumber=generate
-org.eclipse.jdt.core.compiler.debug.localVariable=generate
-org.eclipse.jdt.core.compiler.debug.sourceFile=generate
-org.eclipse.jdt.core.compiler.doc.comment.support=enabled
-org.eclipse.jdt.core.compiler.problem.annotationSuperInterface=warning
-org.eclipse.jdt.core.compiler.problem.assertIdentifier=error
-org.eclipse.jdt.core.compiler.problem.autoboxing=warning
-org.eclipse.jdt.core.compiler.problem.deprecation=warning
-org.eclipse.jdt.core.compiler.problem.deprecationInDeprecatedCode=disabled
-org.eclipse.jdt.core.compiler.problem.deprecationWhenOverridingDeprecatedMethod=disabled
-org.eclipse.jdt.core.compiler.problem.discouragedReference=warning
-org.eclipse.jdt.core.compiler.problem.emptyStatement=warning
-org.eclipse.jdt.core.compiler.problem.enumIdentifier=error
-org.eclipse.jdt.core.compiler.problem.fallthroughCase=warning
-org.eclipse.jdt.core.compiler.problem.fieldHiding=warning
-org.eclipse.jdt.core.compiler.problem.finalParameterBound=warning
-org.eclipse.jdt.core.compiler.problem.finallyBlockNotCompletingNormally=error
-org.eclipse.jdt.core.compiler.problem.forbiddenReference=error
-org.eclipse.jdt.core.compiler.problem.hiddenCatchBlock=error
-org.eclipse.jdt.core.compiler.problem.incompatibleNonInheritedInterfaceMethod=warning
-org.eclipse.jdt.core.compiler.problem.incompleteEnumSwitch=warning
-org.eclipse.jdt.core.compiler.problem.indirectStaticAccess=error
-org.eclipse.jdt.core.compiler.problem.invalidJavadoc=error
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTags=enabled
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsDeprecatedRef=enabled
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsNotVisibleRef=enabled
-org.eclipse.jdt.core.compiler.problem.invalidJavadocTagsVisibility=private
-org.eclipse.jdt.core.compiler.problem.localVariableHiding=warning
-org.eclipse.jdt.core.compiler.problem.methodWithConstructorName=error
-org.eclipse.jdt.core.compiler.problem.missingDeprecatedAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingJavadocComments=warning
-org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocCommentsVisibility=protected
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagDescription=return_tag
-org.eclipse.jdt.core.compiler.problem.missingJavadocTags=error
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagsOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.missingJavadocTagsVisibility=private
-org.eclipse.jdt.core.compiler.problem.missingOverrideAnnotation=ignore
-org.eclipse.jdt.core.compiler.problem.missingSerialVersion=warning
-org.eclipse.jdt.core.compiler.problem.noEffectAssignment=error
-org.eclipse.jdt.core.compiler.problem.noImplicitStringConversion=error
-org.eclipse.jdt.core.compiler.problem.nonExternalizedStringLiteral=ignore
-org.eclipse.jdt.core.compiler.problem.nullReference=warning
-org.eclipse.jdt.core.compiler.problem.overridingPackageDefaultMethod=warning
-org.eclipse.jdt.core.compiler.problem.parameterAssignment=ignore
-org.eclipse.jdt.core.compiler.problem.possibleAccidentalBooleanAssignment=error
-org.eclipse.jdt.core.compiler.problem.potentialNullReference=warning
-org.eclipse.jdt.core.compiler.problem.rawTypeReference=ignore
-org.eclipse.jdt.core.compiler.problem.redundantNullCheck=warning
-org.eclipse.jdt.core.compiler.problem.specialParameterHidingField=disabled
-org.eclipse.jdt.core.compiler.problem.staticAccessReceiver=error
-org.eclipse.jdt.core.compiler.problem.suppressWarnings=enabled
-org.eclipse.jdt.core.compiler.problem.typeParameterHiding=warning
-org.eclipse.jdt.core.compiler.problem.uncheckedTypeOperation=warning
-org.eclipse.jdt.core.compiler.problem.undocumentedEmptyBlock=warning
-org.eclipse.jdt.core.compiler.problem.unhandledWarningToken=warning
-org.eclipse.jdt.core.compiler.problem.unnecessaryTypeCheck=error
-org.eclipse.jdt.core.compiler.problem.unqualifiedFieldAccess=ignore
-org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownException=warning
-org.eclipse.jdt.core.compiler.problem.unusedDeclaredThrownExceptionWhenOverriding=disabled
-org.eclipse.jdt.core.compiler.problem.unusedImport=error
-org.eclipse.jdt.core.compiler.problem.unusedLabel=error
-org.eclipse.jdt.core.compiler.problem.unusedLocal=error
-org.eclipse.jdt.core.compiler.problem.unusedParameter=warning
-org.eclipse.jdt.core.compiler.problem.unusedParameterWhenImplementingAbstract=disabled
-org.eclipse.jdt.core.compiler.problem.unusedParameterWhenOverridingConcrete=disabled
-org.eclipse.jdt.core.compiler.problem.unusedPrivateMember=error
-org.eclipse.jdt.core.compiler.problem.varargsArgumentNeedCast=error
-org.eclipse.jdt.core.compiler.source=1.5
-org.eclipse.jdt.core.formatter.align_type_members_on_columns=false
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_explicit_constructor_call=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation=16
-org.eclipse.jdt.core.formatter.alignment_for_arguments_in_qualified_allocation_expression=16
-org.eclipse.jdt.core.formatter.alignment_for_assignment=0
-org.eclipse.jdt.core.formatter.alignment_for_binary_expression=16
-org.eclipse.jdt.core.formatter.alignment_for_compact_if=16
-org.eclipse.jdt.core.formatter.alignment_for_conditional_expression=80
-org.eclipse.jdt.core.formatter.alignment_for_enum_constants=0
-org.eclipse.jdt.core.formatter.alignment_for_expressions_in_array_initializer=16
-org.eclipse.jdt.core.formatter.alignment_for_multiple_fields=16
-org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation=16
-org.eclipse.jdt.core.formatter.alignment_for_superclass_in_type_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_type_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_constructor_declaration=16
-org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_method_declaration=16
-org.eclipse.jdt.core.formatter.blank_lines_after_imports=1
-org.eclipse.jdt.core.formatter.blank_lines_after_package=1
-org.eclipse.jdt.core.formatter.blank_lines_before_field=1
-org.eclipse.jdt.core.formatter.blank_lines_before_first_class_body_declaration=0
-org.eclipse.jdt.core.formatter.blank_lines_before_imports=1
-org.eclipse.jdt.core.formatter.blank_lines_before_member_type=1
-org.eclipse.jdt.core.formatter.blank_lines_before_method=1
-org.eclipse.jdt.core.formatter.blank_lines_before_new_chunk=1
-org.eclipse.jdt.core.formatter.blank_lines_before_package=0
-org.eclipse.jdt.core.formatter.blank_lines_between_type_declarations=1
-org.eclipse.jdt.core.formatter.brace_position_for_annotation_type_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_anonymous_type_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_array_initializer=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_block=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_block_in_case=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_enum_constant=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_enum_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_method_declaration=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_switch=end_of_line
-org.eclipse.jdt.core.formatter.brace_position_for_type_declaration=end_of_line
-org.eclipse.jdt.core.formatter.comment.clear_blank_lines=false
-org.eclipse.jdt.core.formatter.comment.format_comments=true
-org.eclipse.jdt.core.formatter.comment.format_header=false
-org.eclipse.jdt.core.formatter.comment.format_html=true
-org.eclipse.jdt.core.formatter.comment.format_source_code=true
-org.eclipse.jdt.core.formatter.comment.indent_parameter_description=true
-org.eclipse.jdt.core.formatter.comment.indent_root_tags=true
-org.eclipse.jdt.core.formatter.comment.insert_new_line_before_root_tags=insert
-org.eclipse.jdt.core.formatter.comment.insert_new_line_for_parameter=insert
-org.eclipse.jdt.core.formatter.comment.line_length=80
-org.eclipse.jdt.core.formatter.compact_else_if=true
-org.eclipse.jdt.core.formatter.continuation_indentation=2
-org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer=2
-org.eclipse.jdt.core.formatter.format_guardian_clause_on_one_line=false
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_annotation_declaration_header=true
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_constant_header=true
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_declaration_header=true
-org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header=true
-org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases=true
-org.eclipse.jdt.core.formatter.indent_empty_lines=false
-org.eclipse.jdt.core.formatter.indent_statements_compare_to_block=true
-org.eclipse.jdt.core.formatter.indent_statements_compare_to_body=true
-org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases=true
-org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch=false
-org.eclipse.jdt.core.formatter.indentation.size=4
-org.eclipse.jdt.core.formatter.insert_new_line_after_annotation=insert
-org.eclipse.jdt.core.formatter.insert_new_line_after_opening_brace_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_catch_in_try_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_closing_brace_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_else_in_if_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_finally_in_try_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_before_while_in_do_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_annotation_declaration=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_anonymous_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_block=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_constant=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_declaration=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_method_body=insert
-org.eclipse.jdt.core.formatter.insert_new_line_in_empty_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_after_and_in_type_parameter=insert
-org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation_type_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_binary_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_brace_in_block=insert
-org.eclipse.jdt.core.formatter.insert_space_after_closing_paren_in_cast=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_assert=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_case=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_after_colon_in_labeled_statement=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_allocation_expression=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_annotation=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_throws=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_constant_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_declarations=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_explicitconstructorcall_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_increments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_inits=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_throws=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_field_declarations=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_local_declarations=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_parameterized_type_reference=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_superinterfaces=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_arguments=insert
-org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_parameters=insert
-org.eclipse.jdt.core.formatter.insert_space_after_ellipsis=insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_brace_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_cast=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_catch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_for=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_if=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_parenthesized_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_switch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_synchronized=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_while=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_postfix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_prefix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_question_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_after_question_in_wildcard=do not insert
-org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_after_unary_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_and_in_type_parameter=insert
-org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_before_at_in_annotation_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_binary_operator=insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_brace_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_cast=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_catch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_for=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_if=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_parenthesized_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_switch=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_synchronized=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_while=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_assert=insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_case=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_default=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_before_colon_in_labeled_statement=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_throws=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_constant_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_declarations=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_explicitconstructorcall_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_increments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_inits=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_throws=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_invocation_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_field_declarations=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_local_declarations=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_superinterfaces=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_ellipsis=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_parameterized_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_arguments=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_parameters=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_annotation_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_anonymous_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_array_initializer=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_constructor_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_constant=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_switch=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation_type_member_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_catch=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_parenthesized_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_switch=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_synchronized=insert
-org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while=insert
-org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_return=insert
-org.eclipse.jdt.core.formatter.insert_space_before_postfix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_prefix_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_question_in_conditional=insert
-org.eclipse.jdt.core.formatter.insert_space_before_question_in_wildcard=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_semicolon=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_for=do not insert
-org.eclipse.jdt.core.formatter.insert_space_before_unary_operator=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_brackets_in_array_type_reference=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_braces_in_array_initializer=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_brackets_in_array_allocation_expression=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_annotation_type_member_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_constructor_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_enum_constant=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_declaration=do not insert
-org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_invocation=do not insert
-org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line=false
-org.eclipse.jdt.core.formatter.keep_empty_array_initializer_on_one_line=false
-org.eclipse.jdt.core.formatter.keep_imple_if_on_one_line=false
-org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line=false
-org.eclipse.jdt.core.formatter.lineSplit=80
-org.eclipse.jdt.core.formatter.number_of_blank_lines_at_beginning_of_method_body=0
-org.eclipse.jdt.core.formatter.number_of_empty_lines_to_preserve=1
-org.eclipse.jdt.core.formatter.put_empty_statement_on_new_line=true
-org.eclipse.jdt.core.formatter.tabulation.char=tab
-org.eclipse.jdt.core.formatter.tabulation.size=4
-org.eclipse.jdt.core.formatter.use_tabs_only_for_leading_indentations=false
diff --git a/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs b/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
deleted file mode 100644
index 709a440..0000000
--- a/org.spearce.jgit/.settings/org.eclipse.jdt.ui.prefs
+++ /dev/null
@@ -1,9 +0,0 @@
-#Wed May 09 00:20:24 CEST 2007
-eclipse.preferences.version=1
-formatter_profile=_JGit
-formatter_settings_version=10
-org.eclipse.jdt.ui.ignorelowercasenames=true
-org.eclipse.jdt.ui.importorder=java;javax;org;com;
-org.eclipse.jdt.ui.ondemandthreshold=99
-org.eclipse.jdt.ui.staticondemandthreshold=99
-org.eclipse.jdt.ui.text.custom_code_templates=<?xml version\="1.0" encoding\="UTF-8"?><templates/>
diff --git a/org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs b/org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs
deleted file mode 100644
index 1e219ee..0000000
--- a/org.spearce.jgit/.settings/org.maven.ide.eclipse.prefs
+++ /dev/null
@@ -1,9 +0,0 @@
-#Fri Sep 04 16:35:48 CEST 2009
-activeProfiles=
-eclipse.preferences.version=1
-fullBuildGoals=process-test-resources
-includeModules=false
-resolveWorkspaceProjects=true
-resourceFilterGoals=process-resources resources\:testResources
-skipCompilerPlugin=true
-version=1
-- 
1.6.2.5
