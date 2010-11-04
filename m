From: Camille Moncelier <moncelier@devlife.org>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Thu, 4 Nov 2010 18:15:37 +0100
Message-ID: <20101104181537.5f866d42@cortex>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
	<20101104151637.076ac021@cortex>
	<AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Nick <oinksocket@letterboxes.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 18:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3QB-0002b9-0f
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab0KDRQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 13:16:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:58513 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab0KDRQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 13:16:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PE3Pz-0002PQ-4A
	for git@vger.kernel.org; Thu, 04 Nov 2010 18:16:07 +0100
Received: from arennes-258-1-39-42.w90-31.abo.wanadoo.fr ([90.31.190.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 18:16:07 +0100
Received: from moncelier by arennes-258-1-39-42.w90-31.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 18:16:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-258-1-39-42.w90-31.abo.wanadoo.fr
In-Reply-To: <AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160734>

On Thu, 4 Nov 2010 18:03:39 +0100
Christian Couder <christian.couder@gmail.com> wrote:

> Please reply not only to me but also to the list and add relevant
> people in Cc: like I did.
It replied to the list[1] and CC'ed you. I use claws mail + gmane NNTP
gateway. Maybe I did something wrong but it seems that the message has
been successfully delivered to the list.

[1] http://article.gmane.org/gmane.comp.version-control.git/160722 
> 
> Elijah Newren sent a patch series around September the 20th but I did
> not check to see if this series was merged into pu, next or master.
> And I don't know if it fixes your problem.
> Could you have a look?
I think I already took a look last week, and I think they were merged
in 1.7.1 or 1.7.2 although I'm not sure. I'll take another look. This
evening or maybe tomorrow.

> 
> Thanks,
> Christian.
