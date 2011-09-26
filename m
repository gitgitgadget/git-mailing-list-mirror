From: tactical <a5158017@nepwk.com>
Subject: Re: More Beginning Git Questions
Date: Mon, 26 Sep 2011 02:42:00 +0100
Message-ID: <ejxl2szn9dmh.olc9b5j8rv4h.dlg@40tude.net>
References: <4E7CCCA0.50909@gmail.com> <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net> <op.v2byz2p80aolir@keputer.lokaal> <1m2c90ds9e46c.7agk88pbgjl8$.dlg@40tude.net> <201109242259.p8OMxqIM026259@no.baka.org> <1wllqv48uqfjq.lt9yp4rbxugb.dlg@40tude.net> <m31uv4rc47.fsf@localhost.localdomain> <1rwoliveqwr1v.u3bsx5axtgsb$.dlg@40tude.net> <m3oby8pcfz.fsf@localhost.localdomain> <1ttmqsxtaj98i$.hv6s5shjeugr.dlg@40tude.net> <20110926003447.GG10955@localhost.localdomain> <1aec7c1qq0n56.sxybjnsj6ngr$.dlg@40tude.net> <CAH5451nk9FnqwhEe0SWxDc3TnLiTLnFgD6zB3jDehFZn6=qWvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 03:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R80D7-0002CG-FE
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 03:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab1IZBmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 21:42:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:50359 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab1IZBmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 21:42:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R80D1-0002Av-7S
	for git@vger.kernel.org; Mon, 26 Sep 2011 03:42:15 +0200
Received: from 31.64.26.194 ([31.64.26.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 03:42:15 +0200
Received: from a5158017 by 31.64.26.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 03:42:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 31.64.26.194
User-Agent: 40tude_Dialog/2.0.15.84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182088>

Andrew Ardill wrote:

> As any commits you make in a detached state are in the reflog until
> they expire (by default 30 days I think?) you have more than enough
> time to decide if you want to keep the work - which you can do very
> easily by assigning it a name. If the default time is not long enough,
> simply extend it in your config
>   git config gc.reflogExpire = 10000 years <- syntax might not be correct

Thanks for your post, but, again, my point is that Git does not support
anonymous branching as part of a normal workflow.  Having X days until
detonation is hardly part of a normal workflow (even if X can be changed,
as you suggest).

Anyway, this thread's really going off topic, so I'll try not to reply
again.
