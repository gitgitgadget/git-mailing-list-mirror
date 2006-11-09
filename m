X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 19:04:26 -0800
Message-ID: <7vodrhpbgl.fsf@assigned-by-dhcp.cox.net>
References: <dlang@digitalinsight.com>
	<200611090228.kA92SMqw006666@laptop13.inf.utfsm.cl>
	<7vslgtpbx0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 03:04:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vslgtpbx0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Nov 2006 18:54:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31177>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi0DP-0005ai-84 for gcvg-git@gmane.org; Thu, 09 Nov
 2006 04:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754556AbWKIDE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 22:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbWKIDE2
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 22:04:28 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38817 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1754556AbWKIDE1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 22:04:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109030427.GBDM296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Wed, 8
 Nov 2006 22:04:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id kT4Y1V0091kojtg0000000; Wed, 08 Nov 2006
 22:04:32 -0500
To: "Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> "Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl> writes:
>
>>> On Tue, 7 Nov 2006, Junio C Hamano wrote:
>>> 
>>> > [pu]
>>> >
>>> >  Johannes's shallow clone work now should rebase cleanly on top
>>> >  of 'master' although I haven't done so yet.  As he said
>>> >  himself the series is waiting for people who have needs for
>>> >  such a feature to raise hands.
>>
>> +1
>
> What does that plus one mean?  I do not know where people picked
> up this annoying plus or minus one business, but could you all
> stop that?
>
> If you are volunteering to help debugging and feeding bugfixes
> that is very much welcome and appreciated.

Sorry, I sent the message without finishing.  What should have
followed is...

  On the other hand, if you are saying "yes, shallow would fit
  my workflow and would be useful to have, but I do not have
  time nor inclination to help hacking on it", that is also
  fine.

  But "+1" does not help me tell which one you really mean.

> Thanks.
