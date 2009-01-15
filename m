From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 15:02:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151501400.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de> <496EE74F.6000205@viscovery.net> <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de> <20090115124433.GA4484@chistera.yi.org> <alpine.DEB.1.00.0901151440380.3586@pacific.mpi-cbg.de> <bd6139dc0901150541o491ee9b8n1b5f3540a924b89e@mail.gmail.com> <20090115135716.GC10045@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:03:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSo7-000371-0F
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbZAOOBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 09:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757686AbZAOOBQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 09:01:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:55505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757642AbZAOOBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 09:01:15 -0500
Received: (qmail invoked by alias); 15 Jan 2009 14:01:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 15 Jan 2009 15:01:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qvmtBXLBq1ntJz52MzSTDzLpajECx5a0In/u38n
	fwsyGO91IykX5G
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090115135716.GC10045@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105814>

Hi,

On Thu, 15 Jan 2009, Stephan Beyer wrote:

> Sverre Rabbelier wrote:
> > >> editmsg?
> > >
> > > Has the same first letter as 'edit'.  Would be confusing with the shortcut
> > > 'e', no?
> > 
> > "msgedit" with shortcut 'm'?
> 
> *sigh* If I was just not so late with sequencer...
> 
> There it is "pick -e" (or "pick --edit").

... which obviously shares all the shortcomings of "edit".

Ciao,
Dscho
