From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout without arguments does not make sense
Date: Tue, 22 Jul 2008 02:57:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807220256270.3407@eeepc-johanness>
References: <200807212206.32818.johannes.sixt@telecom.at> <20080721204955.GI32057@genesis.frugalware.org> <32541b130807211436h77bf5985xa61ed7b4941c47dc@mail.gmail.com> <20080721214459.GJ32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 02:58:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL6Ce-0001HZ-AI
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 02:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbYGVA5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbYGVA5G
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 20:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754505AbYGVA5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 20:57:05 -0400
Received: (qmail invoked by alias); 22 Jul 2008 00:57:02 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp030) with SMTP; 22 Jul 2008 02:57:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aRmRCVWKaWgzN7sdyoaUHPMW3Ya+L7Evr1EbcKv
	B6INa0DEvTFuWi
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080721214459.GJ32057@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89422>

Hi,

On Mon, 21 Jul 2008, Miklos Vajna wrote:

> On Mon, Jul 21, 2008 at 05:36:59PM -0400, Avery Pennarun <apenwarr@gmail.com> wrote:
>
> > I think "git status" reports this information in recent versions, 
> > doesn't it?
> 
> Right. But that shows other infos as well, for example the untracked 
> files, etc. So there are cases when git checkout is just better.
> 
> However, you are right about it may not be the best habit from my side 
> to use git checkout to get that info. ;-)

I usually call "git status" for that information.  But Junio suggested 
checkout recently on #git, for exactly that information, so you are not 
alone at all.

Ciao,
Dscho
