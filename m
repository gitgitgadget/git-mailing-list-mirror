From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/6] =?UTF-8?q?.mailmap:=20Multiple=20email=20addresses=20?= =?UTF-8?q?of=20Alejandro=20R.=20Sede=C3=B1o?=
Date: Thu,  4 Jul 2013 16:04:14 +0200
Message-ID: <1372946659-10332-2-git-send-email-stefanbeller@googlemail.com>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 16:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuk9E-00027H-LG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab3GDOEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 10:04:30 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:56103 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3GDOE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 10:04:28 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji1so676630bkc.10
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dBApgXahcYvfQMNVHZffKFbpxPw3Nf/0OESi4qPaeLw=;
        b=klIpkqTadRr7io8EC0tmzjOJCKoumlMacavgtc6yvIB6O4PQy3MwECGKG2Hl2YByD+
         0/1s9+BAHL26PzUrehfA1FkGSW+7+CEM82FMQW0y0aIoKLp4+ezVPj/JHfgO7xM93kNH
         7RnM08LXvA9Y/Is2KuemeP1V+Y/u23HdVVRdynmeImCgmH/07DDH4VeDQWsPlei5co3E
         /POn3u4arpnQ2HG/DsBAu2ikqwRD4/J07WSIXFm6KBM4KNhGiCO1pRFjhHLKaJfbUV5R
         Uk0u26il6fXDqODXT94lOXMQEnF75irBgyiAZysDp3/GGBkH0arJ8R7c2RJMn0yHm8BA
         vA2Q==
X-Received: by 10.204.227.81 with SMTP id iz17mr1068979bkb.157.1372946666917;
        Thu, 04 Jul 2013 07:04:26 -0700 (PDT)
Received: from localhost (eduroam-74-151.uni-paderborn.de. [131.234.74.151])
        by mx.google.com with ESMTPSA id hn4sm1070550bkc.2.2013.07.04.07.04.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 07:04:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.636.g7943f03
In-Reply-To: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229583>

This is obvious as its only difference is capital letters in one of the
mail addresses.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 345cce6..3a4dd49 100644
--- a/.mailmap
+++ b/.mailmap
@@ -5,6 +5,7 @@
 # same person appearing not to be so.
 #
=20
+Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
 Alex Benn=C3=A9e <kernel-hacker@bennee.com>
 Alexander Gavrilov <angavrilov@gmail.com>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
--=20
1.8.3.2.636.g7943f03
