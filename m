From: Pavel Roskin <proski@gnu.org>
Subject: Re: git on HP-UX
Date: Sat, 08 Jul 2006 03:38:43 -0400
Message-ID: <1152344323.26627.13.camel@dv>
References: <200607060950.34558.michal.rokos@nextsoft.cz>
	 <1152197629.7720.10.camel@dv>  <7vfyhe465i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 09:38:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz7Ot-0004tn-PR
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 09:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWGHHit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 03:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWGHHit
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 03:38:49 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:7593 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751262AbWGHHis
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 03:38:48 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fz7Op-0000UF-TT
	for git@vger.kernel.org; Sat, 08 Jul 2006 03:38:48 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fz7Ol-0006xC-Dl; Sat, 08 Jul 2006 03:38:43 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyhe465i.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23481>

On Thu, 2006-07-06 at 17:20 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> > I hope the Autoconf based configure is on its way to git, but I don't
> > see in in the "pu" branch yet.  I'm not very keen about reinventing
> > Autoconf and hacking a hand-made configure script.
> 
> OK, you half-convinced me.  The other half came from a recent
> series of patches to try using 'which' to detect executables,
> which is another common mistake handcrafted configure script
> makes, which autoconf people have solved for us long time ago.

I really appreciate it.  I hope all the Autoconf patches in the queue
will land in "pu" shortly, and then I'm going to have a closer look at
it.

-- 
Regards,
Pavel Roskin
