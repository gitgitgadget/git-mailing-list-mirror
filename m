From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/9] Add has_extension()
Date: Thu, 10 Aug 2006 18:25:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101825000.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 18:26:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBDME-0000vS-Tm
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 18:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161442AbWHJQZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWHJQZq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 12:25:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:62672 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161442AbWHJQZp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 12:25:45 -0400
Received: (qmail invoked by alias); 10 Aug 2006 16:25:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 10 Aug 2006 18:25:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25201>

Hi,

On Thu, 10 Aug 2006, Rene Scharfe wrote:

> The little helper has_extension() documents through its name what we are
> trying to do and makes sure we don't forget the underrun check.

While I think it is a good change, it is independent of verify-pack, no?

Ciao,
Dscho
