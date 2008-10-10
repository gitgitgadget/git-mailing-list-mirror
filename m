From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fwd: git status options feature suggestion
Date: Fri, 10 Oct 2008 13:13:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810101312360.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>  <20081009061136.GA24288@coredump.intra.peff.net>  <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 13:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoFr7-0003iW-JP
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 13:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbYJJLHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYJJLHN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 07:07:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:55436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753097AbYJJLHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 07:07:11 -0400
Received: (qmail invoked by alias); 10 Oct 2008 11:07:08 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 10 Oct 2008 13:07:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5/AVe69u57P70SnJr0E0jyO0CsAQRM1R2gMSShf
	Gu/EEgq87T6Ycw
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48EE1F58.2060707@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97924>

Hi,

On Thu, 9 Oct 2008, Michael J Gruber wrote:

> 1. make ls-files and diff --name-status use compatible letters

ls-files and diff (at least partially) are plumbing.  Breaking backwards 
compatibility in these is out of the question.

Ciao,
Dscho
