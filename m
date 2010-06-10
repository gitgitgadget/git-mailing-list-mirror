From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [(Amend) PATCH] Add LICENSE
Date: Thu, 10 Jun 2010 15:29:53 +0200
Message-ID: <1276176593-24879-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 15:29:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhoa-00045i-6h
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 15:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab0FJN2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 09:28:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:17319 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758281Ab0FJN2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 09:28:41 -0400
Received: by ey-out-2122.google.com with SMTP id 25so23211eya.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=T1rEt6jtqu6Z7P/4G3DIScOnCosUKiOm1Cvcg8ji4sM=;
        b=i+Z/VKpP7YHXnbBRHRgElI6QJ8bn1YXkBBHiVx1OlgBwa+dhZIyga2assHUGJuNxdH
         hb6jJwuECJSpi780uv7MjyCh/J1NOfTZRNz2nhkQd29zoz8JqH1dOGNBdkEKG/7nkqQB
         Ixi6bnNpoTlpflx71zZJhqwEnOWdCdejI6tHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=v3f1GJfP+uIogn3d1WQtzRAK7/H+XpRcQfs3MSqee6P7bP+ngyVWJCQ+XDarO3m1r4
         8XxV6V27y8FJvSQTj8dg/j7FbJbY2kvbfXwOokiqaSNj8/kXvw/1jDelNvpm1RU3FVL6
         xYbFXqXjuRz+yGmgk+cleHirfRVT3sCj9FA4c=
Received: by 10.213.9.70 with SMTP id k6mr158663ebk.31.1276176520228;
        Thu, 10 Jun 2010 06:28:40 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm4799063ewy.4.2010.06.10.06.28.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jun 2010 06:28:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148874>

From: David Barr <david.barr@cordelta.com>

License the svn-fe project under a two-clause BSD license.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
I forgot to include the LICENSE file in the 6-part series I sent
moments ago, so here it is.

 vcs-svn/LICENSE |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100644 vcs-svn/LICENSE

diff --git a/vcs-svn/LICENSE b/vcs-svn/LICENSE
new file mode 100644
index 0000000..0a5e3c4
--- /dev/null
+++ b/vcs-svn/LICENSE
@@ -0,0 +1,33 @@
+Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
+All rights reserved.
+
+Copyright (C) 2008 Jason Evans <jasone@canonware.com>.
+All rights reserved.
+
+Copyright (C) 2005 Stefan Hegny, hydrografix Consulting GmbH,
+Frankfurt/Main, Germany
+and others, see http://svn2cc.sarovar.org
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice(s), this list of conditions and the following disclaimer
+   unmodified other than the allowable addition of one or more
+   copyright notices.
+2. Redistributions in binary form must reproduce the above copyright
+   notice(s), this list of conditions and the following disclaimer in
+   the documentation and/or other materials provided with the
+   distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
+EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
+LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
+WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
+OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
+EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
1.7.1
