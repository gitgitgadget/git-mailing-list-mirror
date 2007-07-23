From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: Add unlisted option
Date: Mon, 23 Jul 2007 01:54:13 -0700
Message-ID: <7vwswrlcui.fsf@assigned-by-dhcp.cox.net>
References: <87sl7fmyca.wl@mail2.atmark-techno.com>
	<20070723070308.GH32566@spearce.org>
	<7vabtnmusm.fsf@assigned-by-dhcp.cox.net>
	<20070723074736.GJ32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICtgU-0008UO-Ao
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 10:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761239AbXGWIyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 04:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763281AbXGWIyR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 04:54:17 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45991 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763024AbXGWIyP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 04:54:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723085414.PRJF1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Jul 2007 04:54:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SwuD1X00K1kojtg0000000; Mon, 23 Jul 2007 04:54:14 -0400
In-Reply-To: <20070723074736.GJ32566@spearce.org> (Shawn O. Pearce's message
	of "Mon, 23 Jul 2007 03:47:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53413>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> I was actually going to suggest removing these options, that
>> were primarily meant for debugging and tweaking while we figure
>> out what the optimum default should be.  Do you think they are
>> worth keeping?
>
> Yea, I do.  I'd like to keep them in the code as sometimes I do
> look at their output.  I'll even help maintain them, because they
> change oh so often.  ;-)
>
> But if you really want them gone, I won't stop you.

Nah, I already noticed your Ack and inferred that you would want
to keep them.  Haven't applied the patches yet, though.
