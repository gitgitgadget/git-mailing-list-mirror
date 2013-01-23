From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/6] Change 'git' to 'Git' whenever the whole system
 is referred to #4
Date: Tue, 22 Jan 2013 19:16:20 -0800
Message-ID: <7v7gn4k2rf.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1199035912.632874.1358796172804.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:16:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxqpR-0002IE-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 04:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab3AWDQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 22:16:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3AWDQX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 22:16:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69C32BECB;
	Tue, 22 Jan 2013 22:16:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C5bfabWFCfaBP83DK8shJHEIbQg=; b=bUAtFZ
	jhryG7sqIFGmh4Cq5+R3gLSedcMLBNvlF4uFNIatLCX7O5i4Dvyk7XitrFHMrJQf
	U6nParOApylSWKoaZ0bFp0m+bOqfH7u+mDQEnEO/0WS+NSmqrI2Oi//Mbzlz5Ve2
	jOWnpB9vGHBep6Yn3k6Dv5zLxX1WMW/RGYWfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ws7RywVInXnFU0XxoaYnbWEQlfi3CqgJ
	n6Cm8HWGIzo5hga98cdh1D2iisyO1+MAFLCZd0qqx8LGPcz7gB5S5fzaslH14ivB
	LazYlyvgDgEGH9OqFl2blM+hV8dv0bdmX9oaiCDVt95j1g9iuTHUU5av9oyfbLKm
	DHxgfGouiII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E9A0BEC9;
	Tue, 22 Jan 2013 22:16:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9477ABEC8; Tue, 22 Jan 2013
 22:16:21 -0500 (EST)
In-Reply-To: <1199035912.632874.1358796172804.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 20:22:52 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42E9255A-650B-11E2-8B1E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214277>

Leftover in paths touched by [5/6].

 Documentation/gitcvs-migration.txt          | 2 +-
 Documentation/technical/api-builtin.txt     | 2 +-
 Documentation/technical/api-credentials.txt | 4 ++--
 Documentation/technical/api-remote.txt      | 2 +-
 Documentation/urls.txt                      | 2 +-
 Documentation/user-manual.txt               | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 2934ac2..5ab5b07 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -3,7 +3,7 @@ gitcvs-migration(7)
 
 NAME
 ----
-gitcvs-migration - git for CVS users
+gitcvs-migration - Git for CVS users
 
 SYNOPSIS
 --------
diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
index 2d27ff1..4a4228b 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -5,7 +5,7 @@ Adding a new built-in
 ---------------------
 
 There are 4 things to do to add a built-in command implementation to
-git:
+Git:
 
 . Define the implementation of the built-in command `foo` with
   signature:
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index f0c39e1..516fda7 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -18,7 +18,7 @@ Typical setup
 
 ------------
 +-----------------------+
-| git code (C)          |--- to server requiring --->
+| Git code (C)          |--- to server requiring --->
 |                       |        authentication
 |.......................|
 | C credential API      |--- prompt ---> User
@@ -27,7 +27,7 @@ Typical setup
 	| pipe |
 	|      v
 +-----------------------+
-| git credential helper |
+| Git credential helper |
 +-----------------------+
 ------------
 
diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
index 2819d3a..4be8776 100644
--- a/Documentation/technical/api-remote.txt
+++ b/Documentation/technical/api-remote.txt
@@ -45,7 +45,7 @@ struct remote
 `receivepack`, `uploadpack`::
 
 	The configured helper programs to run on the remote side, for
-	git-native protocols.
+	Git-native protocols.
 
 `http_proxy`::
 
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index a2cf68b..539c0a0 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -29,7 +29,7 @@ The ssh and git protocols additionally support ~username expansion:
 - git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
 - {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
 
-For local repositories, also supported by git natively, the following
+For local repositories, also supported by Git natively, the following
 syntaxes may be used:
 
 - /path/to/repo.git/
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index dda262a..5077e7c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1439,7 +1439,7 @@ fundamentally different ways to fix the problem:
 
 	2. You can go back and modify the old commit.  You should
 	never do this if you have already made the history public;
-	git does not normally expect the "history" of a project to
+	Git does not normally expect the "history" of a project to
 	change, and cannot correctly perform repeated merges from
 	a branch that has had its history changed.
 
@@ -3671,7 +3671,7 @@ Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path
 
 In older Git versions it could be easily forgotten to commit new or modified
 files in a submodule, which silently leads to similar problems as not pushing
-the submodule changes. Starting with git 1.7.0 both "git status" and "git diff"
+the submodule changes. Starting with Git 1.7.0 both "git status" and "git diff"
 in the superproject show submodules as modified when they contain new or
 modified files to protect against accidentally committing such a state. "git
 diff" will also add a "-dirty" to the work tree side when generating patch
-- 
1.8.1.1.507.g1754052
