From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn, svn:externals, git-submodules?
Date: Fri, 5 Oct 2007 16:14:59 -0700
Message-ID: <20071005231459.GA16849@untitled>
References: <DEC49034-D594-4F4E-89E6-B98A3D4A8825@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Oct 06 01:15:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdwO5-0002PS-9z
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 01:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbXJEXPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 19:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbXJEXPB
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 19:15:01 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38047 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbXJEXPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 19:15:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C52CB2DC032;
	Fri,  5 Oct 2007 16:14:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <DEC49034-D594-4F4E-89E6-B98A3D4A8825@lrde.epita.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60136>

Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> Hello,
> is there any plan to support svn:externals in git-svn with git- 
> submodules?  If yes, where can we see the on-going work?  If no, is  
> anyone already planning to implement this?  If no, has anyone  
> anything to say about the idea?  I could give it a try as I really  
> need this feature to properly interoperate with SVN repositories.   
> Many of my friends and co-workers also need it.

I hope to support it at some point, but some point could be anywhere
from days to months away depending on other things I'm working on...

I've barely looked at git-submodules myself.  To my knowledge there's no
on-going work for it.

-- 
Eric Wong
