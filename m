From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/13] Add LICENSE
Date: Wed,  7 Jul 2010 02:14:41 +0200
Message-ID: <1278461693-3828-2-git-send-email-artagnon@gmail.com>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	dev@subversion.apache.org
To: Git Mailing List <git@vger.kernel.org>
X-From: dev-return-4817-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 02:13:53 2010
Return-path: <dev-return-4817-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4817-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWIGu-0004md-IG
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 02:13:53 +0200
Received: (qmail 96464 invoked by uid 500); 7 Jul 2010 00:13:50 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 96456 invoked by uid 99); 7 Jul 2010 00:13:50 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:13:50 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.43 as permitted sender)
Received: from [209.85.215.43] (HELO mail-ew0-f43.google.com) (209.85.215.43)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 00:13:41 +0000
Received: by ewy1 with SMTP id 1so2219808ewy.16
        for <dev@subversion.apache.org>; Tue, 06 Jul 2010 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=o0PL6YJK9drIhW9pUhUn3XSr8QncYyOxpwzN3TtR4cc=;
        b=B7/IYVLn4kHYx+b74/ltYD0rnRFFLJMZIM54Ol5JmGfMYWOyC84ikgkwwA8jX1oWAs
         /LdH6fUC3G60uLAnpmV1KZTmgzu9Vvpaf4YRzNOq1Ct3gx4eb+9bsoUjk1SBwdA/xLV9
         nduEoKCvNXDxKLwOnp1ylapmk0msi49CLl7r8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G7aM976RMDbXlnKRrUAsuXkdETKvFRLd6mgOVtUNIunTqpxJI3DuXtOGjDa26XxRmz
         RUTVKgKGnOfLciTpVC9ten9KY1ef+GZzKtwQZzjx2vIoo3XEBlHNv9MnF7gQblbjtD2c
         xcS2fQcOWt+cUIArc2Q8A4LlpLEZWXyLyUYvA=
Received: by 10.213.7.65 with SMTP id c1mr3121471ebc.73.1278461601004;
        Tue, 06 Jul 2010 17:13:21 -0700 (PDT)
Received: from localhost (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm55854848eei.19.2010.07.06.17.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 17:13:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150428>

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
