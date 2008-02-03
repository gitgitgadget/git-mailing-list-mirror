From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 07:56:51 -0500
Message-ID: <20080203125651.GA18392@mit.edu>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp> <878x22j1km.dancerj%dancer@netfort.gr.jp> <20080203103804.GC323@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 14:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLf6Y-0003Pd-8w
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 14:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbYBCNlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 08:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbYBCNlW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 08:41:22 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:48166 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754447AbYBCNlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 08:41:21 -0500
X-Greylist: delayed 2641 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Feb 2008 08:41:21 EST
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JLePt-0003wY-MQ; Sun, 03 Feb 2008 07:57:49 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JLeP2-0005ND-R1; Sun, 03 Feb 2008 07:56:56 -0500
Content-Disposition: inline
In-Reply-To: <20080203103804.GC323@artemis.madism.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72355>

On Sun, Feb 03, 2008 at 11:38:04AM +0100, Pierre Habouzit wrote:
>   http://www.google.com/trends?q=svn%2C+git%2C+mercurial%2C+bzr%2C+darcs&ctab=0&geo=all&date=all&sort=0
> 
>   :)

Unfortunately the only problem with this trend chart is that if you
take the baseline of git and mercurial starting in the time period
between April 2004 and 2005 (i.e., before development of those two
systems started), git's and mercurial's usage hasn't actually grown by
that much.  The problem being of course that git and mercurial are
words that can be used in other contexts, which is somewhat less
likely with svn and bzr, which makes it harder to draw good
conclusions.

					- Ted
