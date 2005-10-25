From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch/upload: Fix corner case with few revs
Date: Tue, 25 Oct 2005 22:59:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510252259001.15756@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510251730200.12176@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vll0hfqdb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 23:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUVtt-0003WB-4G
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVJYU77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 16:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVJYU77
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 16:59:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23686 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932379AbVJYU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 16:59:58 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4E24913F1D1; Tue, 25 Oct 2005 22:59:54 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 32240B0D40; Tue, 25 Oct 2005 22:59:54 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0EFE5B0CF8; Tue, 25 Oct 2005 22:59:54 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B65F013F1D1; Tue, 25 Oct 2005 22:59:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll0hfqdb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10616>

Hi,

On Tue, 25 Oct 2005, Junio C Hamano wrote:

> I've already pushed your initial set out to "master", but I
> suspect we may be better of if I recall them and let it simmer a
> bit longer in the proposed updates branch, and defer them post
> 0.99.9.  What do you think?

Yes, please. Sorry for the problems.

Ciao,
Dscho
