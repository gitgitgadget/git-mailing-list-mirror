From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: Now What?
Date: Wed, 2 Nov 2005 20:43:07 -0500
Message-ID: <20051103014307.GA1988@pe.Belkin>
References: <E1EXTw5-00063o-Gt@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 02:44:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXU8P-0000Fm-6s
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 02:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVKCBnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 20:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVKCBnS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 20:43:18 -0500
Received: from eastrmmtao03.cox.net ([68.230.240.36]:42403 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030256AbVKCBnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 20:43:17 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103014227.WIGQ2767.eastrmmtao03.cox.net@localhost>;
          Wed, 2 Nov 2005 20:42:27 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1EXU8B-0000WW-RX; Wed, 02 Nov 2005 20:43:07 -0500
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <E1EXTw5-00063o-Gt@jdl.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11063>

On Wed, Nov 02, 2005 at 07:30:37PM -0600, Jon Loeliger wrote:
> 
> The Other Day, I offered to help write up some parts of
> a "Something weird just happened.  Now What?" document.
> 
> So, I'm now soliciting suggestions and/or tips that can
> be thrown together to form the basis of that document.
> 
> I have a few ideas and a rough outline up my sleeve, but
> I am curious to know what _you_ think needs to be covered.

"I cloned a remote repo. Then I pulled a branch from the remote repo
and it started changing all the these files.  I paniced and hit
ctrl-c.  Doh!  I should have checked out the branch locally before
pulling.  Now what?  How can I recover without cloning the repo
again?"

In general, for each common operation, it'd be nice to explain how to
"undo". 

-chris
