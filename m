From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 17:03:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511111703001.16340@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de>
 <Pine.LNX.4.63.0511111511050.7575@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051111150530.GT30496@pasky.or.cz> <Pine.LNX.4.63.0511111636400.16210@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051111154938.GU30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 17:05:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EabNQ-0005Ka-Od
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVKKQDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVKKQDb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:03:31 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:5562 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750821AbVKKQDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 11:03:30 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AE86413F375; Fri, 11 Nov 2005 17:03:29 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8E5549F24F; Fri, 11 Nov 2005 17:03:29 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 787E891B78; Fri, 11 Nov 2005 17:03:29 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 53C6913F375; Fri, 11 Nov 2005 17:03:29 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051111154938.GU30496@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11611>

Hi,

On Fri, 11 Nov 2005, Petr Baudis wrote:

> This is about being consistent, and also to support dumber protocols
> better.

For my local development, I couldn't care less about dumber protocols.

Hth,
Dscho
