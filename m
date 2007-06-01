From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] tig 0.7
Date: Thu, 31 May 2007 18:29:36 -0700
Message-ID: <20070601012936.GA28845@kroah.com>
References: <20070531123808.GA25719@diku.dk> <465F2731.2080707@midwinter.com> <20070531215508.GB9260@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Jun 01 03:28:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtvwU-0000Mi-UF
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 03:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbXFAB2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 21:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758893AbXFAB2b
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 21:28:31 -0400
Received: from canuck.infradead.org ([209.217.80.40]:41197 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758250AbXFAB2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 21:28:30 -0400
Received: from host004.n219-101-177-000.pri.iprevolution.ne.jp ([219.101.177.4] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HtvwH-0005Ll-4Z; Thu, 31 May 2007 21:28:26 -0400
Content-Disposition: inline
In-Reply-To: <20070531215508.GB9260@diku.dk>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48836>

On Thu, May 31, 2007 at 11:55:08PM +0200, Jonas Fonseca wrote:
> Steven Grimm <koreth@midwinter.com> wrote Thu, May 31, 2007:
> > This doesn't build on OS X out of the box, FYI. It needs the following 
> > tweaks (which break the build on Linux, so I'm not suggesting you apply 
> > this -- looks like you might need a configure script or at least some 
> > conditionals in the Makefile.) The change to tig.c cleans up a compiler 
> > warning, but it does build fine without that change.
> 
> I am aware of this and your suggestion is already in the TODO file.
> However, for 0.7 I ended up needing the new status view feature more
> than working on fixing that.

Which is fricken nice to have, thank you very much for adding this, I'm
already using it.

greg "welded to the command line" k-h
