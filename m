From: "Bryan O'Donoghue" <typedef@eircom.net>
Subject: Re: cogito/git usage question
Date: Mon, 29 Aug 2005 17:23:55 +0100
Message-ID: <4313369B.5060508@eircom.net>
References: <4312E74D.5020203@eircom.net> <Pine.LNX.4.58.0508290804570.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 29 18:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9mLn-0004fU-Eb
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 18:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVH2QRt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 12:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVH2QRt
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 12:17:49 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:48802 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1751319AbVH2QRr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 12:17:47 -0400
Received: from eurodubx.europlex.local (mail.europlex.ie [83.141.76.10])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id j7TGHkgQ008070
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 09:17:47 -0700
Received: from [10.100.10.207] ([10.100.10.207]) by eurodubx.europlex.local with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 29 Aug 2005 17:14:07 +0100
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508290804570.3243@g5.osdl.org>
X-OriginalArrivalTime: 29 Aug 2005 16:14:07.0296 (UTC) FILETIME=[AE941C00:01C5ACB4]
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7904>

Linus Torvalds wrote:

<snip>

> 	git checkout -b bryan-mm v2.6.13-rc6
> 
> (mental footnote: pronounce it as "git checkout new branch 'bryan-mm' at
> v2.6.13-rc3").
> 
> [ You can also do the exact same thing by
> 
> 	git branch bryan-mm v2.6.13-rc6
> 	git checkout bryan-mm

<snip>

> And then you can switch between the different branches with just a simple
> 
> 	git checkout <branch>

Having re-read your email, six times or so, I believe those two
incantations finally make sense.

If I'm understanding, I update to a given git repository, branch locally
based on tags and then I can checkout a branch locally, to make that the
active branch.

Thank you for the input !


Best,
Bryan

-- 
"Fiery the angels fell. Deep thunder rolled around their shores, burning
with the fires of Orc." -- Roy Batty, Blade Runner.
