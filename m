From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 23:18:38 -0400
Message-ID: <20070726031838.GO32566@spearce.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com> <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com> <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 05:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDtsF-0005j7-JR
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 05:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbXGZDSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 23:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbXGZDSo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 23:18:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38496 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbXGZDSn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 23:18:43 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDtrx-0005mF-Hs; Wed, 25 Jul 2007 23:18:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 973C1230809; Wed, 25 Jul 2007 23:18:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53754>

Junio C Hamano <gitster@pobox.com> wrote:
> "Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:
> 
> > On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> >> What features is mingw port missing?
> > Well, 'git commit' from a regular cmd prompt does not work.
> > IMHO, That's a pretty serious omission  :-).
> 
> I was under the impression that is only because you do not have
> MSYS installed.  Doesn't Windows people have automated way to
> pull and install other packages on the dependency?

Package management?  On Windows?  Surely you aren't talking about
that silly "Add/Remove Programs" control panel that just destroys
your machine.

I do know the best way to uninstall dependencies on Windows is to
boot a live Linux CD and `mkfs /dev/hda1`.  But as far as installing
things go you pray that your vendor has packaged everything you need
in their shiny click-through installer thing, and if they haven't,
you cry wolf and switch to another vendor.

-- 
Shawn.
