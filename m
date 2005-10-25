From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: latest stg/git commandline completions code
Date: Tue, 25 Oct 2005 16:18:43 +0100
Message-ID: <tnxwtk1lj58.fsf@arm.com>
References: <Pine.LNX.4.60.0510251222510.8565@mundungus.clifford.ac>
	<200510251642.46169.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Clifford <benc@hawaga.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 17:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUQZi-0002On-UN
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 17:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVJYPSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 11:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVJYPSv
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 11:18:51 -0400
Received: from fw-nat.cambridge.arm.com ([193.131.176.54]:42048 "EHLO
	ZIPPY.Emea.Arm.com") by vger.kernel.org with ESMTP id S932177AbVJYPSv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 11:18:51 -0400
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 25 Oct 2005 16:18:44 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 25 Oct 2005 15:18:44.0767 (UTC) FILETIME=[63BE2AF0:01C5D977]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10590>

Blaisorblade <blaisorblade@yahoo.it> wrote:
> I'm using stgit on the Linux kernel so when on a command I don't have tab 
> completion I add the needed one (having the time and feeling to do
> it).

You can have a look at the tlacontrib project scripts (I can forward
them to you since you would need tla/baz to clone/checkout the project
and this procedure is a combination of 'tag' and 'get' commands). They
automatically generate the commands together with the options and are
later used in completion.

Of course, your approach would work as well but it requires more
maintance.

>> if so, do you have any more formalised distribution process (like a
>> git repo!) rather than grabbing code out of email list postings? I
>> can't seem to find much on google...
>
> Well, Catalin's TODO included "bash completions", so I assume the
> thing could be merged by him. Anyway, I'm attaching the current
> version.

When you think it is ready, I'm happy to include it (though I would
prefer a more dynamic approach like the tla one but since I don't have
time for it I'll just use yours).

Thanks.

-- 
Catalin
