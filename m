From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 23:25:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708042321590.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <46B4DF39.2070506@lsrfire.ath.cx>
 <Pine.LNX.4.64.0708042232390.14781@racer.site> <46B4F923.3090604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:25:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHS43-0003NA-Jp
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762841AbXHDWZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 18:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762478AbXHDWZh
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:25:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:39178 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761291AbXHDWZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 18:25:36 -0400
Received: (qmail invoked by alias); 04 Aug 2007 22:25:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 05 Aug 2007 00:25:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Tx/Ic1fgTByGrGpUtzWos82eEy7ko39KMw/zhyZ
	/FA2HdynUnhf2B
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4F923.3090604@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54915>

Hi,

On Sun, 5 Aug 2007, Ren? Scharfe wrote:

> Johannes Schindelin schrieb:
>
> > On Sat, 4 Aug 2007, Ren? Scharfe wrote:
> > 
> >> I can't offer a fix, but I think I've captured install-doc-quick.sh's 
> >> problem in a test script (see below).  It fails with e90fdc3 (and 
> >> master) but succeeds with e90fdc3^.
> > 
> > It succeeds here... (without the patch I sent out, of course.)
> 
> I assume you tested e90fdc3 and e90fdc3^; what about 4f8f03d (current 
> HEAD)?

I thought I tested on master + --new-workdir... But I did not.

And indeed, it fails.

Sorry,
Dscho
