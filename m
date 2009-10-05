From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
  appropriate to do so
Date: Tue, 6 Oct 2009 00:45:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910060044070.4985@pacific.mpi-cbg.de>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>  <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <76718490910051500m32878c7dgcc86489933cb2309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1234976282-1254782710=:4985"
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuwJX-0004g9-EU
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 00:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbZJEWne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbZJEWne
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 18:43:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:40892 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754828AbZJEWne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 18:43:34 -0400
Received: (qmail invoked by alias); 05 Oct 2009 22:42:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 06 Oct 2009 00:42:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qsrIS/cXqBthQWptkvSGRqiWeqVm0v1oA0RUFia
	vUz90j6MMF7fJ4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490910051500m32878c7dgcc86489933cb2309@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129600>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1234976282-1254782710=:4985
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 Oct 2009, Jay Soffian wrote:

> On Mon, Oct 5, 2009 at 5:17 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Actually, we should really think long and hard why we should not
> > automatically check out the local branch "next" in that case.  I mean,
> > really long and hard, and making sure to take user-friendliness into
> > account at least as much as simplicity of implementation.
> 
> Sure, why not? Are you asking for a patch, or just soliciting 
> conversation?

I am asking for thoughtful arguments for and against my (shyly implied) 
proposal.

Ciao,
Dscho

--8323328-1234976282-1254782710=:4985--
