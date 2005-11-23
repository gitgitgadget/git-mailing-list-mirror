From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem merging
Date: Wed, 23 Nov 2005 15:49:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511231546330.8191@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
 <7v4q6483ms.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 15:53:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eevvs-0003u8-Ca
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVKWOtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVKWOtI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:49:08 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:25497 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750869AbVKWOtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:49:07 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BF8B413FD9C; Wed, 23 Nov 2005 15:49:06 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 960D19F3D0; Wed, 23 Nov 2005 15:49:06 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6ECBA9F3DC; Wed, 23 Nov 2005 15:49:06 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FFF913FDC1; Wed, 23 Nov 2005 15:49:06 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6483ms.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12630>

Hi,

On Tue, 22 Nov 2005, Junio C Hamano wrote:

> Sorry, but I am not a good enough cryptoanalyst to reverse SHA1
> hashes,

I think nobody is. Since there are infinitely many files having the same 
SHA1 (pigeon-hole principle), there probably are infinitely many of them 
which compile just fine (and therefore could be the original).

Now, I tried to find all of them, but I, too, failed ;-)

Ciao,
Dscho
