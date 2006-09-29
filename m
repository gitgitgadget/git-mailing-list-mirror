From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: kernel.org problems?
Date: Fri, 29 Sep 2006 20:37:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609292035360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 29 20:37:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTNEu-0002Pg-EV
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 20:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWI2ShT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 14:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWI2ShT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 14:37:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:46246 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422653AbWI2ShN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 14:37:13 -0400
Received: (qmail invoked by alias); 29 Sep 2006 18:37:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 29 Sep 2006 20:37:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28123>

Hi,

when I try fetching from kernel.org, I get

	fatal: read error (Connection reset by peer)
	Fetch failure: git://git.kernel.org/pub/scm/git/git.git

all the time. Fetching by HTTP instead of git protocol works fine, though. 

What is happening?

Ciao,
Dscho
