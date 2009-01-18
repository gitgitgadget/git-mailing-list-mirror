From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 0/4] Clarifying the refspec documentation
Date: Sun, 18 Jan 2009 15:36:54 +0100
Message-ID: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 15:38:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYnA-0002T8-02
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759003AbZAROhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756850AbZAROhA
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:37:00 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:46791 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbZAROhA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:37:00 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4BEDD30B22;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 2040730013;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106192>

This is a partial resend of some small updates to the git-push
refspec documentation. I have removed the parts of the patch
series that had comments last time, and will rework those later.

Meanwhile, I think that these simple modification do help in
making things more readable. Once you understand the refspec, it
is hard to realize how hard those few paragraphs are to digest.


Anders Melchiorsen (4):
  Documentation: git push repository can also be a remote
  Documentation: remove a redundant elaboration
  Documentation: mention branches rather than heads
  Documentation: avoid using undefined parameters

 Documentation/git-push.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)
