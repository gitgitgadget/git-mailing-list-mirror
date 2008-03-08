From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/11] Build in clone
Date: Sun, 9 Mar 2008 00:15:35 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803090014310.3975@racer.site>
References: <alpine.LNX.1.00.0803081803250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:16:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8Gv-00030w-KU
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbYCHXPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYCHXPc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:15:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:37978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750756AbYCHXPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:15:31 -0500
Received: (qmail invoked by alias); 08 Mar 2008 23:15:29 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 09 Mar 2008 00:15:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pLzkj5OWppxd4TmOqvZn9Qzy+KFGD2MFNLwp0b3
	wKNMoDe0b3um/r
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803081803250.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76613>

Hi,

On Sat, 8 Mar 2008, Daniel Barkalow wrote:

> and 11 adds support for figuring out what the user means with a bundle 
> and should probably get squashed into 10.

Yes, it should be squashed into 10, methinks.


>  contrib/examples/git-clone.sh |  518 ++++++++++++++++++++++++++++++++++++++
>  git-clone.sh                  |  518 --------------------------------------

I thought I squashed that bug?

Ciao,
Dscho

