From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: user-manual changes
Date: Sun, 23 Sep 2007 13:27:02 -0400
Message-ID: <20070923172702.GA5916@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Smith <msmith@cbnco.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 19:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZVEj-0000b6-Bx
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 19:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbXIWR1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 13:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbXIWR1J
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 13:27:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:60089 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbXIWR1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 13:27:08 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IZVEU-0002lR-Vg; Sun, 23 Sep 2007 13:27:02 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58970>

I've got the submodule chapter plus another pending fix at:

  git://linux-nfs.org/~bfields/git.git maint

The submodule documentation looks fine to me.  My only suggestion is
that it should start with a brief explanation of why we have submodules
and what somebody would use them for.

--b.

J. Bruce Fields (1):
      user-manual: don't assume refs are stored under .git/refs

Miklos Vajna (1):
      User Manual: add a chapter for submodules

 Documentation/user-manual.txt |  220 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 213 insertions(+), 7 deletions(-)
