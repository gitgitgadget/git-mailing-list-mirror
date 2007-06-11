From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] refactor dir_add_name
Date: Mon, 11 Jun 2007 15:13:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706111512580.4059@racer.site>
References: <20070611123045.GA28814@coredump.intra.peff.net>
 <20070611133944.GA7008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Jonas Fonseca <fonseca@diku.dk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 16:16:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxkhB-0007Ci-O4
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 16:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbXFKOQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 10:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXFKOQf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 10:16:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:48222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751859AbXFKOQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 10:16:34 -0400
Received: (qmail invoked by alias); 11 Jun 2007 14:16:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 11 Jun 2007 16:16:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fmANUH0IfVJGDo+96fncbLseFDhct7Ii0yNYQDf
	MJy8ZXO8bubwRD
X-X-Sender: gene099@racer.site
In-Reply-To: <20070611133944.GA7008@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49854>

Hi,

On Mon, 11 Jun 2007, Jeff King wrote:

> If we like the alloc_grow approach, there are a lot of places where we 
> can drop a 3-5 line conditional into a single line. I find it much more 
> readable, but others may disagree.

I like it!

Ciao,
Dscho
