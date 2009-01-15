From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Thu, 15 Jan 2009 14:57:16 +0100
Message-ID: <20090115135716.GC10045@leksak.fem-net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de> <496EE74F.6000205@viscovery.net> <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com> <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de> <20090115124433.GA4484@chistera.yi.org> <alpine.DEB.1.00.0901151440380.3586@pacific.mpi-cbg.de> <bd6139dc0901150541o491ee9b8n1b5f3540a924b89e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adeodato =?iso-8859-1?Q?Sim=F3?= <dato@net.com.org.es>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:59:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSkQ-0001bP-OU
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785AbZAON50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbZAON5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:57:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:42055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765416AbZAON5X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:57:23 -0500
Received: (qmail invoked by alias); 15 Jan 2009 13:57:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp022) with SMTP; 15 Jan 2009 14:57:21 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX193TP4FVKx3ZI7eHYgWJk1Vxex3GKhO9VAoNxcsbA
	VUM4TQH46ZJTb7
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNSii-00051P-1p; Thu, 15 Jan 2009 14:57:16 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0901150541o491ee9b8n1b5f3540a924b89e@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105810>

Hi,

Sverre Rabbelier wrote:
> >> editmsg?
> >
> > Has the same first letter as 'edit'.  Would be confusing with the shortcut
> > 'e', no?
> 
> "msgedit" with shortcut 'm'?

*sigh* If I was just not so late with sequencer...

There it is "pick -e" (or "pick --edit").

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
