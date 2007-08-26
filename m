From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: user-manual patches
Date: Sun, 26 Aug 2007 12:20:50 -0400
Message-ID: <20070826162050.GA28795@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKr9-0004Nd-1o
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXHZQUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXHZQUv
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:20:51 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55084 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366AbXHZQUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:20:51 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKr4-0007ZR-MN; Sun, 26 Aug 2007 12:20:50 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56702>

On Sun, Aug 26, 2007 at 12:16:56PM -0400, J. Bruce Fields wrote:
> 
> The following changes are available from the "maint" branch at:
> 
>   ssh://linux-nfs.org/~bfields/exports/git.git maint

Um, sorry for the duplicates.  I'm clearly not competent to operation
git-send-email.

Also one chunk from David Kastrup's gitlink fixes only applied to
master, so I applied the whole thing there, did a merge, and pushed the
result to my master branch.  If that was the right thing to do, then I
guess you can just pull from both of

	git://linux-nfs.org/~bfields/git	maint
	git://linux-nfs.org/~bfields/git	master

?

--b.
