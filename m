From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 10/12] Docs: Embolden the CONFIGURATION references
Date: Sat, 18 Apr 2009 12:02:06 -0500
Message-ID: <1240074128-16132-11-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-10-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE2S-0007cL-6d
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZDRRHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbZDRRHi
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:07:38 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:45168 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZDRRHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:07:37 -0400
Received: by mail-qy0-f126.google.com with SMTP id 32so634324qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=adg5SVZLUVoyBn3gPZfCzmrDXwdd4udym5JieD4q8iY=;
        b=hngBOQus5XOB3r6GBx0u81v/G5Q4M3cwJbywBzL+GJeeZs2DK3CYLQSPyrqwLkP/7G
         e6ELCDnw3pvzR9b+RyVt/zbjN6Tjvv4Prqxr2oLeZidorTK1GCBBtxfEF3HTBpaQiY2q
         hmQEQtDWKG7mI9JfkeVymGMlmDk4w8kbY3PVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GripkLp1MPDaUWztPrxH8N1DaZVmCCRZu5xiz+9B7YNA/qxnCfLj58O5G3pdGZCxSR
         Pk4Y7B1ILk0iY8Snz9LBOkuzhVq4RIXsjsYKKrBvI1PZ04p5oPNsgzIbIKIl0oIKfhf/
         NIhk5PHSUUP4yQClclkxhGd49Eh+uVmANLZZM=
Received: by 10.220.92.79 with SMTP id q15mr4256973vcm.11.1240074456788;
        Sat, 18 Apr 2009 10:07:36 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.07.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:07:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-10-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116854>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 6f770d0..93c39e1 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -41,7 +41,7 @@ Composing
 
 --annotate::
 	Review and edit each patch you're about to send. See the
-	CONFIGURATION section for 'sendemail.multiedit'.
+	*CONFIGURATION* section for 'sendemail.multiedit'.
 
 --bcc=<address>::
 	Specify a "Bcc:" value for each email. Default is the value of
@@ -67,7 +67,7 @@ and In-Reply-To headers will be used unless they are removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
 +
-See the CONFIGURATION section for 'sendemail.multiedit'.
+See the *CONFIGURATION* section for 'sendemail.multiedit'.
 
 --from=<address>::
 	Specify the sender of the emails.  This will default to
-- 
1.6.2.2.479.g2aec
