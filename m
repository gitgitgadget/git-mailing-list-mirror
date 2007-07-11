From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test suite fails if sh != bash || tar != GNU tar
Date: Wed, 11 Jul 2007 14:43:16 -0700
Message-ID: <7v7ip639cb.fsf@assigned-by-dhcp.cox.net>
References: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
	<Pine.LNX.4.64.0707110347580.4047@racer.site>
	<alpine.LFD.0.999.0707102020020.3412@woody.linux-foundation.org>
	<7154c5c60707102108g59280301pa5c3c0dc3911753d@mail.gmail.com>
	<Pine.LNX.4.64.0707111209160.4516@racer.site>
	<7v7ip64opa.fsf@assigned-by-dhcp.cox.net>
	<7154c5c60707111433r64ae5109o314778655cbc017e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "David Frech" <david@nimblemachines.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:43:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jxx-0002x4-6m
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbXGKVnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754977AbXGKVnS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:43:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36439 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbXGKVnR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:43:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711214317.HPKA1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:43:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMjF1X00K1kojtg0000000; Wed, 11 Jul 2007 17:43:16 -0400
In-Reply-To: <7154c5c60707111433r64ae5109o314778655cbc017e@mail.gmail.com>
	(David Frech's message of "Wed, 11 Jul 2007 14:33:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52213>

"David Frech" <david@nimblemachines.com> writes:

> One issue is that my server is on dynamic IP, and my lame ISP (the
> local telco) doesn't give me a proper SMTP relay - they want us to
> send our mail via HTTP to MSN! Completely lame.
>
> So sending mail can be an issue, if the receiver blocks mail from dynamic IPs.

I think I heard gmail has incoming SMTP for its subscribers, and
I would not be surprised if other free e-mail providers have the
same.  Perhaps you can use one of them for this purpose?
