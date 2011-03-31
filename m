From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] revisions.txt improvements
Date: Thu, 31 Mar 2011 13:03:06 +0200
Message-ID: <cover.1301569271.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 13:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5FiA-0000xv-Py
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 13:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab1CaLGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 07:06:41 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57306 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751729Ab1CaLGk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 07:06:40 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8136C20403
	for <git@vger.kernel.org>; Thu, 31 Mar 2011 07:06:40 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 31 Mar 2011 07:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=YfjqFRCfLIyJGFo64RBWF9fb0g0=; b=dCD3mLNF2Zk+qBA/gimhYVZZ293o82B256V5uOtkapN5SNgFJuuL7VlxXnbFeTqh+wB4shM7PQFW+I/WeXbAXu6uAQ4j34DtP09onnMsVK1pad2aamC1kghDlVbk7TJvcZGUt/K+ziYFK44RDmo7A2KBTnyURzpQM6vZihxLT88=
X-Sasl-enc: 7yQnM3RjOqOm0HGBZv7MupmQ8OA8Asb49rLct3nyuL8T 1301569600
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 01B28444EF0;
	Thu, 31 Mar 2011 07:06:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170469>

No blurb, commit messages say it all.

Michael J Gruber (3):
  revisions.txt: consistent use of quotes
  revisions.txt: structure with a labelled list
  revisions.txt: language improvements

 Documentation/revisions.txt |  198 +++++++++++++++++++++++--------------------
 1 files changed, 107 insertions(+), 91 deletions(-)

-- 
1.7.4.2.668.gba03a4
