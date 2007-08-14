From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved hint on how to set identity
Date: Mon, 13 Aug 2007 23:32:34 -0700
Message-ID: <7v8x8eeid9.fsf@assigned-by-dhcp.cox.net>
References: <1187042750257-git-send-email-prohaska@zib.de>
	<7vbqdbf1m2.fsf@assigned-by-dhcp.cox.net>
	<06A460CB-BF06-4D9D-9219-4D4EC656EF9B@zib.de>
	<7vps1qellx.fsf@assigned-by-dhcp.cox.net>
	<3ED86523-8FEA-4141-BA8A-14FAFD7CD93E@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 08:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKpxI-0004c4-RN
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 08:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbXHNGch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 02:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbXHNGch
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 02:32:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47670 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbXHNGcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 02:32:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814063235.MYOQ21830.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 14 Aug 2007 02:32:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id biYa1X00k1kojtg0000000; Tue, 14 Aug 2007 02:32:35 -0400
In-Reply-To: <3ED86523-8FEA-4141-BA8A-14FAFD7CD93E@zib.de> (Steffen Prohaska's
	message of "Tue, 14 Aug 2007 07:54:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55812>

Steffen Prohaska <prohaska@zib.de> writes:

> ... I think everyone should have a
> default identity. That is what my patch does: tell the user to
> setup a default account identity first. Per repository identities
> can be set up later.

Once you put it that way, it makes quite a lot of sense,
although "should" might probably be bit too strong a word.

And it matches how Documentation/tutorial.txt starts out, to
make the suggestions consistent.

Will apply.
