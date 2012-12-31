From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH v2 0/2] Add MAINTAINERS file and clarify gui workflows
Date: Mon, 31 Dec 2012 17:19:33 -0500
Message-ID: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: gitster@pobox.com, th.acker@arcor.de, paulus@samba.org,
	patthoyts@users.sourceforge.net, worldhello.net@gmail.com,
	Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 23:21:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpnjZ-00059f-B2
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 23:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab2LaWVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 17:21:06 -0500
Received: from mail-vb0-f43.google.com ([209.85.212.43]:39263 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2LaWVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 17:21:05 -0500
Received: by mail-vb0-f43.google.com with SMTP id fs19so13346430vbb.30
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 14:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=//l0w+HGDxjFCOQZC2Z9yCdx0Ex5NYgLmUxVKWkLtHE=;
        b=FTajHkZsDAbZTSAng7Y3RTMrYw9i8bE4U93wpS+UzoC5sdewp9evfr3p37HauYE9iQ
         6ZBcmhnbC+qAVKyjJAtw030s12Pqm++U4KeCTLYYDeDolXncj/cRh+jT5noyb+pBbX21
         0b7jNeouAjRF5G8KAu8Xo13kUqn7Cm4BgELWIv89gGYojThDv4BxTPsb7mD3Fo08vfhM
         aRYjSqkDBxIJZPFVAsVqxv9pokSJlnXmesgoUOHxRG6kaEyH5pNFPIKMSc7AXQeItbvS
         ecjaPYO9GhSxKQEErBf9gJxoJiovFk2x7cAixt6EPXgvOu14IGQjEGl4jOtpjFi2SDCK
         L+MA==
X-Received: by 10.220.205.198 with SMTP id fr6mr65962969vcb.63.1356992464189;
        Mon, 31 Dec 2012 14:21:04 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id di16sm39824172vdb.11.2012.12.31.14.21.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 14:21:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212361>

Changes since the initial version:
-Added git-po to the MAINTAINERS file and generalized wording that had been
 gui-specific
-Fixup some trailing whitespace warnings

Jason Holden (2):
  Add top-level maintainers file with email/canonical repository
    information
  Provide better guidance for submitting patches against upstream
    utilities

 Documentation/SubmittingPatches | 11 +++++++++++
 MAINTAINERS                     | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 MAINTAINERS

-- 
1.8.1.rc3.28.g0ab5d1f
