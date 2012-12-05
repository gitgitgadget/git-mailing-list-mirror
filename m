From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [ANNOUNCE] Git v1.8.1-rc0
Date: Wed, 05 Dec 2012 18:41:08 +0000
Message-ID: <50BF9544.7060401@ramsay1.demon.co.uk>
References: <7vip8iq1vs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 19:42:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgJvl-0001oG-25
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 19:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab2LESmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 13:42:32 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:57362 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab2LESmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 13:42:31 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 4EB3EA6434A;
	Wed,  5 Dec 2012 18:42:29 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 80578A6432E;	Wed,  5 Dec 2012 18:42:28 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;	Wed,  5 Dec 2012 18:42:27 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7vip8iq1vs.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211135>

Junio C Hamano wrote:
> A release candidate preview, Git v1.8.1-rc0, is now available for
> testing at the usual places.
> 
> This cycle has been a bit slow (perhaps because it had a major US
> holiday to slow people down) but we seem to have managed to apply
> reasonably large number of usability improvement changes, with a
> handful of new features.  There are several new and large-ish topics
> that are cooking in 'next', but I think we would better keep them
> cooking there without merging them to 'master' before the upcoming
> release to happen before the year end.  So as far as features goes,
> this preview release is pretty much *it*.
> 
> The release tarballs are found at:
> 
>     http://code.google.com/p/git-core/downloads/list
> 
> and their SHA-1 checksums are:
> 
> 39faaa15bc71f8eb52048e77ea564cecf78c7adf  git-1.8.1.rc0.tar.gz
> 2eeba24488337de02b58dc442258d58b79e2b8f4  git-htmldocs-1.8.1.rc0.tar.gz
> b28d1f8e8b9268b712b33fbdfb67dd6f14afb499  git-manpages-1.8.1.rc0.tar.gz
> 
> Also the following public repositories all have a copy of the v1.8.1-rc0
> tag and the master branch that the tag points at:
> 
>   url = git://repo.or.cz/alt-git.git
>   url = https://code.google.com/p/git-core/
>   url = git://git.sourceforge.jp/gitroot/git-core/git.git
>   url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
>   url = https://github.com/gitster/git
> 

I fetch git from 'git://git.kernel.org/pub/scm/git/git.git' which has
commit ee26a6e2 ("Git 1.8.1-rc0", 03-12-2012), but is missing the v1.8.1-rc0
tag. Is this just an oversight (the above list suggests not), or should I not
be using kernel.org?

ATB,
Ramsay Jones
