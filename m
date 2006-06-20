From: Nicolas Pitre <nico@cam.org>
Subject: Re: packs and trees
Date: Tue, 20 Jun 2006 16:51:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606201650180.3377@localhost.localdomain>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com>
 <Pine.LNX.4.64.0606201102410.3377@localhost.localdomain>
 <46a038f90606201241x3dec242dicde245a24c3ab9ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 20 22:51:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsnC6-0007jg-UZ
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 22:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWFTUvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 16:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWFTUvO
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 16:51:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35265 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751039AbWFTUvM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 16:51:12 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J160049LF9BBVB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Jun 2006 16:51:11 -0400 (EDT)
In-reply-to: <46a038f90606201241x3dec242dicde245a24c3ab9ab@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22224>

On Wed, 21 Jun 2006, Martin Langhoff wrote:

> On 6/21/06, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 20 Jun 2006, Martin Langhoff wrote:
> > 
> > > On 6/20/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > > The plan is to modify rcs2git from parsecvs to create all of the git
> > > > objects for the tree.
> > >
> > > Sounds like a good plan. Have you seen recent discussions about it
> > > being impossible to repack usefully when you don't have trees (and
> > > resulting performance problems on ext3).
> > 
> > What do you mean?
> 
> I was thinking of the "repacking disconnected objects" thread, but now
> I see it did have a solution in listing all the objects and paths. I
> take that back.

OK.


Nicolas
