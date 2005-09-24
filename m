From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Subject: Re: /bin/sh portability question
Date: Sat, 24 Sep 2005 19:35:15 +0200
Message-ID: <1127583315.895.11.camel@tetris>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
	 <7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 19:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJDwE-00068d-Bb
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 19:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVIXRfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 13:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVIXRfr
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 13:35:47 -0400
Received: from khepri.openbios.org ([80.190.231.112]:37287 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S932205AbVIXRfq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 13:35:46 -0400
Received: from dsl-082-083-078-010.arcor-ip.net ([82.83.78.10] helo=t-stueck.streichelzoo)
	by khepri.openbios.org with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.50)
	id 1EJDw3-000315-NJ; Sat, 24 Sep 2005 19:35:40 +0200
Received: from 192.168.1.202 ([192.168.1.202])
	by t-stueck.streichelzoo (8.13.4+Sun/8.13.3) with ESMTP id j8OHZWAK015588;
	Sat, 24 Sep 2005 19:35:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzm4duf8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6.316 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (t-stueck.streichelzoo [192.168.1.200]); Sat, 24 Sep 2005 19:35:38 +0200 (CEST)
X-Spam-Score: -1.3 (-)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9239>

On Fri, 2005-09-23 at 11:07, Junio C Hamano wrote:
> Good to have a Solaris user.  I have one patch that I've been
> keeping in the proposed updates branch, waiting for a
> comfirmation or 'not-good-enough-for-me' answer from people that
> have cURL installed in nonstandard places.
sorry for the lack of reponse.. apart from fixing up context (to match
0.99.7), this patch works here.


thanks,
patrick mauritz
