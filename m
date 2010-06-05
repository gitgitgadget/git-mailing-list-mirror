From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sat, 05 Jun 2010 14:23:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006051423000.30664@xanadu.home>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
 <20100605150225.GA16594@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>, Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Jun 05 20:23:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKy1z-0006eV-HU
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 20:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0FESXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 14:23:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18850 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab0FESXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 14:23:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L3K004TU0F2K0B0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 05 Jun 2010 14:23:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100605150225.GA16594@localhost>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148484>

On Sat, 5 Jun 2010, Clemens Buchacher wrote:

> On Sat, Jun 05, 2010 at 04:03:30PM +0200, Sverre Rabbelier wrote:
> > On Sat, Jun 5, 2010 at 15:58, Clemens Buchacher <drizzd@aon.at> wrote:
> > 
> > > I could not make much sense of the thread that came with the patch.
> > > The discussion first seems to conclude that it is a bad idea, only
> > > to implement it anyway.
> > 
> > I think it would be useful here to have some links to relevant posts,
> > or at least to the relevant thread.
> 
> The discussion ends with this posting
> http://mid.gmane.org/7viqesz3mk.fsf@alter.siamese.dyndns.org ,
> which basically says "we all agree this is bad."
> 
> Then Junio changes his mind his mind and posts the patches.
> http://mid.gmane.org/7vzl7pyvzl.fsf@alter.siamese.dyndns.org
> 
> Whether the feature has merit or not is suddenly not an issue any
> more and the discussion veers off in other directions about minor
> technical details and about the --nodwim/--noguess option, the
> notion of which I find ridiculous by the way. But it further
> illustrates how random and anti-DWIM this feature really is.

Amen.


Nicolas
