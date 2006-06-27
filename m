From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Tue, 27 Jun 2006 09:55:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270954500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j35wp84.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606251033030.3747@g5.osdl.org> <7vpsgvf8jf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606262321270.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 27 09:55:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv8Pr-0005Lu-AR
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 09:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWF0HzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 03:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWF0HzU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 03:55:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:10160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161037AbWF0HzT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 03:55:19 -0400
Received: (qmail invoked by alias); 27 Jun 2006 07:55:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 27 Jun 2006 09:55:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606262321270.3927@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22710>

Hi,

On Mon, 26 Jun 2006, Linus Torvalds wrote:

> 	#define DUMMYPTR ((void *)"")

NULL_STRING describes better what you want.

Ciao,
Dscho
