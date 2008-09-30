From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git/spearce.git (Sep 2008, #04; Mon, 22)
Date: Tue, 30 Sep 2008 09:52:34 +0200
Message-ID: <48E1DAC2.7070304@drmicha.warpmail.net>
References: <20080929184709.GB21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 09:54:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kka3I-0004kN-9m
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 09:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbYI3Hwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 03:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbYI3Hwh
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 03:52:37 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58299 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751704AbYI3Hwh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 03:52:37 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5C319170B2E;
	Tue, 30 Sep 2008 03:52:36 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 30 Sep 2008 03:52:36 -0400
X-Sasl-enc: JvAnZcsY/u0ouiCciY7xVjcssK6EVM4znCSJUr/Kr0br 1222761156
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CABDA25944;
	Tue, 30 Sep 2008 03:52:35 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <20080929184709.GB21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97074>

Shawn O. Pearce venit, vidit, dixit 29.09.2008 20:47:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.

...

> * mg/maint-remote-fix (Mon Sep 22 10:57:51 2008 +0200) 1 commit
>  + make "git remote" report multiple URLs
> 
> (Tip at 7d20e21)
> 
> * bc/maint-diff-hunk-header-fix (Sat Sep 20 15:30:12 2008 -0700) 5 commits
>  + diff hunk pattern: fix misconverted "\{" tex macro introducers
>  + diff: use extended regexp to find hunk headers
>  + diff.*.xfuncname which uses "extended" regex's for hunk header
>    selection
>  + diff.c: associate a flag with each pattern and use it for
>    compiling regex
>  + diff.c: return pattern entry pointer rather than just the hunk
>    header pattern
> 
> (Tip at 96d1a8e)
> 
> The above two are ready for 'maint'.

They are already in maint, as per "What's in..." and the repo.

Cheers,
Michael
