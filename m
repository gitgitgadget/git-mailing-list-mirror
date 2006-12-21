From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: warning merge message
Date: Thu, 21 Dec 2006 10:23:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612211022280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 10:24:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxK9U-0004sC-GJ
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWLUJXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbWLUJXp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:23:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:57815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965160AbWLUJXo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:23:44 -0500
Received: (qmail invoked by alias); 21 Dec 2006 09:23:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 21 Dec 2006 10:23:42 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <867728.44872.qm@web31814.mail.mud.yahoo.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35039>

Hi,

On Wed, 20 Dec 2006, Luben Tuikov wrote:

> Can we please eliminate this f@#$ing message:
> Warning: No merge candidate found because value of config option
>          "branch.master.merge" does not match any remote branch fetched.

Well, you can always tell git explicitely what you want. I.e. specify the 
remote _and_ the branch you want to merge.

BTW I am still waiting for your test results regarding the segmentation 
fault of merge-recursive.

Ciao,
Dscho
