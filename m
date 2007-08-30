From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5701: "wc -l" may add whitespace
Date: Thu, 30 Aug 2007 10:26:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708301026060.28586@racer.site>
References: <Pine.LNX.4.64.0708291752050.28586@racer.site>
 <7vbqcpa6t6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 11:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQgJF-0008CB-Rl
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 11:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbXH3J1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 05:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755808AbXH3J1L
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 05:27:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:36938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754984AbXH3J1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 05:27:10 -0400
Received: (qmail invoked by alias); 30 Aug 2007 09:27:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 30 Aug 2007 11:27:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NHpVfO3VNWqMUr7FgixOkdOl3kRGcxQLT/E6CkF
	lfJzEY76pIPYcz
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqcpa6t6.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57015>

Hi,

On Wed, 29 Aug 2007, Junio C Hamano wrote:

> Isn't this already in as 70f64148bf7ca5136f2aa18c41b3b8f4bebfd138
> (Fix t5701-clone-local for white space from wc)?

Argh.  I get confused with those new-workdirs.  (And it was necessary 
for 4msysgit, which lags behind again...)  Sorry for the noise.

Ciao,
Dscho
