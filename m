From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 17/31] Fix typo in uitext.properties message
Date: Sun, 17 Aug 2008 22:43:58 +0200
Message-ID: <1219005852-21496-18-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-15-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-16-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp9A-00038o-KI
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYHQUpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbYHQUpT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbYHQUpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489195fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dXJGuQMtAvC/ogIx+VIyNaWSa7TrlW8O+YDtSq9KvWw=;
        b=On98mNE6f4dZpNe6h1t8u3TTSPyJPtPTB4hUeEcWEInK/L7hUCSWtaDBKpTGahuZ6a
         GrigdjplhXmmnqFXzQPqNpSpci+1f7bE0/LgRl+HUFww+MziYFDRu7Q3WMdsYUDmabR1
         WzVOIdQ2xNYrCsag6DKXGQOxsSJt9UXpTtJP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=em7iPhPWoSS1mHboO01Nq2rDCWWFLmHJlK1ojprnFn2/bty0FA58oJk4kKr9+HRBsD
         kmco1HES00RmCiJluAflewqSBTX4vI6DqwICvkSpfPHPP2/Xb9oLuipWc3AdiXZ9cskw
         /H0Cc1U39B0cnWQuoq/KZxrkVzUPZFXDFwhAw=
Received: by 10.103.227.10 with SMTP id e10mr3469209mur.38.1219005914906;
        Sun, 17 Aug 2008 13:45:14 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j9sm8840279mue.3.2008.08.17.13.45.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-17-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92653>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/uitext.properties      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 9516aa0..55b1348 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -16,7 +16,7 @@
 ##
 
 SharingWizard_windowTitle=Configure Git Repository
-SharingWizard_failed=Failed to initalize Git team provider.
+SharingWizard_failed=Failed to initialize Git team provider.
 
 GenericOperationFailed={0} Failed
 
-- 
1.5.6.3
