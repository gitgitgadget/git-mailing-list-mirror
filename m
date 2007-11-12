From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cloning empty repositories,
 was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 12:33:08 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711121231150.21255@xanadu.home>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
 <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site>
 <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrdAb-0002Fa-Hc
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541AbXKLRdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758365AbXKLRdl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:33:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51096 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbXKLRdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:33:40 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRE0020NM38NTK0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Nov 2007 12:33:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0711121715090.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64674>

On Mon, 12 Nov 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 12 Nov 2007, Matthieu Moy wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Mon, 12 Nov 2007, Jan Wielemaker wrote:
> > >
> > >> I found out that cloning a empty bare repository produces nothing at 
> > >> all, [...]
> > >
> > > If they are empty, what exactly do you mean to clone?
> > 
> > I'd expect an empty repository, with the git remote configured 
> > correctly.
> 
> Yeah, right.
> 
> Last time I checked, those geneticists did not clone thin air.  They 
> always waited until they had something to clone.

But we're not geneticists, and I think the above usage should
"just work (tm)".


Nicolas
