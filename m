From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: =?UTF-8?q?=5Bgitweb=5D=20Removed=20reference=20to=20git=2Ekernel=2Eorg?=
Date: Thu,  7 Mar 2013 02:23:43 +0100
Message-ID: <1362619423-17105-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 07 02:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDPYz-0007wH-GD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 02:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab3CGBXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 20:23:39 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42758 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab3CGBXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 20:23:39 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so13518lbb.40
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 17:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ThxlcXiVbqmD+ZOz8uVOhNdaZ91jjZcKF2gTbRHv9qc=;
        b=XYGJfMp5tDb+g1kZDYhOD+R6KAYL6cMe6aoExt2RiDKakTWXpMJKyDCv+/tiDuKGvV
         M/RvYJcwx/W83nm7UO9BjPXS9CjCY8thkiTVk98qnxBt4GLipoa+E+bCeo7/93RJDUzs
         WPfd4Bqf3BLoq4yn9MO3xjKRBcsYg6rlG+2Wp8lDCfCAt537M/pZjbZCXZarkDoVnGDk
         Gx5iyZeP6AZALSPeJ4ZPGboNDU3j8rjwVkWuxCQnxrtnUjLbhYadkvEfmG85htCEIXFA
         TuMGy5bypjf7lmSXJCUlsq/Vqgi9q1YMQqgk9QRT7povsaneIRVvi8U7Gr2cQzJh63fM
         YmgA==
X-Received: by 10.152.147.130 with SMTP id tk2mr26965526lab.24.1362619417540;
        Wed, 06 Mar 2013 17:23:37 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id hk10sm16816487lab.4.2013.03.06.17.23.35
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 17:23:36 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UDPYj-0004SP-C1; Thu, 07 Mar 2013 02:23:49 +0100
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217569>

git.kernel.org no longer uses gitweb but has switched to cgit.

Info about this can be found on: https://www.kernel.org/pelican.html or
simply by looking at http://git.kernel.org . This is change since
2013-03-01.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 gitweb/README |    3 ---
 1 fil =C3=A4ndrad, 3 borttagningar(-)

diff --git a/gitweb/README b/gitweb/README
index 6da4778..471dcfb 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -1,9 +1,6 @@
 GIT web Interface
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-The one working on:
-  http://git.kernel.org/
-
 From the git version 1.4.0 gitweb is bundled with git.
=20
=20
--=20
1.7.10.4
