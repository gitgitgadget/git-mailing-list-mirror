From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 21:30:54 -0700
Message-ID: <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	<fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	<a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	<7vps2fc196.fsf@assigned-by-dhcp.cox.net>
	<20070726031838.GO32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 06:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDv07-0003Aa-IG
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 06:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXGZEa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 00:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXGZEa4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 00:30:56 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52351 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXGZEaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 00:30:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726043053.DMTZ1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 00:30:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U4Wt1X00N1kojtg0000000; Thu, 26 Jul 2007 00:30:54 -0400
In-Reply-To: <20070726031838.GO32566@spearce.org> (Shawn O. Pearce's message
	of "Wed, 25 Jul 2007 23:18:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53762>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I do know the best way to uninstall dependencies on Windows is to
> boot a live Linux CD and `mkfs /dev/hda1`.  But as far as installing
> things go you pray that your vendor has packaged everything you need
> in their shiny click-through installer thing, and if they haven't,
> you cry wolf and switch to another vendor.

If that is the case, "Git for Windows" probably should package
MSYS as part of it, I would think, to match the expectation of
the users there.  I know two Johannes'es and Han-Wen spent quite
a lot of effort on Windows port and packaging, but perhaps that
little (well, I should not be judging if that is a little or
huge, as I do not do Windows) finishing touch would make Windows
users much happier?
