From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Submodule merge support
Date: Mon, 21 May 2007 00:55:08 -0700
Message-ID: <7v646mfw6b.fsf@assigned-by-dhcp.cox.net>
References: <20070520154227.GG5412@admingilde.org>
	<20070521062005.GK3141@spearce.org>
	<20070521073253.GU5412@admingilde.org>
	<20070521073758.GP3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 21 09:55:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2ja-0003e7-8Z
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXEUHzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXEUHzK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:55:10 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:55064 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbXEUHzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:55:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521075510.ZCNM19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 21 May 2007 03:55:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1jv81X0061kojtg0000000; Mon, 21 May 2007 03:55:08 -0400
In-Reply-To: <20070521073758.GP3141@spearce.org> (Shawn O. Pearce's message of
	"Mon, 21 May 2007 03:37:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47990>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Its a very old Sun C compiler, and it doesn't like structs to be
> initialized that way.  Yes, newer compilers are better, and gcc is
> also better, but I'm unable to get our UNIX admins to actually do
> their job and keep systems usable by the users.
>
> /me starts to wonder why he continues with this day-job thing...

Time for a "git company" ;-)?
