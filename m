From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: a few remaining issues...
Date: Fri, 5 Jan 2007 14:55:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 14:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2pY0-00010W-6R
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 14:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbXAENzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 08:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXAENzt
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 08:55:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:53003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161098AbXAENzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 08:55:48 -0500
Received: (qmail invoked by alias); 05 Jan 2007 13:55:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 05 Jan 2007 14:55:46 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36003>

Hi,

On Fri, 5 Jan 2007, Junio C Hamano wrote:

> * Reflogs.
> 
> 'git reflog show' needs to be done -- and preferrably in a way that does 
> not add too much code.

I do not have time to follow up on my earlier attempts to teach git-log 
about traversing reflogs instead of the commit parents. But Shawn had a 
working proposal, didn't he?

Ciao,
Dscho
