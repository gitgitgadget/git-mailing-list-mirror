From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 15:35:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909101534440.8306@pacific.mpi-cbg.de>
References: <20090904135414.GA3728@honk.padd.com> <200909101218.06789.johan@herland.net> <4AA8DC23.6050500@drmicha.warpmail.net> <200909101429.30190.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Pete Wyckoff <pw@padd.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 15:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mljmi-0000Zz-9L
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 15:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZIJNdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 09:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbZIJNdu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 09:33:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:34462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752145AbZIJNdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 09:33:49 -0400
Received: (qmail invoked by alias); 10 Sep 2009 13:33:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 10 Sep 2009 15:33:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19yxyx8aphyK/KtXJ81efGF40zvxGXN5PFwJNDGmT
	LmHIYH6p/9xnwf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200909101429.30190.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128110>

Hi,

On Thu, 10 Sep 2009, Johan Herland wrote:

> I think I vote for the second option, renaming 'git branch --track' 
> to 'git branch --upstream', and s/@{tracked}/@{upstream}/.

That does not make any sense, as that --track is to be understood as a 
verb.  How do you "upstream a branch"?

Ciao,
Dscho
