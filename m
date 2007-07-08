From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Push code for transport library
Date: Sun, 8 Jul 2007 21:29:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707082128290.4248@racer.site>
References: <Pine.LNX.4.64.0707081608100.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jul 08 22:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7dUv-0002Jm-0N
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 22:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbXGHUgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 16:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbXGHUgq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 16:36:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:46787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755455AbXGHUgq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 16:36:46 -0400
Received: (qmail invoked by alias); 08 Jul 2007 20:36:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 08 Jul 2007 22:36:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j0E4ta6UjzCeCGV5IUf6gjpOf6nPEu12XB3r0Jq
	2x9uKCnwLUD2Tg
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707081608100.6977@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51916>

Hi,

On Sun, 8 Jul 2007, Daniel Barkalow wrote:

> This moves the code to call push backends into a library that can be 
> extended to make matching fetch and push decisions based on the URL it 
> gets, and which could be changed to have built-in implementations 
> instead of calling external programs.

I do not have time to look at the patch more closely, but I like the 
direction this takes very much.

Thanks,
Dscho
