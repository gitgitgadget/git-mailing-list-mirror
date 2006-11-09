X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 18:54:35 -0800
Message-ID: <7vslgtpbx0.fsf@assigned-by-dhcp.cox.net>
References: <dlang@digitalinsight.com>
	<200611090228.kA92SMqw006666@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 03:00:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611090228.kA92SMqw006666@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Wed, 08 Nov 2006 23:28:22 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31176>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi040-0001zA-IM for gcvg-git@gmane.org; Thu, 09 Nov
 2006 03:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754302AbWKICyh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 21:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbWKICyh
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 21:54:37 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13017 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1754302AbWKICyg
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 21:54:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109025436.FQUJ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 21:54:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kSuh1V00X1kojtg0000000; Wed, 08 Nov 2006
 21:54:42 -0500
To: "Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl> writes:

> David Lang <dlang@digitalinsight.com> wrote:
>> On Tue, 7 Nov 2006, Junio C Hamano wrote:
>> 
>> > [pu]
>> >
>> >  Johannes's shallow clone work now should rebase cleanly on top
>> >  of 'master' although I haven't done so yet.  As he said
>> >  himself the series is waiting for people who have needs for
>> >  such a feature to raise hands.
>> 
>> I haven't been watching this recently, but if this is what I
>> understand it to be (the ability to get a partial repository from
>> upstream and work normally from there with the result of data-mineing
>> tools sometimes reporting 'that's part of the truncated history' if
>> they hit the cutoff) consider my hand raised.
>
> +1

What does that plus one mean?  I do not know where people picked
up this annoying plus or minus one business, but could you all
stop that?

If you are volunteering to help debugging and feeding bugfixes
that is very much welcome and appreciated.

Thanks.
