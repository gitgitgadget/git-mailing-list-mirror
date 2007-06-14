From: Josef Sipek <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Thu, 14 Jun 2007 12:39:40 -0400
Message-ID: <20070614163940.GA4752@filer.fsl.cs.sunysb.edu>
References: <11818254621527-git-send-email-madcoder@debian.org> <20070614152702.GC934@filer.fsl.cs.sunysb.edu> <20070614155600.GM23324@artemis> <20070614155826.GN23324@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 18:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HysMN-0002dK-6B
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 18:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbXFNQjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbXFNQjp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 12:39:45 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:40124 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXFNQjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 12:39:44 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5EGdf1W008899;
	Thu, 14 Jun 2007 12:39:41 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5EGde2R008897;
	Thu, 14 Jun 2007 12:39:40 -0400
Content-Disposition: inline
In-Reply-To: <20070614155826.GN23324@artemis>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50213>

On Thu, Jun 14, 2007 at 05:58:26PM +0200, Pierre Habouzit wrote:
> On Thu, Jun 14, 2007 at 05:56:00PM +0200, Pierre Habouzit wrote:
> > On Thu, Jun 14, 2007 at 11:27:02AM -0400, Josef Sipek wrote:
> > > Thanks a lot!
> > 
> >   Well, worry for the obvious mistakes.
>          *sorry
> 
>   Now, *that* was an interesting typo :P

:)

Ok, pushed to kernel.org. I folded the 2 regression fixing patches into the
right places.

Thanks a lot!

Josef "Jeff" Sipek.

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help
  you shoot yourself in the foot for free. 
