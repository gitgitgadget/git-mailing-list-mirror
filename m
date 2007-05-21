From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cross-reference the manpages for git-name-rev and git-describe
Date: Mon, 21 May 2007 00:46:29 -0700
Message-ID: <7viramfwkq.fsf@assigned-by-dhcp.cox.net>
References: <20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
	<A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
	<vpq8xbkoir8.fsf@bauges.imag.fr>
	<839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com>
	<7vfy5sy91f.fsf@assigned-by-dhcp.cox.net>
	<vpq7ir3658t.fsf_-_@bauges.imag.fr>
	<7vsl9rmkm0.fsf@assigned-by-dhcp.cox.net>
	<20070521072025.GO3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 21 09:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2bG-0002FL-9s
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXEUHqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXEUHqb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:46:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54108 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXEUHqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:46:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521074631.ZBQM19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 21 May 2007 03:46:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1jmV1X00B1kojtg0000000; Mon, 21 May 2007 03:46:30 -0400
In-Reply-To: <20070521072025.GO3141@spearce.org> (Shawn O. Pearce's message of
	"Mon, 21 May 2007 03:20:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47985>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> wouldn't this be useful?
>> 
>> $ git-describe --contains --tags 1b600e659
>> v1.5.0-rc3~34
>
> Like this?  ;-)

Yeah, something like that.

Now we need to make sure that the name of the option --contains
is sane, I guess.
