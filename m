From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-svn documentation: minor grammar fix
Date: Fri,  7 May 2010 19:50:03 +0000
Message-ID: <1273261803-32626-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:50:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATZ2-0007Vy-Cu
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab0EGTuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 15:50:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52541 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab0EGTuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:50:15 -0400
Received: by fxm10 with SMTP id 10so1049445fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Cw0b5zrerxa6weSkBU1Tew8OLXdfJMNLRB4ez4/ZvMQ=;
        b=LwC+jh0RF52Byh968RLzzNqH1hzER72pYg7Uay45O5AQOb8i781k33a4Z1Cafwj8oD
         Or25LIfZ7j9jV/oR64cuinU+sx06lSRknys7DoPUsevsP85f31paZofC8LO4JrEyzXrS
         6rAoYKwddYtWHrMQ5yY0AU01CfA9nJo9/O5zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=iOo9GlQnB7moUdYFNiyDNPptTVIoKO77gTwhMY3TYRePX5bWBqU9HWCFCz7+NuGhFI
         VSKpk5bKBC/FZKXf+N4WeizY4meCSTi1fcsY65OomvhoFksREM8NKtX6EzKaGBj8IZwb
         ExezTjnUABRtHAOz+RdvidihORuA5mOmulSuM=
Received: by 10.223.30.10 with SMTP id s10mr658031fac.4.1273261813572;
        Fri, 07 May 2010 12:50:13 -0700 (PDT)
Received: from aoeu (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 2sm8037367fav.1.2010.05.07.12.50.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:50:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146573>

Use the definite article when talking about a configuration property.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 99f3c1e..b09bd97 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -243,7 +243,7 @@ where <name> is the name of the SVN repository as s=
pecified by the -R option to
=20
 --username;;
 	Specify the SVN username to perform the commit as.  This option overr=
ides
-	configuration property 'username'.
+	the 'username' configuration property.
=20
 --commit-url;;
 	Use the specified URL to connect to the destination Subversion
--=20
1.7.1.dirty
