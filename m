From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] quote_path: fix collapsing of relative paths
Date: Mon, 3 Dec 2007 12:32:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031231440.27959@racer.site>
References: <20071203053001.GA12696@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 13:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzATc-0007Jw-Tp
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 13:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbXLCMcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 07:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbXLCMcY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 07:32:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:47638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751455AbXLCMcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 07:32:23 -0500
Received: (qmail invoked by alias); 03 Dec 2007 12:32:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 03 Dec 2007 13:32:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DCAJqrS8DhFymiMuzI+XVW9aezT1oStLuPWmwzo
	XZHMHVy9S2VO3G
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203053001.GA12696@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66916>

Hi,

On Mon, 3 Dec 2007, Jeff King wrote:

> This behavior in git-status had been bugging me, and when I went to fix 
> it, I was surprised to find code already there to do it. :) Dscho, 
> please confirm that the test is in fact in error, and that I've read the 
> intent of your code correctly.

Yes, you did.

Ciao,
Dscho
