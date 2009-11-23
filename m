From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 0/2] Miscellaneous documentation updates
Date: Sun, 22 Nov 2009 19:07:28 -0700
Message-ID: <1258942050-11423-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 23 03:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCOQx-0003AJ-AU
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 03:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbZKWCNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 21:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbZKWCNb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 21:13:31 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:53568 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754373AbZKWCNb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 21:13:31 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Nov 2009 21:13:31 EST
Received: from OMTA20.emeryville.ca.mail.comcast.net ([76.96.30.87])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id 8S5N1d0021smiN4A9S7mk3; Mon, 23 Nov 2009 02:07:46 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA20.emeryville.ca.mail.comcast.net with comcast
	id 8S7k1d0095FCJCg8gS7lrC; Mon, 23 Nov 2009 02:07:45 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id B0FCE89114;
	Sun, 22 Nov 2009 19:07:42 -0700 (MST)
X-Mailer: git-send-email 1.6.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133474>

This is a series of documentation updates.  They are independent of
each other.

These are separate from and do not duplicate the core.autocrlf patch
from a week ago.

Matthew Ogilvie (2):
  cvsserver doc: database generally can not be reproduced consistently
  config documentation: some configs are auto-set by git-init

 Documentation/config.txt        |   24 ++++++++++++++++++++++--
 Documentation/git-cvsserver.txt |   19 +++++++++++++++----
 2 files changed, 37 insertions(+), 6 deletions(-)
