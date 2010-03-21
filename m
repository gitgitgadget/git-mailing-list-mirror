From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/4] Various unrelated documentation fixes
Date: Sun, 21 Mar 2010 18:30:15 +0100
Message-ID: <cover.1269192495.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 18:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOyk-00035z-Rw
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab0CURaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:30:10 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44838 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753048Ab0CURaE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 13:30:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 903C7E9B35;
	Sun, 21 Mar 2010 13:30:01 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 21 Mar 2010 13:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=LPlHWd93a5l7Zgj10R8m2Mk/Q0o=; b=YceTJ+QEk0g3c7xvOxVHlH20L8f75I+cllr5pOCBU3SetsrtgGRJM6dWTO8uVocPNwggiWVHrI7NaJCW1+7E6BE8+N249jndAh8SDxqFbcOeI9vAKlr76LCDnsgys80DLHmBoZ8GF29hlqBwJYqqQTfWjYfWndAsS/uVVoHu5pA=
X-Sasl-enc: VXkiVRAnPUGIofd5fYWRII7fOPYd95IfK/nQ1vNtHPOv 1269192600
Received: from localhost (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AC3833FBDB;
	Sun, 21 Mar 2010 13:30:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.2.358.g30511
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142840>

Here come 4 fixes to the documentation for issues which I spotted
when skimming the doc for something else. They are not interrelated
(and therefore described there, not here ;) ).

Michael J Gruber (4):
  Documentation/git-reflog: Fix formatting of command lists
  Documentation/gitdiffcore: Remove misleading date in heading
  Documentation/urls: Remove spurious example markers
  Documentation/git-clone: Transform description list into item list

 Documentation/git-clone.txt   |   10 +++++-----
 Documentation/git-reflog.txt  |    2 --
 Documentation/gitdiffcore.txt |    2 +-
 Documentation/urls.txt        |    6 ------
 4 files changed, 6 insertions(+), 14 deletions(-)
