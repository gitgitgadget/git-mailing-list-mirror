From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Mon, 3 Nov 2008 08:20:18 -0800
Message-ID: <20081103162017.GL15463@spearce.org>
References: <20081101010011.GG14786@spearce.org> <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm> <20081101010824.GE29036@artemis.corp> <alpine.LFD.2.00.0810312121000.13034@xanadu.home> <20081101014336.GI14786@spearce.org> <alpine.LFD.2.00.0810312150200.13034@xanadu.home> <20081101225714.GD15463@spearce.org> <d411cc4a0811011726h1fb1ad0ct5c37af753940f4a4@mail.gmail.com> <d411cc4a0811011807g229f8becs9f411d6e19fb6c12@mail.gmail.com> <20081102050917.GA26634@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 17:21:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx2BK-0000O1-Em
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbYKCQUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbYKCQUU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:20:20 -0500
Received: from george.spearce.org ([209.20.77.23]:54864 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028AbYKCQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:20:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1B1943835F; Mon,  3 Nov 2008 16:20:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081102050917.GA26634@linode.davidb.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99960>

David Brown <git@davidb.org> wrote:
> On Sat, Nov 01, 2008 at 06:07:04PM -0700, Scott Chacon wrote:
>
>> Think about trying to incorporate this into something proprietary,
>> Shawn - how much of a pain is it going to be to get that license
>> reviewed in Google?  However, LGPL I'm sure there is already a
>> reviewed policy.  Now, since that may be a pain, time that Shawn could
>> have been spending being paid to work on the library is lost because
>> they can't use it, or it takes weeks/months to review it.  That's my
>> concern.
>
> The gcc exception license should have been reviewed by anyone who has
> ever build anything proprietary out of gcc.

Indeed.  And gcc is a *very* popular compiler on Linux distributions.
A lot of commerical software is built under it, and distributed in
binary-only form.  Those companies have already done the legal review
they felt necessary before shipping (and selling) that software.

-- 
Shawn.
