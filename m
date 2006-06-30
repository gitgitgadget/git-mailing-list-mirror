From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] save another call to git-update-index
Date: Fri, 30 Jun 2006 02:37:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 02:38:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw719-0004ks-Ga
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWF3Ahv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWF3Ahv
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:37:51 -0400
Received: from mail.gmx.net ([213.165.64.21]:8411 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750816AbWF3Ahv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 20:37:51 -0400
Received: (qmail invoked by alias); 30 Jun 2006 00:37:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 30 Jun 2006 02:37:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <fork0@t-online.de>
In-Reply-To: <20060630002756.GD22618@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22938>

Hi,

FYI I've been just battling this pipe for a couple of hours. The first 
steps were easy, but since I wanted to do it incrementally, the index has 
to be written every so often, and I seem not to be able to get that right.

But now it's time to go to bed, so this will wait for tomorrow.

Ciao,
Dscho
