From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: Make "save" the default operation again
Date: Mon, 02 Jul 2007 16:11:22 -0700
Message-ID: <7vlkdywgdh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site>
	<200707010533.l615XiH6006728@mi1.bluebottle.com>
	<20070701080757.GA6093@coredump.intra.peff.net>
	<7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net>
	<20070702041046.GB17384@coredump.intra.peff.net>
	<Pine.LNX.4.64.0707021129540.4438@racer.site>
	<Pine.LNX.4.64.0707021141280.4438@racer.site>
	<20070702110014.GA6490@sigill.intra.peff.net>
	<Pine.LNX.4.64.0707021215120.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:11:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5V3O-00086c-Uu
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbXGBXL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756992AbXGBXL0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:11:26 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38881 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990AbXGBXLY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:11:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702231124.KAQZ17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Jul 2007 19:11:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JnBN1X00W1kojtg0000000; Mon, 02 Jul 2007 19:11:23 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51426>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> On Mon, Jul 02, 2007 at 11:44:29AM +0100, Johannes Schindelin wrote:
>> 
>> > So, neither "list" nor "apply" are ase often used in practice as 
>> > "save". The manpage already reflects that, so change the script to the 
>> > better.
>> 
>> I have to admit that I don't really care all that much, so I'll let you 
>> guys duke it out.
>
> I do have to admit that I do care. Especially since my alias is no longer 
> working (having the same name as a git program).

Ok, two votes from long-timer Dscho and original poster Nana are
sufficient for me to change my mind.

Thanks.
