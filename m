X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-*arch* in git-arch rpm
Date: Wed, 25 Oct 2006 11:35:51 -0700
Message-ID: <7vslhcb5vc.fsf@assigned-by-dhcp.cox.net>
References: <20061024200211.17221.qmail@9f622d681978b5.315fe32.mid.smarden.org>
	<7viri9dkk5.fsf@assigned-by-dhcp.cox.net>
	<20061025112327.16220.qmail@e5d824cd35b8a9.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 18:36:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061025112327.16220.qmail@e5d824cd35b8a9.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 25 Oct 2006 11:23:27 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30086>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcnbX-0006Jf-Tt for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932269AbWJYSfx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 14:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWJYSfw
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:35:52 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:52921 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S932269AbWJYSfw
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 14:35:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025183551.ZVPF6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 14:35:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eiba1V00W1kojtg0000000 Wed, 25 Oct 2006
 14:35:35 -0400
To: Gerrit Pape <pape@smarden.org>
Sender: git-owner@vger.kernel.org

Gerrit Pape <pape@smarden.org> writes:

> On Tue, Oct 24, 2006 at 10:35:38PM -0700, Junio C Hamano wrote:
>> Gerrit Pape <pape@smarden.org> writes:
>> > Hi, there're two programs in the git-arch rpm that shouldn't be there:
>
>> So we need at least this?
>
> And this I think, but can't test it.

Thanks.

I ended up doing something very similar to yours after sending
out the initial patch (my FC box is a notebook resurrected from
boneyard and I need to sneakernet to do any RPM work, so latency
of feedback from that box is rather long X-<).

