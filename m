X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] make =?iso-8859-1?Q?index-p=E2ck?= able to complete
 thin packs
Date: Thu, 26 Oct 2006 02:33:54 -0700
Message-ID: <7vpscfo1z1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
	<7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org>
	<20061026091925.GD13780@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 09:34:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061026091925.GD13780@diana.vm.bytemark.co.uk> (Karl
	=?iso-8859-1?Q?Hasselstr=F6m's?= message of "Thu, 26 Oct 2006 11:19:25
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30167>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1cc-0002fU-Ng for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422942AbWJZJd4 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 05:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422960AbWJZJd4
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:33:56 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36083 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1422942AbWJZJdz
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 05:33:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026093355.HSOA18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 05:33:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id exZd1V0081kojtg0000000 Thu, 26 Oct 2006
 05:33:37 -0400
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2006-10-26 09:50:48 +0200, Jakub Narebski wrote:
>
>> That said, git-am should understand QP with coding in mail headers.
>
> I really hope it does, since I just patched StGIT to generate such
> headers. (Out of pure vanity -- I don't want my name mangled!)

Sorry for an earlier hiccup.
