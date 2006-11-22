X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: A documentation to-do list
Date: Tue, 21 Nov 2006 17:33:09 -0800
Message-ID: <7vslgcw9ii.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 01:34:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
	(Chris Riddoch's message of "Tue, 21 Nov 2006 18:13:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32063>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmgzD-0006DM-CT for gcvg-git@gmane.org; Wed, 22 Nov
 2006 02:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966997AbWKVBdM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 20:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966999AbWKVBdM
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 20:33:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5617 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S966997AbWKVBdK
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 20:33:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122013310.HVFH18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 21
 Nov 2006 20:33:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pdZH1V00H1kojtg0000000; Tue, 21 Nov 2006
 20:33:17 -0500
To: "Chris Riddoch" <riddochc@gmail.com>
Sender: git-owner@vger.kernel.org

"Chris Riddoch" <riddochc@gmail.com> writes:

> Hi, everyone.
>
> Having decided to take it on myself to improve Git's documentation, I
> asked on #git if people had particular things they felt I should focus
> on.  I also was prompted to put up a page on the wiki to make my to-do
> list public.
>
> So, I present:  http://git.or.cz/gitwiki/Documentation_To-Do_List
>
> Add your favorite, specific, lack-of-documentation or badly-described
> annoyance here!

Thanks.

I would not likely to be writing the updates because I am not a
good writer myself, but if there are things that need to be
explained, both behaviour-wise and intent/design-wise, I am
willing to help this effort.

Aside from lacking minor details here and there I think the
largest problem in the current documentation set is the
organization, though.

