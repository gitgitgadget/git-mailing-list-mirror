From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Status of Thunderbird work
Date: Thu, 12 Feb 2009 18:16:17 +0100
Message-ID: <49945961.3040506@drmicha.warpmail.net>
References: <499449A0.4060002@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 18:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXfCB-0001nE-B6
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 18:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbZBLRQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 12:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbZBLRQY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 12:16:24 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52427 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703AbZBLRQX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 12:16:23 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A2ADF2929F3;
	Thu, 12 Feb 2009 12:16:22 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 12 Feb 2009 12:16:22 -0500
X-Sasl-enc: sZ6q9dD38TbacncNAj8e/dcLZVj9RD56chWaVj3iJBdR 1234458982
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D0CFC13071;
	Thu, 12 Feb 2009 12:16:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <499449A0.4060002@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109632>

Jeremy White venit, vidit, dixit 12.02.2009 17:09:
> Okay, I am now done with the due diligence I felt I had to do as
> penance for sending 14 wrapped and flowed patches to the wine-devel
> mailing list :-/.
> 
> To summarize, I have:
>   1.  Submitted a patch that,imho, improves the git documentation
>       on this subject.
>   2.  Revised a Mozillazine KB Entry to hopefully help others:
>       http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
>   3.  Submitted a patch that implements Ben's suggestion to use <pre>
>       and ctype of html to trick Thunderbird into doing the right thing.
>   4.  Submitted a patch to allow attach to be the default for git-format-patch.
> 
> I am not wedded to #3 and #4; in fact, I'm about to go revise the Wine Git
> instructions to make it clear that --attach is a last resort, and not a preferred
> choice (the current Wine Wiki makes --attach look more preferable than it really is).
> 
> If the html patch went in, I would use it, chortling with evil glee
> each time I did so.
> 
> Additionally, Dscho has written a Thunderbird extension to facilitate
> sending patches.  That doesn't fit my ideal flow (I'm actually quite fond
> of git-imap-send :-/), but Michael Gruber seemed interested and he and
> Dscho may take it somewhere.

Well, I said I will stick with git-send-mail, but since I'm a TB user
(and extension author) I'll help making this available (once I got my
QuoteCollapse for TB 3 out of the door).

> Finally, Michael also communicated in a private email that he may

Yeah, private, what could that mean, pryyy-vet? ;)

> consider some sort of rethink around git-send-email and git-imap-send,

OK, it wasn't really meant that private. I think an option restructuring
is in order.

> which sounded intriguing to me, but way past my fair penance.

It is not up to the sinner to decide upon his penance! The Wine-devil
shall say the final verdict...

Cheers,
Michael
