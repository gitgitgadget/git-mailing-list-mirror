From: Luc Van Oostenryck <lkml@looxix.net>
Subject: Re: new features in gitk
Date: Tue, 28 Jun 2005 22:24:45 +0200
Message-ID: <42C1B20D.2000502@looxix.net>
References: <17088.31798.17291.605567@cargo.ozlabs.ibm.com>	<42C08265.2050209@looxix.net> <17088.36232.479492.643878@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 22:19:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnMXj-0001sa-Ri
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVF1UYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 16:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVF1UYU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 16:24:20 -0400
Received: from smtp3.mail.be.easynet.net ([212.100.160.66]:24246 "EHLO
	smtp3.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id S261356AbVF1UVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 16:21:08 -0400
Received: from [81.188.80.222] (helo=ralph05.pc.home)
	by smtp3.mail.be.easynet.net with esmtp (Exim 4.51)
	id 1DnMZs-0005nQ-JV; Tue, 28 Jun 2005 22:21:04 +0200
Received: from localhost ([127.0.0.1] helo=looxix.net)
	by ralph05.pc.home with esmtp (Exim 4.10)
	id 1DnMdS-0005b3-00; Tue, 28 Jun 2005 22:24:46 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17088.36232.479492.643878@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras wrote:
> Luc Van Oostenryck writes:
> 
> 
>>I find the patch generation very usefull (when I've seen the tool a few days ago, I've said to myself:
>>"what a wonderfull tool, if only I could create a patch from this")
>>but it doesn't work for me (the first three entries stay always in grey, only the last one "Create tag" is in black).
>>I'm missing something ?
> 
> 
> The diffs and patches are between the selected commit (one that you
> clicked on with the left button and which is shown with a grey
> background) and the commit where you click the right button.  That was
> the best way I could think of to indicate which were the two commits
> to diff.  If you (or anyone) has a better suggestion, let me know.
> 
> Paul.

OK I see it now, it works nicely.
I didn't found the tric yesterday because I was thinking: one commit -> one patch,
but it's probably more usefull like it is now.

Thanks.
