From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Replace remaining git-* calls in git stash
Date: Tue, 21 Jul 2009 22:57:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907212256450.3155@pacific.mpi-cbg.de>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at> <1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTMN2-0006PZ-BD
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbZGUUzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbZGUUzY
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:55:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:39837 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755737AbZGUUzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:55:23 -0400
Received: (qmail invoked by alias); 21 Jul 2009 20:55:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 21 Jul 2009 22:55:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PbOwUlgzP5Cs7VCHubGNfSMtTuTGX5+FGjLzrK4
	IbNkUEs54Q0Mjs
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123716>

Hi,

On Tue, 21 Jul 2009, Martin Koegler wrote:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

Here, at least, the commit subject is helpful.

And why exactly can't you squash 2/2 into 1/2 (keeping the commit subject 
of 2/2, more or less)?  The changes are conceptually the same.

Ciao,
Dscho
