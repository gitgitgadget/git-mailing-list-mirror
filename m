From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: 2.6.15-rc2 tag
Date: Mon, 21 Nov 2005 16:25:49 -0500
Message-ID: <20051121212549.GA23213@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 21 22:27:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJAp-0004Qr-R7
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKUVZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKUVZv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:25:51 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59268 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750770AbVKUVZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:25:50 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.54)
	id 1EeJAb-000659-Tc
	for git@vger.kernel.org; Mon, 21 Nov 2005 16:25:49 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12483>

Help!  I'm confused.

	git-fetch --tags http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

isn't getting me a 2.6.15-rc2 tag.  So maybe there's some delay?  There
does, however, appear to be a file

	http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/tags/v2.6.15-rc2

Its contents are 7305b5cb045e2c71250b5b7472771ed2620bc514 which isn't
anything I can find anywhere.

gitweb, on the other hand:

	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tag;h=7305b5cb045e2c71250b5b7472771ed2620bc514

shows 3bedff1d73b86e0cf52634efb447e9ada08f2cc6 as the tagged commit,
which is something I do have.  What don't I understand?

--b.
