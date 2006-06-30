From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] save another call to git-update-index
Date: Fri, 30 Jun 2006 16:43:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606301641540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 16:43:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKDE-0003PL-QO
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 16:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWF3OnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 10:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWF3OnJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 10:43:09 -0400
Received: from mail.gmx.de ([213.165.64.21]:33733 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751015AbWF3OnI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 10:43:08 -0400
Received: (qmail invoked by alias); 30 Jun 2006 14:43:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 30 Jun 2006 16:43:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <fork0@t-online.de>
In-Reply-To: <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22987>

Hi,

On Fri, 30 Jun 2006, Johannes Schindelin wrote:

> FYI I've been just battling this pipe for a couple of hours. The first 
> steps were easy, but since I wanted to do it incrementally, the index has 
> to be written every so often, and I seem not to be able to get that right.

I just finished it. See my upcoming series of three patches. These apply 
on top of your last cumulative patch (sometimes yesterday), although I am 
certain we can merge our efforts.

Ciao,
Dscho
