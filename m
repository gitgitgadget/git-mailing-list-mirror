From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cross-Platform Version Control
Date: Fri, 15 May 2009 00:25:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905150022400.26154@pacific.mpi-cbg.de>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <alpine.DEB.2.00.0905141441200.20117@perkele.intern.softwolves.pp.se> <4A0C77D9.5050402@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 00:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4jMr-0007ec-0L
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 00:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbZENWZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 18:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbZENWZX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 18:25:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:33438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbZENWZX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 18:25:23 -0400
Received: (qmail invoked by alias); 14 May 2009 22:25:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 15 May 2009 00:25:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JjVlZjjjJHQDRkoIVPMNHIZ9EL+z92qSUXlcjiO
	/0bAc02azWG9va
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A0C77D9.5050402@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119231>

Hi,

On Thu, 14 May 2009, Esko Luontola wrote:

> Peter Krefting wrote on 14.5.2009 16:48:
> 
> > The best way would be to define this in the Git core once and for all, 
> > and add support to it for all the platforms in the same go, instead of 
> > trying to hack around the issue whenever it pops up on the various 
> > platforms.
> 
> +1

You might be enthusiastic about this cunning idea.  However, if it costs 
me performance on Linux, and all the benefits go to Windows users, then I 
will remove this "solution" from my personal Git tree _right away_, and 
I'd expect a lot of other people, too.

I repeat this just once more: if you add complexity, you'll have to have a 
compelling reason to do so.  If there is no benefit for Linux users, why 
should they bear the cost?

But as Andreas remarked, I sincerely think that there has been enough talk 
about the issue.  It's time to see some patches, or to stop the 
discussion.

Ciao,
Dscho
