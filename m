From: Petr Baudis <pasky@suse.cz>
Subject: Re: git.or.cz IPv6
Date: Mon, 14 May 2007 02:54:10 +0200
Message-ID: <20070514005410.GG4489@pasky.or.cz>
References: <20070513094054.GB18546@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon May 14 02:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOpO-00049y-Um
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066AbXENAyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758351AbXENAyN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:54:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45720 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066AbXENAyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:54:13 -0400
Received: (qmail 21093 invoked by uid 2001); 14 May 2007 02:54:10 +0200
Content-Disposition: inline
In-Reply-To: <20070513094054.GB18546@cip.informatik.uni-erlangen.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47210>

  Hi,

On Sun, May 13, 2007 at 11:40:54AM CEST, Thomas Glanzmann wrote:
> git.or.cz has an AAAA record but is not reachable via IPv6 which drives
> me crazy because my IPv6 is working and my browser tries to connect
> git.or.cz via IPv6 and falls back after a considerable amount of time.
> So could someone please get IPv6 working at git.or.cz or delete the AAAA
> record.

  git.or.cz's IPv6 connectivity should be fine, maybe there is a routing
problem somewhere along the way :-( - what IPv6 ISP are you using?

  I'd prefer to have AAAA records for IPv6-capable sites but if it
causes problems for more people, I will remove it - new technology stuff
is nice but the priority #1 is for the site to be reachable.

> Oh and the download link to
> "http://git.kernel.org/pub/software/scm/git/" is broken.

  Thanks, fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
