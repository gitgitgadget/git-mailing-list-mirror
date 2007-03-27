From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --pretty=format: fix broken %ct and %at interpolation
Date: Wed, 28 Mar 2007 01:42:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703280142230.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070327232628.GA9981@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLJZ-0006ik-28
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXC0Xmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXC0Xmw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:42:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:34971 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752812AbXC0Xmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:42:51 -0400
Received: (qmail invoked by alias); 27 Mar 2007 23:42:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 28 Mar 2007 01:42:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1848w0eoVc4P3q1zlrZOSnkbkxHmQPY4q7hVhAn1T
	SqLp/WLIJzScXH
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070327232628.GA9981@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43323>

Hi,

On Tue, 27 Mar 2007, Jeff King wrote:

> A pointer arithmetic error in fill_person caused random data
> from the commit object to be included with the timestamp,

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
