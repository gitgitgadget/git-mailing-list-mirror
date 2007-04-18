From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 19:43:05 +0200
Message-ID: <vpqejmhy3x2.fsf@bauges.imag.fr>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
	<17958.19499.813637.324723@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 19:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEBj-0000i0-7a
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 19:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992942AbXDRRnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 13:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992943AbXDRRnO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 13:43:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:46295 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992942AbXDRRnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 13:43:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l3IHh51K022493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Apr 2007 19:43:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HeEBN-0004RO-Sh; Wed, 18 Apr 2007 19:43:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HeEBN-0002ye-QO; Wed, 18 Apr 2007 19:43:05 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <17958.19499.813637.324723@lisa.zopyra.com> (Bill Lear's message of "Wed\, 18 Apr 2007 11\:49\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 18 Apr 2007 19:43:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44918>

Bill Lear <rael@zopyra.com> writes:

> On Wednesday, April 18, 2007 at 09:07:55 (-0700) Linus Torvalds writes:
>>...
>>Actually, at this stage, I really think cogito just *complicates* git 
>>usage. ...
>
> As a relative newbie to git, I agree.  At our company, we did not even
> seriously consider using cogito.  Just easier to jump right in to the
> frosty waters.

Same for me.

As a beginner, I went to http://git.or.cz/, clicked "crash courses",
and since I didn't find "git from scratch", I clicked "git for CVS
users" (I know CVS, but haven't used it for a long time, I'm mostly a
bzr user converted from GNU Arch).

There, the commands are not "git something", but "cg something". Well,
not always, at least. Indeed, there's still a "git blame", a reference
to "git-rev-parse manpage".

Then, I can't even find it in the tutorial, but somewhere, it should
be mentionned to say who I am in ~/.gitconfig.

So, Cogito can not be seen as "a revision control, using git as a
back-end". It's definitely an additional layer, not hiding all of git.

And then, comming to the mailing list, and looking at other websites,
I can see git commands here and there. I started to manage branches
using cogito, tried git commands related to branches, and realized
that they used a totally different interface.

So, cogito has probably been of a real use at the beginning, where git
was said to be almost unuseable without anything else (I didn't try
git at that time), but I don't think it's the case anymore.

-- 
Matthieu
