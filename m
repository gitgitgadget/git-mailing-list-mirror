From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Git tree for old kernels
Date: Mon, 20 Aug 2007 14:01:09 -0400
Message-ID: <20070820180109.GE18377@filer.fsl.cs.sunysb.edu>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com> <alpine.LFD.0.999.0708191453030.16727@xanadu.home> <20070820171618.GB9869@filer.fsl.cs.sunysb.edu> <alpine.LFD.0.999.0708201334000.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lkml <linux-kernel@vger.kernel.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBZA-0000LY-Mt
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbXHTSBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXHTSBZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:01:25 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44593 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbXHTSBY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:01:24 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7KI19Hq020691;
	Mon, 20 Aug 2007 14:01:09 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l7KI19OE020688;
	Mon, 20 Aug 2007 14:01:09 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708201334000.16727@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56231>

On Mon, Aug 20, 2007 at 01:40:52PM -0400, Nicolas Pitre wrote:
> On Mon, 20 Aug 2007, Josef Sipek wrote:
> 
> > On Sun, Aug 19, 2007 at 03:24:56PM -0400, Nicolas Pitre wrote:
> > > On Sun, 22 Jul 2007, Jon Smirl wrote:
> > > 
> > > > Continuing on with kernel archeology for embedded systems, any
> > > > interest in making a git tree with all of the kernel versions from the
> > > > beginning up to the start of the current git tree?
> > > 
> > > I just put the archive I've gathered so far in a Git tree on kernel.org:
> > > 
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/nico/archive.git
> > > 
> > > It is also available through gitweb from:
> > > 
> > >     http://git.kernel.org/?p=linux/kernel/git/nico/archive.git
> >  
> > I don't mean to nit-pick but, would it be possible to have the timestamps
> > for the commits closer to the release dates?
> 
> Well, the author timestamp already is, based on the date of the 
> announcement message used for the commit log, including the timezone.  
> If you find errors in those please tell me.

Ah ok. Too bad gitweb displays the commit times => throws off some of the
sorting too.

/me prods gitweb people

> The commit timestamp, however, is the time when _I_ created the 
> repository, hence it should not be that interesting.

Too bad that's the date you see all over the place :( 

Jeff.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
