From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t1410-reflog.sh broken on cygwin
Date: Thu, 11 Jan 2007 11:50:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111149250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0701110235u7df1c963k26c757bd15e03eb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 11 11:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4xVb-0001AR-Mw
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbXAKKuH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbXAKKuH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:50:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:33278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030267AbXAKKuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:50:05 -0500
Received: (qmail invoked by alias); 11 Jan 2007 10:50:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 11 Jan 2007 11:50:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701110235u7df1c963k26c757bd15e03eb2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36580>

Hi,

On Thu, 11 Jan 2007, Alex Riesen wrote:

> ...because it makes assumptions about X-bit. Which are wrong there.
> 
> Have no time to fix it, just noticed it failing.

1b510aa442d992b9983282abfad5743ac0e9be54 (next~5 as of now)

Ciao,
Dscho
