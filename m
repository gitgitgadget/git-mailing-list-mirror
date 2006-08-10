From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 8/9] git-verify-pack: no need to count errors
Date: Thu, 10 Aug 2006 18:23:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101822550.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <11552221583276-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 18:24:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBDJx-0000Mp-7p
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 18:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161428AbWHJQXf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161429AbWHJQXd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 12:23:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:6045 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161425AbWHJQX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 12:23:29 -0400
Received: (qmail invoked by alias); 10 Aug 2006 16:23:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 10 Aug 2006 18:23:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <11552221583276-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25199>

Hi,

there was no harm done counting the errors, i.e. no need to "fix" that.

Ciao,
Dscho
