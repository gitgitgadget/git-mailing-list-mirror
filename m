From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add SubmittingPatches
Date: Tue, 16 Aug 2005 03:41:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160335420.1574@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org>
 <Pine.LNX.4.63.0508160252310.26927@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vk6imr7x0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 03:42:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4qS0-0003HN-Pl
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 03:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbVHPBlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 21:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVHPBlH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 21:41:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39910 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965069AbVHPBlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 21:41:05 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8A6FDE2835; Tue, 16 Aug 2005 03:41:04 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6B388B08A1; Tue, 16 Aug 2005 03:41:04 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 51D30ACB9C; Tue, 16 Aug 2005 03:41:04 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 37D98E2835; Tue, 16 Aug 2005 03:41:04 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6imr7x0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 15 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Maybe we should enhance git-applymbox to detect whitespace corruption in 
> > particular, and output the User-Agent header (or if that does not 
> > exist, the Message-ID header; thanks, pine) on error.
> 

Alternatively, SubmittingPatches could include a big fat CAVEAT, and a 
note that the submitter might want to send a single SP to herself, save 
the received mail and check that all is well, prior to sending the first 
patch. I mean, well, erm, it is sort of, uh, annoying, to send out a 
corrupt patch *speaksofyourstruly*.

Ciao,
Dscho
