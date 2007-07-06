From: tab@snarc.org (Vincent Hanquez)
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 6 Jul 2007 17:59:02 +0200
Message-ID: <20070706155902.GA17489@snarc.org>
References: <468E59B3.7080007@nrlssc.navy.mil> <20070706151145.GA15341@informatik.uni-freiburg.de> <468E5E31.8040504@nrlssc.navy.mil> <Pine.LNX.4.64.0707061631560.4093@racer.site> <468E64F9.9080805@nrlssc.navy.mil> <81b0412b0707060859u6a1c3a24p4399a71d84038615@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 18:18:25 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qVl-0000Rl-4o
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXGFQSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758577AbXGFQSX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:18:23 -0400
Received: from hades.snarc.org ([212.85.152.11]:3170 "EHLO hades.snarc.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874AbXGFQSW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:18:22 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2007 12:18:22 EDT
Received: by hades.snarc.org (Postfix, from userid 1000)
	id DAE931B4D7; Fri,  6 Jul 2007 17:59:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0707060859u6a1c3a24p4399a71d84038615@mail.gmail.com>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51771>

On Fri, Jul 06, 2007 at 05:59:19PM +0200, Alex Riesen wrote:
> On 7/6/07, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> >
> >Is the recommended tab stop 8 characters as it is for linux? or 4?
> >
> 
> Tab is always 8 spaces. It is indentation which can be 8, 4, 3, 2, and even 
> 1.
> It is 8 in Git.

tab isn't 8 spaces. a tab is a tab.
It's usually *APPEARING* at 8 spaces. they *may* appears as a different
size (to fit anyone preferences), as long as they stay as a tab (not
expanded), and that nobody is aligning on tabs.

=> this way the how many spaces should indentation be has no meaning
   since everybody can choose it on their own terminal/display without
   setting any value across readers of the code.

Cheers,
-- 
Vincent Hanquez
