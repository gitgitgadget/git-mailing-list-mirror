From: Petr Baudis <pasky@suse.cz>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 13:51:46 +0100
Message-ID: <20100212125146.GW4159@machine.or.cz>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
 <20100211214833.GU9553@machine.or.cz>
 <201002120502.43565.chriscool@tuxfamily.org>
 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
 <20100212113538.GV9553@machine.or.cz>
 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
 <20100212121844.GK4159@machine.or.cz>
 <20100212124436.GA25606@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:52:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfv0C-0006h6-Je
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab0BLMvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 07:51:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34594 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab0BLMvs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 07:51:48 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8172D125A0EC; Fri, 12 Feb 2010 13:51:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100212124436.GA25606@glandium.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139700>

On Fri, Feb 12, 2010 at 01:44:36PM +0100, Mike Hommey wrote:
> On Fri, Feb 12, 2010 at 01:18:44PM +0100, Petr Baudis wrote:
> >   Hi!
> > 
> > On Fri, Feb 12, 2010 at 05:25:02PM +0530, Pavan Kumar Sunkara wrote:
> > > sorry but my mails aren't reaching the mailing list. So it would be
> > > helpful if you forward this mail to the mailing list
> > 
> >   I'm quoting it in full here. :-)
> > 
> > > I would be happy to elaborate this.
> > 
> >   Thanks a lot!
> > 
> > > First of all, this is not another gitweb or gitorious.
> > > This is a client to use git. I mean, you could use this to work on git
> > > repositories. (even editing files)
> > 
> >   Aha, I see. Are you aware of "gist" [http://gist.github.com/]? It is
> > in a sense the first attempt to do this, albeit quite rudimentary in
> > some ways. And it's also closed-source, I'm not personally aware of an
> > open-source alternative, so this would certainly be useful! Actually,
> > I can say I would certainly like to add this functionality to repo.or.cz
> > for creating commits on the mob branches over the web directly.
> 
> Surely, something could be plugged into https://bespin.mozilla.com/,
> which already does a great job at editing.

That sounds like a nice replacement for the textarea, thanks for the
tip! On the other hand, I think this is currently the least important
part of the project and for the basic implementation, even a simple
textarea should suffice, any prettier editor hopefully could be slammed
in anytime trivially.

-- 
				Petr "Pasky" Baudis
A great many people think they are thinking when they are merely
rearranging their prejudices. -- William James
