From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/9] Add LICENSE
Date: Wed, 14 Jul 2010 01:36:08 +0200
Message-ID: <1279064176-6645-2-git-send-email-artagnon@gmail.com>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1W-00086f-Fo
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784Ab0GMXgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40859 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab0GMXgU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:20 -0400
Received: by ewy23 with SMTP id 23so1272372ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o0PL6YJK9drIhW9pUhUn3XSr8QncYyOxpwzN3TtR4cc=;
        b=vLLXeWi/S9wWi3+TW7vz3FI9BJRSVyYY/pVzFuAN4OFJTP9celyICnaLSLCV4LPhPF
         MOPcC7qlW5U/wR6ZenAMcPofn/YweU8VCleBBlZ0/18GzoN5MdhDIlYzdE/R/XJL0PfH
         RywnPOfhDpUtxM7162nQqO3APkgf3IhH8c2+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Fkto9zdsUxDWOpqcdN+vq/2tTUUNf/a5S8GxQhivCL7RrKjxQu/zRJQiTJ9VjuPykb
         5eYBbZCCUEJayxMrgXXnjrDkyMPjp9dtEM2WLUvhsPJnoqnDEH9mQdx5avbBWFFRbI3d
         F5azPhVbRBw1ettJaW1FZZhGV3o87OvCX3QIo=
Received: by 10.213.10.8 with SMTP id n8mr516677ebn.46.1279064179219;
        Tue, 13 Jul 2010 16:36:19 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id z55sm51475029eeh.9.2010.07.13.16.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150941>

License the project under a two-clause BSD-style license. A dual
license will be required later when attempting to merge into
Subversion.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 LICENSE |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 LICENSE

diff --git a/LICENSE b/LICENSE
new file mode 100644
index 0000000..4367b7c
--- /dev/null
+++ b/LICENSE
@@ -0,0 +1,26 @@
+Copyright (C) 2010 Ramkumar Ramachandra
+All rights reserved.
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
