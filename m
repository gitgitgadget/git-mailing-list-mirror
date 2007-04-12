From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Document the GIT branches -> CVS modules mapping more prominently
Date: Fri, 13 Apr 2007 00:19:40 +0200
Message-ID: <20070412221940.GH7085@planck.djpig.de>
References: <7v64879rwd.fsf@assigned-by-dhcp.cox.net> <11763896683800-git-send-email-frank@lichtenheld.de> <7v3b35jlj4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:20:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc7e9-00059l-GL
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 00:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030796AbXDLWTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 18:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030797AbXDLWTp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 18:19:45 -0400
Received: from planck.djpig.de ([85.10.192.180]:2952 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030796AbXDLWTo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 18:19:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 4CFA4274014;
	Fri, 13 Apr 2007 00:19:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLF9kj8NkZK0; Fri, 13 Apr 2007 00:19:40 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id D7041274013; Fri, 13 Apr 2007 00:19:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3b35jlj4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44359>

On Thu, Apr 12, 2007 at 03:05:51PM -0700, Junio C Hamano wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
> 
> > Add a note about the branches -> modules mapping to LIMITATIONS because
> > I really think it should be noted there and not just at the end of
> > the installation step-by-step HOWTO.
> >
> > I used "git branches" there and changed "heads" to "branches" in
> > my section about database configuration. I'm reluctant to replace
> > all occourences of "head" with "branch" though because you always
> > have to say "git branch" because CVS also has the concept of
> > branches. You can say "head" though, because there is no such
> > concept in CVS. In all the existing occourences of head other than
> > the one I changed I think "head" flows better in the text.
> 
> Ah, I tend to agree.  Mind if I applied only the first hunk then?

Not at all. Go ahead.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
