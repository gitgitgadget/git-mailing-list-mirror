From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Fri, 12 Aug 2005 18:00:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121800050.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 18:02:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3bxl-0002qt-4F
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVHLQAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVHLQAu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:00:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62369 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751209AbVHLQAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:00:49 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 74011E2592; Fri, 12 Aug 2005 18:00:48 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5CCA29CC79; Fri, 12 Aug 2005 18:00:48 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E68D9CB95; Fri, 12 Aug 2005 18:00:48 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 187B8E2592; Fri, 12 Aug 2005 18:00:48 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

hI,

On Fri, 12 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > For consistency reasons, the names of all scripts should end in "-script".
> >
> > This may be a bit controversial (people might find it unnecessary). 
> > Subject to discussion.
> 
> I have never liked the original -script name convention.

Okay. I'm all for dropping the "-script" postfix.

Ciao,
Dscho
