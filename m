From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 17:22:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909101718370.8306@pacific.mpi-cbg.de>
References: <20090905061250.GA29863@coredump.intra.peff.net> <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de> <20090909104550.GA20108@coredump.intra.peff.net> <7vzl93cncn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
 <20090910141618.GB4942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 17:21:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MllSG-00040v-CW
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 17:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbZIJPUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 11:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbZIJPUv
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 11:20:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:60149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751709AbZIJPUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 11:20:50 -0400
Received: (qmail invoked by alias); 10 Sep 2009 15:20:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 10 Sep 2009 17:20:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wcf4qQ8Aw/cw1i6bGUbyDLrbwsOmFbR0JLUn7be
	D5cUFHfK0fNir/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090910141618.GB4942@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128119>

Hi,

On Thu, 10 Sep 2009, Jeff King wrote:

> Also, I seem to be able to stimulate a segfault on a detached HEAD, but 
> I haven't investigated it yet.

Aaargh!

Mikachu pointed that out recently, provided a test, I fixed it, and in the 
meantime I managed to forget about it!

/me needs to do less things per day.

Ciao,
Dscho
