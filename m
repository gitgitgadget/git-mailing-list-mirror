From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Thu, 05 Jul 2007 09:47:38 -0700
Message-ID: <7vodiqdcgl.fsf@assigned-by-dhcp.cox.net>
References: <200707042324.l64NOp8I019289@mi0.bluebottle.com>
	<7vbqere732.fsf@assigned-by-dhcp.cox.net>
	<20070705115825.GA13654@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Git Mailing List <git@vger.kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:47:44 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6UUZ-0002mM-Ni
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411AbXGEQrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Jul 2007 12:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756705AbXGEQrl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:47:41 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41366 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbXGEQrk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2007 12:47:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705164741.RYMG11062.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 12:47:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ksnf1X00L1kojtg0000000; Thu, 05 Jul 2007 12:47:40 -0400
In-Reply-To: <20070705115825.GA13654@informatik.uni-freiburg.de> (Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig's?= message of "Thu, 5 Jul 2007 13:58:25
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51685>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> I didn't test it yet, but it sounds good.  I will apply your patch an=
d
> work a while with it.  But I think if someone adds documentation, I w=
ill
> give my Ack. :-)
>
> BTW: I prefer help over usage, but if it nanako prefers usage, why no=
t
> both?

We could do that, I guess.  Nana?
