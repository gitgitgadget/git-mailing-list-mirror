From: Petr Baudis <pasky@suse.cz>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Mon, 18 Apr 2011 15:50:37 +0200
Message-ID: <20110418135037.GE3258@machine.or.cz>
References: <201102142039.59416.jnareb@gmail.com>
 <201104141154.55078.jnareb@gmail.com>
 <20110417201421.GV3258@machine.or.cz>
 <201104181534.31408.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 15:50:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBoqk-0001Xj-J7
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 15:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab1DRNum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 09:50:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41926 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab1DRNul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 09:50:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B657E1700313; Mon, 18 Apr 2011 15:50:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201104181534.31408.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171744>

  Hi!

On Mon, Apr 18, 2011 at 03:34:30PM +0200, Jakub Narebski wrote:
> On Sun, 17 Apr 2011, Petr Baudis wrote:
> >   Girocco uses MooTools, and I also used it in an old private branch
> > of gitweb. I have had pretty good experience with it. But since I wasn't
> > able to find anyone to maintain Girocco's gitweb (or even keep it in
> > sync with upstream) and the patch flow to core git has dried up, it's
> > probably not too relevant argument. :-)
> 
> Thanks.  The information about MooTools is certain helpful.
> 
> Do you remember why did you choose MooTools from other existing JavaScript
> frameworks, including more popular jQuery?

  Unfortunately, it was few years back so I don't remember clearly
anymore - it certainly was not a very educated guess, however, since I'm
not really a JavaScript hacker. Possibly I just stumbled on a nicer
guide for MooTools than jQuery at that time. By now, it's quite possible
that jQuery is a friendlier alternative.

-- 
				Petr "Pasky" Baudis
UNIX is user friendly, it's just picky about who its friends are.
