From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 20:28:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901152027130.3586@pacific.mpi-cbg.de>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <7vmydsv72u.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901151921040.3586@pacific.mpi-cbg.de> <200901151946.04991.johan@herland.net> <87ocy8flka.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNXtP-0004m4-6Q
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 20:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbZAOT1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756941AbZAOT1P
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 14:27:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:50298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754737AbZAOT1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 14:27:14 -0500
Received: (qmail invoked by alias); 15 Jan 2009 19:27:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp026) with SMTP; 15 Jan 2009 20:27:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LtLtpxd8L3GypC/qmpI749CYLy/gbktGd7sB5SA
	1t52S01v42pvaX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ocy8flka.fsf@cup.kalibalik.dk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105869>

Hi,

On Thu, 15 Jan 2009, Anders Melchiorsen wrote:

> break

As rebase -i is just a loop of cherry-picks, as a C programmer I would 
think: "does this break out of the loop"?

Ciao,
Dscho
