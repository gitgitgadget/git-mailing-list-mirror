From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Users of git-check-files?
Date: Thu, 4 Aug 2005 23:10:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508042309380.24861@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0508021942500.3341@g5.osdl.org> <7vvf2nk0h7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0508030808530.3341@g5.osdl.org> <7vwtn1wh8u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 23:22:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0nAE-0007IX-Nk
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 23:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVHDVRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVHDVMR
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 17:12:17 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32998 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262701AbVHDVK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 17:10:57 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D9FBDE23CF; Thu,  4 Aug 2005 23:10:56 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BD344B347E; Thu,  4 Aug 2005 23:10:56 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A1DC6A96AB; Thu,  4 Aug 2005 23:10:56 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49B46E23CF; Thu,  4 Aug 2005 23:10:56 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtn1wh8u.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Junio C Hamano wrote:

> I will keep git-rev-list; used in Jeff's git-changes-script and
> some parts of Cogito as well.

According to my grep's, these files use git-rev-list:

git-bisect-script
git-cherry
git-format-patch-script
git-log-script
git-repack-script
git-whatchanged
gitk
send-pack.c
upload-pack.c

So better keep it :-)

Ciao,
Dscho
