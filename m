From: Jan Engelhardt <jengelh@medozas.de>
Subject: gitignore warn about ** submission
Date: Mon,  9 Jan 2012 16:40:46 +0100
Message-ID: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
Cc: trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 16:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkHLJ-0008VK-MN
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 16:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729Ab2AIPkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 10:40:53 -0500
Received: from seven.medozas.de ([188.40.89.202]:42885 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755706Ab2AIPkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 10:40:53 -0500
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 8981621A0A6F; Mon,  9 Jan 2012 16:40:50 +0100 (CET)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188175>


The following changes since commit eac2d83247ea0a265d923518c26873bb12c33778:

  Git 1.7.9-rc0 (2012-01-06 12:51:09 -0800)

are available in the git repository at:
  git://dev.medozas.de/git master

Jan Engelhardt (1):
      gitignore: warn about pointless syntax

 dir.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)
