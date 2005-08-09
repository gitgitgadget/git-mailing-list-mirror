From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Make git-rev-tree obsolete
Date: Tue, 9 Aug 2005 12:18:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508091218210.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 12:19:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2RC5-0008KS-8C
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 12:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVHIKSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 06:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVHIKSp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 06:18:45 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31198 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932504AbVHIKSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 06:18:44 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E74F2E32D6; Tue,  9 Aug 2005 12:18:43 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CA081AC8CC; Tue,  9 Aug 2005 12:18:43 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AD2E3AC887; Tue,  9 Aug 2005 12:18:43 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97042E32D6; Tue,  9 Aug 2005 12:18:43 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Junio remarked that Jeff's git-changes-script still uses git-rev-tree, and 
> > therefore it should not be removed. This patch changes git-changes-script 
> > over to git-rev-list:
> 
> Just to make things clear, "Junio remarked" that Cogito also
> seems to use it as well, so git-rev-tree is not going away.

Oops! My bad.
