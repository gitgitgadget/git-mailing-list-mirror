From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sat, 20 Jan 2007 10:52:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701201051320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jan 20 10:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Ctr-00052F-KJ
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 10:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbXATJwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 04:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbXATJwh
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 04:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:50358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965244AbXATJwg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 04:52:36 -0500
Received: (qmail invoked by alias); 20 Jan 2007 09:52:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 20 Jan 2007 10:52:35 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37264>

Hi,

On Sat, 20 Jan 2007, Johannes Schindelin wrote:

> Embarassing thinko.

BTW this fixes your "git-log --walk-reflogs -1 --pretty=s master@{1.day}" 
bug.

Ciao,
Dscho
