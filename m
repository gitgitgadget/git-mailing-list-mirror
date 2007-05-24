From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: fix git-config.xml generation
Date: Wed, 23 May 2007 21:22:57 -0700
Message-ID: <7vhcq2zw7y.fsf@assigned-by-dhcp.cox.net>
References: <3f80363f0705231516x7c6fa2daua33a708deaa7a10c@mail.gmail.com>
	<1179979802.3682.12.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jeffrey C. Ollie" <jeff@ocjtech.us>
X-From: git-owner@vger.kernel.org Thu May 24 06:23:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr4qw-0001a1-6a
	for gcvg-git@gmane.org; Thu, 24 May 2007 06:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759862AbXEXEXA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 00:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759918AbXEXEW7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 00:22:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58324 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759862AbXEXEW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 00:22:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524042258.WVCP2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 00:22:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2sNw1X00p1kojtg0000000; Thu, 24 May 2007 00:22:57 -0400
In-Reply-To: <1179979802.3682.12.camel@lt21223.campus.dmacc.edu> (Jeffrey
	C. Ollie's message of "Wed, 23 May 2007 23:10:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48217>

"Jeffrey C. Ollie" <jeff@ocjtech.us> writes:

> On Wed, 2007-05-23 at 18:16 -0400, James Bowes wrote:
>>
>> With asciidoc 8.1.0 and xmlto 0.0.18, git-config.xml failed to
>> validate. This patch just makes the asciidoc formatting for
>> branch.autosetupmerge the same as the other config options.
>
> I can confirm that this patch fixes the validation errors...

Yup, already pushed out about 7 hours ago.

Thanks.
