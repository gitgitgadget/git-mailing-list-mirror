From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved hint on how to set identity
Date: Mon, 13 Aug 2007 22:22:34 -0700
Message-ID: <7vps1qellx.fsf@assigned-by-dhcp.cox.net>
References: <1187042750257-git-send-email-prohaska@zib.de>
	<7vbqdbf1m2.fsf@assigned-by-dhcp.cox.net>
	<06A460CB-BF06-4D9D-9219-4D4EC656EF9B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:22:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKorc-0006lt-0j
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 07:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937100AbXHNFWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 01:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935498AbXHNFWh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 01:22:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52140 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933663AbXHNFWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 01:22:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814052236.NHIK325.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 14 Aug 2007 01:22:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bhNa1X0151kojtg0000000; Tue, 14 Aug 2007 01:22:35 -0400
In-Reply-To: <06A460CB-BF06-4D9D-9219-4D4EC656EF9B@zib.de> (Steffen Prohaska's
	message of "Tue, 14 Aug 2007 07:05:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55808>

Steffen Prohaska <prohaska@zib.de> writes:

> maybe... but my feeling is that the majority of people has only
> a single identity. Having multiple identities is, in my opinion,
> advanced usage, and should be mentioned after the common case.

My point was that there is nothing that backs up that your
feeling of the majority is correct.  I personally do not have
much preference either way and I certainly do not claim that I
have better feel of what the majority wants than you do.  I just
want to see something more concrete than "I think majority wants
this" to change what has been there for some time.

> I remember when I started, I didn't immediately recognize that
> I need to set my identity (or how to do it). Therefore I ended
> up with different identities on different machines,...

You might want to search the mailing list archive for message
from Linus why he thinks having different per machine identity
for committer field is a good thing.  People have different
taste and needs.
