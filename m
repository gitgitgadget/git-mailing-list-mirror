From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: What's cooking in git.git (Jan 2016, #01; Mon, 4)
Date: Mon, 04 Jan 2016 21:32:27 -0700
Message-ID: <3613836.VnYUjhoksq@thunderbird>
References: <1718717.tR0GOgDc0N@thunderbird>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, Will Palmer <wmpalmer@gmail.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 05:32:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGJIL-0000zM-VC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 05:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbcAEEbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 23:31:55 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:54150 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbcAEEbx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 23:31:53 -0500
Received: from fed1rmimpo306 ([68.230.241.174]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20160105043152.YIDW331.fed1rmfepo101.cox.net@fed1rmimpo306>
          for <git@vger.kernel.org>; Mon, 4 Jan 2016 23:31:52 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo306 with cox
	id 24Xs1s0022tqoqC014Xs6H; Mon, 04 Jan 2016 23:31:52 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.568B4738.008C,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=LKq4tuq9 c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=7aQ_Q-yQQ-AA:10
 a=-lJPUGd8qEjaHvAxeCAA:9 a=CjuIK1q_8ugA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id EBBA4140912;
	Mon,  4 Jan 2016 21:32:27 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-2-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283346>

On Monday, January 04, 2016 07:36:05 PM Junio C Hamano wrote:
> Stephen & Linda Smith <ischis2@cox.net> writes:
> 
> > On Monday, January 04, 2016 03:44:33 PM Junio C Hamano wrote:
> >>  Becoming tired of waiting for a reroll.
> >>  ($gmane/271213).
> >>  Anybody wants to help rerolling this?  Otherwise will discard.
> >
> > <snip>
> >
> >> Becoming tired of waiting for a reroll.
> >>  Anybody wants to help rerolling this?  Otherwise will discard.
> >  > ($gmane/272180).
> >
> > What do you mean by rerolling this?  If you mean that you would
> > like someone to pick up the patch and try and get it though then I
> > don't mind helping.
> 
> More or less.  I do not mind if these topics disappeared, either,
> but we have spent review and discussion bandwidth for these
> unfinished topics and we may want to take them to the completion.
> 
> > For my education, how does this affect the sign-off proceedure?
> 
> Depending on the extent of changes from the original version, either
> you take the authorship (with comment in the log message saying that
> it is based on Such and Such's patches) or you still keep them as
> the author (with comment in the log message saying that you extended
> it in such and such way).  In either case, as long as their original
> remains in the resulting patch, you retain their Sign-off and then
> add your Sign-off at the end.
> 
> If you take the ideas from their series and rewrite everything from
> scratch, you would take the authorship, with comment in the log
> message saying that you took inspiration from Such and Such's
> patches, and have only your Sign-off.
> 
> 

If Will isn't interested in finishing these two patches I will pick them 
up [ ($gmane/271213), ($gmane/272180) ]

After that I will check look at some of the others for which you've 
asked for help.
