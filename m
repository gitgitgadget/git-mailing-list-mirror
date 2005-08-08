From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Tue, 9 Aug 2005 01:42:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <1123306575.7588.17.camel@dv.roinet.com> <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
 <20050808231036.GA22778@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 01:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2HG4-0000HW-EH
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 01:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVHHXmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 19:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVHHXmN
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 19:42:13 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56208 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932361AbVHHXmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 19:42:13 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4BBADD85D6; Tue,  9 Aug 2005 01:42:12 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 305A2AC887; Tue,  9 Aug 2005 01:42:12 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 138AAA7D2B; Tue,  9 Aug 2005 01:42:12 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8CE68D85D6; Tue,  9 Aug 2005 01:42:11 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050808231036.GA22778@mythryan2.michonline.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Ryan Anderson wrote:

> [...]
>
> We should discuss (or just do) a reorganization of how we lay out the
> source tree.
>
> [...]

I, for one, like the layout. There are not yet enough files to merit a 
hierarchy, and what's more: I can add the source-directory to my PATH and 
be done by compiling every time I pull.

But you're right in any case, it is post 1.0 discussion material.

Ciao,
Dscho
