From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: make search form generate pathinfo-style URLs
Date: Mon, 02 Jul 2007 16:11:23 -0700
Message-ID: <7vfy46wgdg.fsf@assigned-by-dhcp.cox.net>
References: <1183057027.6108.4.camel@mattlaptop2>
	<1183402981.2664.10.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:11:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3P-00086c-Dh
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992AbXGBXL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757016AbXGBXL3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:29 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50303 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940AbXGBXL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231127.VMWV1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBS1X00h1kojtg0000000; Mon, 02 Jul 2007 19:11:27 -0400
cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51422>

Matt McCutchen <hashproduct@gmail.com> writes:

> I sent this patch four days ago but no one has commented or done
> anything about it.  Please clue me in: is this typical, or did I do
> something wrong or do I need to do something else?

Yes, it sometimes happens to patches to some areas.  No, you did
not do anything wrong as far as I can see.  Yes, sending this
kind of reminder out is exactly what is needed.

I have three recent patches from you on gitweb in my patch
queue.

  Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple
          formats
  Date: Thu, 28 Jun 2007 14:02:13 -0400
  Message-ID: <1183053733.6108.0.camel@mattlaptop2>

  Subject: [PATCH] gitweb: make search form generate pathinfo-style URLs
  Date: Thu, 28 Jun 2007 14:57:07 -0400
  Message-ID: <1183057027.6108.4.camel@mattlaptop2>

  Subject: [PATCH] gitweb: make "No commits" in project list gray, not bold
          green
  Date: Thu, 28 Jun 2007 18:15:22 -0400
  Message-ID: <1183068922.6108.8.camel@mattlaptop2>

There are people whom I consider "gitweb folks", who are more
familiar with, and more importantly who are more interested in,
gitweb than I am.  Having good "subsystem people" makes gitweb a
lower-priority area to myself, and for these patches it made
even so that nobody commented on them.

I should have asked Ack/Nack/Comments from gitweb folks much
earlier, but was a bit too loaded with the day job.  Sorry about
that.

So, gitweb folks, what do you think about these patches?
