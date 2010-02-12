From: Mike Hommey <mh@glandium.org>
Subject: Re: web-based client for Git, was Re: GSoC 2010
Date: Fri, 12 Feb 2010 14:03:25 +0100
Message-ID: <20100212130325.GA4433@glandium.org>
References: <20100211214833.GU9553@machine.or.cz>
 <201002120502.43565.chriscool@tuxfamily.org>
 <e72faaa81002120222p19db9c75u737e2615c14930b1@mail.gmail.com>
 <e72faaa81002120226y5e4b1c28tbaf6a7dccb9634dc@mail.gmail.com>
 <alpine.DEB.1.00.1002121149470.20986@pacific.mpi-cbg.de>
 <20100212113538.GV9553@machine.or.cz>
 <e72faaa81002120355t4c8596d0q66da4aeb4cce3a94@mail.gmail.com>
 <20100212121844.GK4159@machine.or.cz>
 <20100212124436.GA25606@glandium.org>
 <20100212125146.GW4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 12 14:03:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfvBL-00063V-6G
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 14:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab0BLNDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 08:03:34 -0500
Received: from vuizook.err.no ([85.19.221.46]:57754 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab0BLNDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 08:03:33 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NfvB8-0002Cv-Gi; Fri, 12 Feb 2010 14:03:29 +0100
Received: from mh by jigen with local (Exim 4.71)
	(envelope-from <mh@jigen>)
	id 1NfvB7-0001zj-LW; Fri, 12 Feb 2010 14:03:25 +0100
Content-Disposition: inline
In-Reply-To: <20100212125146.GW4159@machine.or.cz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139703>

On Fri, Feb 12, 2010 at 01:51:46PM +0100, Petr Baudis wrote:
> On Fri, Feb 12, 2010 at 01:44:36PM +0100, Mike Hommey wrote:
> > On Fri, Feb 12, 2010 at 01:18:44PM +0100, Petr Baudis wrote:
> > >   Hi!
> > > 
> > > On Fri, Feb 12, 2010 at 05:25:02PM +0530, Pavan Kumar Sunkara wrote:
> > > > sorry but my mails aren't reaching the mailing list. So it would be
> > > > helpful if you forward this mail to the mailing list
> > > 
> > >   I'm quoting it in full here. :-)
> > > 
> > > > I would be happy to elaborate this.
> > > 
> > >   Thanks a lot!
> > > 
> > > > First of all, this is not another gitweb or gitorious.
> > > > This is a client to use git. I mean, you could use this to work on git
> > > > repositories. (even editing files)
> > > 
> > >   Aha, I see. Are you aware of "gist" [http://gist.github.com/]? It is
> > > in a sense the first attempt to do this, albeit quite rudimentary in
> > > some ways. And it's also closed-source, I'm not personally aware of an
> > > open-source alternative, so this would certainly be useful! Actually,
> > > I can say I would certainly like to add this functionality to repo.or.cz
> > > for creating commits on the mob branches over the web directly.
> > 
> > Surely, something could be plugged into https://bespin.mozilla.com/,
> > which already does a great job at editing.
> 
> That sounds like a nice replacement for the textarea, thanks for the
> tip! On the other hand, I think this is currently the least important
> part of the project and for the basic implementation, even a simple
> textarea should suffice, any prettier editor hopefully could be slammed
> in anytime trivially.

There is VCS integration with bespin, already, but maybe not what people
would like a git web interface to be
https://wiki.mozilla.org/Labs/Bespin/UserGuide#Version_Control

Mike
