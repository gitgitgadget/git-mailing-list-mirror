From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] .gitignore: ignore generated gitk-git/gitk-wish
Date: Fri, 25 Jan 2013 13:09:47 +0700
Message-ID: <1359094187-313-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 07:10:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TycV6-0000Au-Dd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 07:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab3AYGKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 01:10:31 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:42806 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab3AYGK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 01:10:29 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so62013pad.13
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=3TlBAMlzoQ1Ci1wYnqOJCwDlbcOmqioyZgJqPh/Z3ik=;
        b=cH7I8PbJiYXgsomnOf5vvSUct33etKFnqtzz0S2ebwJHh+C/RlAfDZ2Pd2lmDpYhLT
         FVCUK2s6hDC1pu5JUYyr9oZyNc6PVCZsBV1RMkh0u95CfguJKdmU02NVtofsJ3UE2Xvp
         hCGh0Qfv8v9QUh/4dqR8S1DsNugpLlGDmMGK3VvbsbNP54qwDLrYnX0Xc5piVuBhgWSj
         e7YfT3nhURp73cgrmKcq9yr1HFA9yTuCyHQ4f0Z22FRXBVo2lZ3TsCS5WQHM+6BwQn9g
         xuwRYsNFGMFreCcaV5a1RMGip8wzUuAGVaZVdpjdHMWuMw44JtdSh/0iEU5Q/WcNCG7X
         wzxg==
X-Received: by 10.66.84.3 with SMTP id u3mr10935840pay.51.1359094228812;
        Thu, 24 Jan 2013 22:10:28 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id qt2sm52328pbb.24.2013.01.24.22.10.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jan 2013 22:10:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 25 Jan 2013 13:10:04 +0700
X-Mailer: git-send-email 1.8.0.rc3.18.g0d9b108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214503>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index aa258a6..63d4904 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,6 +171,7 @@
 /git-whatchanged
 /git-write-tree
 /git-core-*/?*
+/gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
--=20
1.8.0.rc3.18.g0d9b108
