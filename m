From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --color: use $GIT_DIR/config
Date: Sat, 24 Jun 2006 21:44:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606242037550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
 <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0606230756050.6483@g5.osdl.org> <7v7j36yfh1.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 21:45:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuE3r-0001RU-SC
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 21:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWFXTow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 15:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWFXTow
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 15:44:52 -0400
Received: from mail.gmx.net ([213.165.64.21]:55466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751074AbWFXTow (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 15:44:52 -0400
Received: (qmail invoked by alias); 24 Jun 2006 19:44:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 24 Jun 2006 21:44:51 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j36yfh1.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22539>

Hi,

On Sat, 24 Jun 2006, Junio C Hamano wrote:

>  BTW, while doing this, I noticed that the patch does not do the
>  color output for combined diffs.  Care to look into it after
>  Timo's output format series settles?

You mean just copying the relevant parts from your patch, which I missed, 
and do minimal testing? Sure ;-)

But first, by way of thanks to Martin, I have to reintroduce into 
format-patch the check for patches which are already upstream.

Ciao,
Dscho
