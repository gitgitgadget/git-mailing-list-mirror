From: Petr Baudis <pasky@suse.cz>
Subject: Re: found some nice git scripts
Date: Sun, 13 Jul 2008 22:12:45 +0200
Message-ID: <20080713201245.GI32184@machine.or.cz>
References: <1214599789.6576.1.camel@doriath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, gitorious@masanjin.net
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:13:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI7x6-0000WD-10
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbYGMUMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbYGMUMs
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:12:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55813 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744AbYGMUMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:12:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 71E9A393A530; Sun, 13 Jul 2008 22:12:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1214599789.6576.1.camel@doriath>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88327>

On Fri, Jun 27, 2008 at 10:49:49PM +0200, Raimund Bauer wrote:
> Maybe somebody else find them useful too:
> http://git-wt-commit.rubyforge.org/

  Interesting. I wonder if the William Morgan knows about git
show-branch? It provides very similar functionality, but soemwhat
different kind of output; extending it with git-wtf-like functionality
(that is, per-branch "merge status summary", and "flat" view of commits)
might be quite easy and practical for others at the same time.

  About, git-publish-branch, again, maybe it would make a great deal of
sense to teach git-push a --track flag?

  I understand if the author has not much desire to reimplement this in
C, on the other hand everyone would benefit from builtin support; maybe
someone else gets inspired.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
