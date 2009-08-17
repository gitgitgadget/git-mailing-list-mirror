From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using VC build git (split patch)
Date: Mon, 17 Aug 2009 15:43:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171542520.4991@intel-tinevez-2-302>
References: <1976ea660908170613ibb9a0fdr7ba630671a6b735f@mail.gmail.com> <40aa078e0908170619r3d325e0csee466446df474302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 15:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md2Ut-0000bu-Jk
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 15:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbZHQNn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 09:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZHQNn2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 09:43:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:44213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751588AbZHQNn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 09:43:27 -0400
Received: (qmail invoked by alias); 17 Aug 2009 13:43:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 17 Aug 2009 15:43:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TCv5yiwUTXl852v9AOK/Jp6X2hX35l49Zsj+Ord
	qWtZmzzH5kjnBr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0908170619r3d325e0csee466446df474302@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 17 Aug 2009, Erik Faye-Lund wrote:

> On Mon, Aug 17, 2009 at 3:13 PM, Frank Li<lznuaa@gmail.com> wrote:
> > I try to use git format-patch -M --stdout origin/master | git
> > imap-send to send patch directly according to guide.
> > But imap-send has not ported to msysgit.
> 
> Then use send-email, which IS supported in msysgit.

Yes, I would appreciate inline patches.  Otherwise it is pretty awkward 
and time-consuming to quote your patch when I comment on it.

Ciao,
Dscho
