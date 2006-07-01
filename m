From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 17:23:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607011722360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 17:23:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwhJa-0006CL-Mh
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 17:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWGAPXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWGAPXP
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 11:23:15 -0400
Received: from mail.gmx.net ([213.165.64.21]:42733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750937AbWGAPXN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 11:23:13 -0400
Received: (qmail invoked by alias); 01 Jul 2006 15:23:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 01 Jul 2006 17:23:12 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060701150926.GA25800@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23049>

Hi,

On Sat, 1 Jul 2006, Rene Scharfe wrote:

> +				exclude = get_merge_bases(a, b);

Aaah! Junio, Linus, I see the light now.

Ciao,
Dscho
