From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try to be consistent with capitalization in the documentation
Date: Wed, 01 Aug 2007 23:11:20 -0700
Message-ID: <7v7ioe1n5j.fsf@assigned-by-dhcp.cox.net>
References: <514D28CB-25F8-49B2-921E-8EFA60BE864C@gmail.com>
	<7vir7z5gx7.fsf@assigned-by-dhcp.cox.net>
	<588192970708011017q12c7a6d9s532c8aed086d3032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Steve Hoelzer" <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 08:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGTu9-0000u0-NI
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 08:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbXHBGLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 02:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbXHBGLX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 02:11:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63968 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXHBGLW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 02:11:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802061121.OPHG23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 02:11:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WuBM1X0021kojtg0000000; Thu, 02 Aug 2007 02:11:21 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54519>

"Steve Hoelzer" <shoelzer@gmail.com> writes:

> On 8/1/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Steve Hoelzer <shoelzer@gmail.com> writes:
>>
>> > Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
>> > ---
>> >
>> > Try to be consistent with capitalization in the documentation.
>>
>> It looks like that all the originals are trying to consistently
>> start with lowercase in an explanatory list.  Is this really
>> needed?
>
> The lists I changed were indeed all lowercase, but other lists in
> those files are all uppercase. I was aiming for consistency across all
> list items and all lists.

Fair enough.  However, your patch was seriously whitespace
mangled so I made matching edits by hand and committed the
result.  After I push out the result sometime tonight, please
double check the result.
