From: Christian Biesinger <cbiesinger@web.de>
Subject: Re: [PATCH] Ignore commits for which cvsps can't identify a branch
Date: Sat, 10 Jun 2006 21:45:46 +0200
Message-ID: <448B216A.6010801@web.de>
References: <200602102102.k1AL2Xkd010415@biesi.no-ip.org> <20060610192457.GA6620@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 21:46:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp9PI-0007tt-5H
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 21:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWFJTpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 15:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWFJTpv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 15:45:51 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:56811 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP
	id S1161007AbWFJTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 15:45:51 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id D9E171E033F;
	Sat, 10 Jun 2006 21:45:49 +0200 (CEST)
Received: from [85.124.19.211] (helo=[192.168.1.4])
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.107 #114)
	id 1Fp9P3-0003tn-00; Sat, 10 Jun 2006 21:45:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060610 SeaMonkey/1.5a
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060610192457.GA6620@nowhere.earth>
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21618>

Yann Dirson wrote:
> I have seen such CVSPS_NO_BRANCH things with "cvsps -u", and could
> always get rid of it using "cvspx -x".  Christian, did you try to run
> "cvsps -x" to be sure the cache is valid, and did it get rid of the
> CVSPS_NO_BRANCH ?  It could help if you could make a cvsps cache
> available, which exhibits the problem.

I'm pretty sure that I did use -x and didn't have a cache. Unfortunately 
I don't have anything about that cvsps setup available anymore.
