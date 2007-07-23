From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix problematic ']'
Date: Mon, 23 Jul 2007 21:51:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707232150580.14781@racer.site>
References: <200707232236.21389.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4sk-0002Yv-2T
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934181AbXGWUvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934947AbXGWUvc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:51:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:40660 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935044AbXGWUvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:51:31 -0400
Received: (qmail invoked by alias); 23 Jul 2007 20:51:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 23 Jul 2007 22:51:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SZ3k0pFsSf9Sn7dPBTszws1Ta1Okpz+6T5Vk8A9
	zcuBBUy3Sucggy
X-X-Sender: gene099@racer.site
In-Reply-To: <200707232236.21389.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53483>

Hi,

On Mon, 23 Jul 2007, Johannes Sixt wrote:

> Not all shells grok a closing ']' of the shell '[' command without
> surrounding space.

Darn.

Thanks for cleaning up behind me,
Dscho
