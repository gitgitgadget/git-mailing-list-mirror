From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/9] git-verify-pack: make builtin
Date: Thu, 10 Aug 2006 18:24:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608101823500.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <11552221581436-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 18:25:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBDLG-0000g2-Ui
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 18:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161440AbWHJQYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 12:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWHJQYx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 12:24:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:39861 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161439AbWHJQYw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 12:24:52 -0400
Received: (qmail invoked by alias); 10 Aug 2006 16:24:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 10 Aug 2006 18:24:50 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <11552221581436-git-send-email-rene.scharfe@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25200>

Hi,

On Thu, 10 Aug 2006, Rene Scharfe wrote:

>  Makefile              |    1 +
>  builtin-verify-pack.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h             |    1 +
>  git.c                 |    1 +
>  verify-pack.c         |   76 ------------------------------------------------
>  5 files changed, 80 insertions(+), 76 deletions(-)

This would look much nicer with "-M". Maybe we should make that a default 
for git-format-patch?

Ciao,
Dscho
