From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues, "log --graph"
Date: Mon, 21 Apr 2008 18:59:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804211859100.2298@eeepc-johanness>
References: <7vbq46fe9h.fsf@gitster.siamese.dyndns.org> <20080420154848.GA8647@mithlond.arda.local> <20080421173312.GA18367@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:00:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo0J4-0001KD-5a
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 19:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbYDUR7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 13:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbYDUR7K
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 13:59:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753615AbYDUR7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 13:59:09 -0400
Received: (qmail invoked by alias); 21 Apr 2008 17:59:05 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 21 Apr 2008 19:59:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/z/6QdnIHz94sLuC/VOdm2eTFQriU1k9V2EusWRY
	PSk2B9GeGoUj20
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080421173312.GA18367@adamsimpkins.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80031>

Hi,

On Mon, 21 Apr 2008, Adam Simpkins wrote:

> On Sun, Apr 20, 2008 at 06:48:48PM +0300, Teemu Likonen wrote:
> > Junio C Hamano wrote (2008-04-19 01:19 -0700):
> > 
> > > Here is an "issues" list I am keeping track of on the back of my head
> > > (and in "TODO" file on 'todo' branch, which is not updated often
> > > enough).
> > 
> > > * log --graph (Adam Simpkins)
> > 
> > Hi Adam, any changes for modifying the "log --graph" patch series to
> > make it apply to the current development version of git? It would just
> > feel wrong if this apparently well-designed tool was left behind. Of
> > course it's up to you.
> 
> Yes.  I didn't mean to drop this, I've just haven't had much time to
> work on it lately.  I may get a chance to work on it tomorrow,
> otherwise I'll do it this coming weekend.
> 
> I'll submit a new series of patches to apply the "log --graph" changes
> onto master.  I think the only thing that needs to be changed is to
> update my code to work with Junio's jc/terminator-separator changes.
> It looks like it should be fairly straightforward.
> 
> Junio and others, is there anything else I should do to make the "log
> --graph" changes ready for pu/next/master?

I look forward to it!

Ciao,
Dscho
