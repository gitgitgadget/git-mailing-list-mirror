From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: documentation issues
Date: Thu, 1 Dec 2005 15:34:11 -0500
Message-ID: <20051201203411.GA12861@pe.Belkin>
References: <438F5D05.4080101@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 21:38:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhvA0-0005kW-Mf
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 21:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVLAUgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 15:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVLAUgF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 15:36:05 -0500
Received: from eastrmmtao04.cox.net ([68.230.240.35]:25840 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932454AbVLAUgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 15:36:04 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201203406.NNCX14098.eastrmmtao05.cox.net@localhost>;
          Thu, 1 Dec 2005 15:34:06 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1Ehv87-0003Ld-Ic; Thu, 01 Dec 2005 15:34:11 -0500
To: Chuck Lever <cel@citi.umich.edu>
Content-Disposition: inline
In-Reply-To: <438F5D05.4080101@citi.umich.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13071>

On Thu, Dec 01, 2005 at 03:28:53PM -0500, Chuck Lever wrote:
> also, git-diff-index supports a "-r" option, but that doesn't seem to be 
> documented on this page.

I think it is "supported" in the sense that git-diff-index won't
complain about "-r" argument, but it doesn't actually do anything, so
it shouldn't be documented.

-chris
