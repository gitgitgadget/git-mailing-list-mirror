From: Yann Dirson <ydirson@altern.org>
Subject: Re: irc usage..
Date: Sat, 20 May 2006 22:39:11 +0200
Message-ID: <20060520203911.GI6535@nowhere.earth>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 20 22:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhY2k-00023X-T0
	for gcvg-git@gmane.org; Sat, 20 May 2006 22:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWETU1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWETU1U
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 16:27:20 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:32682 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751478AbWETU1T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 16:27:19 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id D6F6A4F1B4;
	Sat, 20 May 2006 22:27:18 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FhYEC-0005Ix-3i; Sat, 20 May 2006 22:39:12 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20394>

On Sat, May 20, 2006 at 10:26:22AM -0700, Linus Torvalds wrote:
> I'm reading the irc logs, and seeing that people have problems, but (a) it 
> was while I was asleep and (b) irc use doesn't encourage people to 
> actually explain what the problems _are_, so I have no clue.
> 
> So now I know that "spyderous" has problems importing some 1GB gentoo CVS 
> archive, but that's pretty much it. Grr.

FWIW, I have mentionned a problem that may be the same, under
Message-ID <20060107090148.GB32585@nowhere.earth>, that was on January
7th.  Namely, when importing a repository with very large files over
pserver or ssh, timeouts can occur and prevent the import from
working.  But, as you said, it's not easy to get precise info from the
logs :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
