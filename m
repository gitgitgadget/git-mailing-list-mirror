From: Petr Baudis <pasky@suse.cz>
Subject: Re: garbage in the cogito.git repository
Date: Fri, 5 Aug 2005 02:10:41 +0200
Message-ID: <20050805001041.GM24479@pasky.ji.cz>
References: <20050731124228.GB11570@procyon.home> <20050805000613.GD3900@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 02:11:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0po7-0007T4-8b
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVHEAKx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVHEAKw
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:10:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47118 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262790AbVHEAKo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 20:10:44 -0400
Received: (qmail 18853 invoked by uid 2001); 5 Aug 2005 00:10:41 -0000
To: Sergey Vlasov <vsu@altlinux.ru>
Content-Disposition: inline
In-Reply-To: <20050805000613.GD3900@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 05, 2005 at 02:06:13AM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> yes, sorry about this. Packs got there through rsyncs all the way from
> git-core, and my immediate naive git-unpack-objects didn't actually do
> anything since all the objects were, well, in
> .git/objects/pack/thatpackfile. Obviously, this behaviour is reasonable
> when you think about it, but rather pitfallous, I would say. At least
> documenting it might be worthwhile.

To clarify, I want to use packs, yes. But plenty of Cogito users are
using HTTP and I want to give them some time to upgrade to the latest
Git which supports pulling packs over HTTP. I'd say at least two to
three weeks or me getting near the top of kernel.org object users,
whichever comes first. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
