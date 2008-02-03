From: Theodore Tso <tytso@mit.edu>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 14:27:58 -0500
Message-ID: <20080203192758.GD18392@mit.edu>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp> <878x22j1km.dancerj%dancer@netfort.gr.jp> <20080203103804.GC323@artemis.madism.org> <vpqodayrsag.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLkWU-0002WK-1F
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 20:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYBCT23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 14:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYBCT23
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 14:28:29 -0500
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:55021 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751327AbYBCT22 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 14:28:28 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JLkWM-00056h-14; Sun, 03 Feb 2008 14:28:54 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JLkVX-0005pf-J9; Sun, 03 Feb 2008 14:28:03 -0500
Content-Disposition: inline
In-Reply-To: <vpqodayrsag.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72395>

On Sun, Feb 03, 2008 at 04:08:55PM +0100, Matthieu Moy wrote:
> Debian's popularity contest gives an idea too:
> 
> #rank name                            inst  vote   old recent no-files (maintainer)
> 2423  git-core                        3720  1858   992   870     0 (Gerrit Pape)                   
> 3480  mercurial                       1778   410   914   454     0 (Vincent Danjean)               
> 4232  bzr                             1198   278   372   548     0 (Debian Bazaar Maintainers)     

That's very interesting.  When I did a count a month or so ago of the
number of projects using git, mercurial and bzr as self reported on
each of the project's wiki's, what I found then was:

git 115  (source: http://git.or.cz/gitwiki/GitProjects)
hg   89  (source: http://www.selenic.com/mercurial/wiki/index.cgi/ProjectsUsingMercurial)
bzr  48  (source: http://bazaar-vcs.org/WhoUsesBzr)

Of course, there's no guarantee that each of the Wiki maintainers were
as diligent about putting references to all of the projects, but to
the extent that there are people in each user community who are
interested in advocacy of their favoriate SCM, I would have expected
at least some baseline amount of effort in keeping their wiki's
uptodate.  So it's not interesting as another data point...

	      	       		      	      - Ted
