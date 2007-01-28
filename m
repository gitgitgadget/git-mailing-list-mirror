From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 18:34:45 -0500
Message-ID: <20070128233445.GD12125@fieldses.org>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx> <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org> <20070128013452.GA11244@moooo.ath.cx> <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 00:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBJXy-0008Fg-LV
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 00:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973AbXA1Xeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 18:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932978AbXA1Xeu
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 18:34:50 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60037 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932973AbXA1Xeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 18:34:50 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HBJXp-0007OX-6F; Sun, 28 Jan 2007 18:34:45 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38056>

On Sat, Jan 27, 2007 at 05:47:49PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 28 Jan 2007, Matthias Lederhofer wrote:
> > 
> > Good point, otoh the git-repo-config manual page is actually the one
> > documenting .git/config :).
> 
> Btw, one thing I don't like about "git-repo-config" is the name.
> 
> Many people thought "git init-db" was confusing, and now we call it just 
> "git init".
> 
> Can I vote for doing that for "git repo-config" too? Is there something 
> wrong with just calling it "git config"?

While we're at it, is there any need for the "objects" in
git-fsck-objects?

--b.
