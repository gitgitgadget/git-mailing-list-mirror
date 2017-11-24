Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889AB2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 19:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbdKXTCv (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 14:02:51 -0500
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:56882
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753722AbdKXTCu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2017 14:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1511550168;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=6SpH/EKBfZUDaxjoMU6mE+vSZll/X26P0p41SDE391g=;
        b=djI5DcnW6y8CrTUDZ5hucHE1unMgXuiMfl2eyH2CjyoPM8r5f3EG6DP9+YBOTqbv
        NXGmIwgDgl3FkihhxjwGhiyKWbcf/QOWWmXVF8pquKQPQv+caAjyHM3RfmbOtrurWyZ
        GtbDpS0LcNC7z10xkEyZqCKsT/59r41//yJz+Qa0=
From:   Stepan Kashuba <ihaterabbids@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015fef692e1e-3a4dbc30-1a94-4e9b-a8a5-135a23e203ed-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Fixed Russian translation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 24 Nov 2017 19:02:48 +0000
X-SES-Outgoing: 2017.11.24-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 po/ru.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index d4370b5941a13..4ce3d38047303 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -1,7 +1,7 @@
 # SOME DESCRIPTIVE TITLE.
 # Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
 # This file is distributed under the same license as the PACKAGE package.
-#=20
+#
 # Translators:
 # Dimitriy Ryazantcev <DJm00n@mail.ru>, 2014-2017
 # insolor, 2014
@@ -3421,7 +3421,7 @@ msgstr "=D0=BE=D0=B1=D0=BD=D0=B0=D1=80=D1=83=D0=B6=D0=
=B5=D0=BD=D1=8B =D0=BD=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D1=
=8B=D0=B5 =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B5=D0=BD=D0=B8=D1=8F =D1=
=80=D0=B5=D0=BF
 #: setup.c:806
 #, c-format
 msgid "Not a git repository (or any of the parent directories): %s"
-msgstr "=D0=9D=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD git =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D0=B8=D0=B9 (=D0=B8=D0=BB=D0=B8 =D0=BE=
=D0=B4=D0=B8=D0=BD =D0=B8=D0=B7 =D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3=D0=BE=D0=B2): %s"
+msgstr "=D0=9D=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD git =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9 (=D0=B8=D0=BB=D0=B8 =
=D0=BE=D0=B4=D0=B8=D0=BD =D0=B8=D0=B7 =D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=BE=D0=B2): %s"
=20
 #: setup.c:808 builtin/index-pack.c:1653
 msgid "Cannot come back to cwd"
@@ -3441,7 +3441,7 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=
=D1=81=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B0 =
=C2=AB%s=C2=BB"
 msgid ""
 "Not a git repository (or any parent up to mount point %s)\n"
 "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)=
."
-msgstr "=D0=9D=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD git =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D0=B8=D0=B9 (=D0=B8=D0=BB=D0=B8 =D0=BE=
=D0=B4=D0=B8=D0=BD =D0=B8=D0=B7 =D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3=D0=BE=D0=B2 =D0=B2=D0=BF=D0=BB=D0=BE=D1=82=D1=8C =D0=B4=
=D0=BE =D1=82=D0=BE=D1=87=D0=BA=D0=B8 =D0=BC=D0=BE=D0=BD=D1=82=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F %s)\n=D0=9E=D1=81=D1=82=D0=B0=D0=BD=D0=
=B0=D0=B2=D0=BB=D0=B8=D0=B2=D0=B0=D1=8E =D0=BF=D0=BE=D0=B8=D1=81=D0=BA =D0=
=BD=D0=B0 =D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B5 =D1=84=D0=B0=D0=B9=D0=
=BB=D0=BE=D0=B2=D0=BE=D0=B9 =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D1=8B (=D1=
=82=D0=B0=D0=BA =D0=BA=D0=B0=D0=BA GIT_DISCOVERY_ACROSS_FILESYSTEM =D0=BD=
=D0=B5 =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD)."
+msgstr "=D0=9D=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD git =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9 (=D0=B8=D0=BB=D0=B8 =
=D0=BE=D0=B4=D0=B8=D0=BD =D0=B8=D0=B7 =D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=BE=D0=B2 =D0=B2=D0=BF=D0=BB=D0=BE=D1=82=D1=8C =
=D0=B4=D0=BE =D1=82=D0=BE=D1=87=D0=BA=D0=B8 =D0=BC=D0=BE=D0=BD=D1=82=D0=B8=
=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F %s)\n=D0=9E=D1=81=D1=82=D0=B0=D0=
=BD=D0=B0=D0=B2=D0=BB=D0=B8=D0=B2=D0=B0=D1=8E =D0=BF=D0=BE=D0=B8=D1=81=D0=
=BA =D0=BD=D0=B0 =D0=B3=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B5 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=BE=D0=B2=D0=BE=D0=B9 =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D1=
=8B (=D1=82=D0=B0=D0=BA =D0=BA=D0=B0=D0=BA GIT_DISCOVERY_ACROSS_FILESYSTEM =
=D0=BD=D0=B5 =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD).=
"
=20
 #: setup.c:1159
 #, c-format
@@ -7436,7 +7436,7 @@ msgstr "=D0=BD=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=
=BB=D1=8C=D0=BD=D1=8B=D0=B9 =D0=BF=D0=B0=D1=80=D0=B0=D0=BC=D0=B5=D1=82=D1=
=80: %s"
=20
 #: builtin/diff.c:357
 msgid "Not a git repository"
-msgstr "=D0=9D=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD git =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D0=B8=D0=B9"
+msgstr "=D0=9D=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD git =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
 #: builtin/diff.c:400
 #, c-format

--
https://github.com/git/git/pull/435
