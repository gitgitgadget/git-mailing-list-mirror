From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:21:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804292320240.13650@eeepc-johanness>
References: <4816E40A.4020700@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home>
 <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <4816E0F6.3030302@op5.se> <200804292108.m3TL8moV011790@mi1.bluebottle.com> <4817915C.6060009@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, Andreas Ericsson <ae@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:22:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqyDB-0007ep-8T
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbYD2WVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbYD2WVU
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:21:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:36743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752714AbYD2WVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:21:19 -0400
Received: (qmail invoked by alias); 29 Apr 2008 22:21:17 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp038) with SMTP; 30 Apr 2008 00:21:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pEbk4oCApSY2NRsTqkmOARt0unwJTONakoDhb15
	dLESWzWFL0jCKu
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4817915C.6060009@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80757>

Hi,

On Tue, 29 Apr 2008, Paolo Bonzini wrote:

> > Sorry but then why does this patch have to even touch "git fetch"?  
> > Isn't it enough to run "git remote update"?
> 
> I'm tired of answering.  Please read the cover letter.

Actually, this is unfair.  You did not answer it to my satisfaction, but I 
thought that maybe it is just me.

Alas, apparently it is not just me.  I think that "git fetch" is something 
more concise than "git remote update", and that it is a good thing.

Ciao,
Dscho
