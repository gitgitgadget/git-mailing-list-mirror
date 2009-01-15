From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 19:21:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151921040.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de> <496EE74F.6000205@viscovery.net> <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de> <bd6139dc0901150445l51f3b861n5bbd85bb6d1382b6@mail.gmail.com> <7vmydsv72u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:22:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNWqn-0001kF-QB
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 19:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914AbZAOSU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 13:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758073AbZAOSU3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 13:20:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:35349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754982AbZAOSU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 13:20:28 -0500
Received: (qmail invoked by alias); 15 Jan 2009 18:20:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 15 Jan 2009 19:20:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yUDQzHKTyrCWDsphGIXfX4/OePz7+Sb2jtfovDp
	xkzPY1NEcR4bFB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmydsv72u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105863>

Hi,

On Thu, 15 Jan 2009, Junio C Hamano wrote:

> "Sverre Rabbelier" <srabbelier@gmail.com> writes:
> 
> > On Thu, Jan 15, 2009 at 13:36, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> If at all, I'd introduce 'examine' as a synonym to 'edit' (might be more
> >> intuitive).
> >
> > Examine suggests that you cannot change the commit (you can look, but
> > don't touch it!), no?
> 
> 'stop' would be closest to what it currently does.  It stops and it is up
> to you how to screw up the result ;-).

But it shares the first letter with 'squash'.

Ciao,
Dscho
