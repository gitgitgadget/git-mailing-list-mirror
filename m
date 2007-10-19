From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 16:31:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191630180.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org> <8aa486160710190303l4ce996daqf5c8025c857ea8@mail.gmail.com>
 <20071019113822.GB16726@thunk.org> <4718A3AB.7090301@viscovery.net>
 <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Theodore Tso <tytso@thunk.org>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iissh-0007DX-JA
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950AbXJSObH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932908AbXJSObG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:31:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:38183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932790AbXJSObD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:31:03 -0400
Received: (qmail invoked by alias); 19 Oct 2007 14:31:01 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp030) with SMTP; 19 Oct 2007 16:31:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/R18JoiNPRK5V5KzqftVLxCJXDIWLmLerJx7sUQ/
	CtyRj399B+Qnuc
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LFD.0.9999.0710191009330.19446@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61716>

Hi,

On Fri, 19 Oct 2007, Nicolas Pitre wrote:

> On Fri, 19 Oct 2007, Johannes Sixt wrote:
> 
> > ==> git://repo.or.cz/git/spearce.git
> >  * (new)              gitk -> spearce/gitk
> >  * 1aa3d01..e7187e4   maint -> spearce/maint
> >  * de61e42..7840ce6   master -> spearce/master
> >  * 895be02..2fe5433   next -> spearce/next
> >  + 89fa332...1e4c517  pu -> spearce/pu
> >  * (new)              todo -> spearce/todo
> 
> Actually I think this is the best format so far: one line per branch, no 
> terminal width issue (long branch names are simply wrapped), the 
> old..new info is there also with the single character marker to quickly 
> notice the type of update.

Yes.  Definitely my favourite so far, too.

Ciao,
Dscho
