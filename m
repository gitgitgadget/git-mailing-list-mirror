From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: user-manual patches
Date: Sun, 26 Aug 2007 12:16:06 -0400
Message-ID: <43979.0301760242$1188144977@news.gmane.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKmb-0002di-Pp
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbXHZQQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbXHZQQI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:16:08 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57963 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbXHZQQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:16:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKmU-0007SL-5z; Sun, 26 Aug 2007 12:16:06 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56693>


The following changes are available from the "maint" branch at:

  ssh://linux-nfs.org/~bfields/exports/git.git maint

--b.

David Kastrup (1):
      Documentation/user-manual.txt: fix a few omissions of gitlink commands.

J. Bruce Fields (5):
      user-manual: edit "ignoring files" for conciseness
      user-manual: minor editing for conciseness
      user-manual: introduce the word "commit" earlier
      user-manual: use pithier example commit
      user-manual: fix incorrect header level

 Documentation/user-manual.txt |  144 ++++++++++++++++-------------------------
 1 files changed, 55 insertions(+), 89 deletions(-)
