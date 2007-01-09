From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 9 Jan 2007 17:15:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091715040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070109161147.GA9313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 17:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4JdC-0004BW-3B
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 17:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbXAIQPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 11:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXAIQPT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 11:15:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:52520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932188AbXAIQPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 11:15:18 -0500
Received: (qmail invoked by alias); 09 Jan 2007 16:15:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 09 Jan 2007 17:15:16 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jeff King <peff@peff.net>
In-Reply-To: <20070109161147.GA9313@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36373>

Hi,

On Tue, 9 Jan 2007, Jeff King wrote:

> This means that
>   git show HEAD:
> will now return HEAD^{tree}, which is logically consistent with
>   git show HEAD:Documentation

Good idea!

Ciao,
Dscho
