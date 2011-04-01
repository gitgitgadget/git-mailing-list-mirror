From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/3] revisions.txt improvements
Date: Fri,  1 Apr 2011 11:27:39 +0200
Message-ID: <cover.1301649867.git.git@drmicha.warpmail.net>
References: <cover.1301569271.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5ahL-0004VA-8l
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab1DAJbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:31:13 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36331 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752278Ab1DAJbM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:31:12 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4B51B2010F;
	Fri,  1 Apr 2011 05:31:12 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 01 Apr 2011 05:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=WJLaaDsJGfvPycZR82AaqTggxSY=; b=VzvsYhfW6dRI6uiIfsvKoPnMj7WOm1Q9j3vqoKQ+pjTQ/UF0P4xsPw1Dz6dVMeP7JOQYYjdWhRStYazZkn2a83u+sH3Q3yCeZmLGHs6Hk4gI55I8KDHUa3FeznT6wbIKCcB35gmHNpmka3r/4E8P4cFuB5syCAD5gWoAnjqf0fc=
X-Sasl-enc: uJ/sPd0S0oKB73cpjdrn+mwDswFuyqD+BFoNtPn+xcZ8 1301650271
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C09CA444E93;
	Fri,  1 Apr 2011 05:31:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <cover.1301569271.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170571>

v2 with the fixes suggested by Bert and Jakub.
(1/3 unchanged but resent)


Michael J Gruber (3):
  revisions.txt: consistent use of quotes
  revisions.txt: structure with a labelled list
  revisions.txt: language improvements

 Documentation/revisions.txt |  198 +++++++++++++++++++++++--------------------
 1 files changed, 107 insertions(+), 91 deletions(-)

-- 
1.7.4.2.668.gba03a4
