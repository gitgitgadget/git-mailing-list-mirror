From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Thu, 21 Apr 2005 00:27:59 -0400 (EDT)
Message-ID: <2238.10.10.10.24.1114057679.squirrel@linux1>
References: <20050420205633.GC19112@pasky.ji.cz>
    <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz>
    <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
    <20050420222815.GM19112@pasky.ji.cz>
    <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>
    <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>
    <20050421033526.GA9404@nevyn.them.org>
    <Pine.LNX.4.58.0504202056310.2344@ppc970.osdl.org>
    <20050420221451.36c98f62.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, dan@debian.org, pasky@ucw.cz,
	greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 07:23:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOU9W-0003Mv-14
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 07:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDUF1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 01:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDUF1W
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 01:27:22 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:19601 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261223AbVDUF1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 01:27:19 -0400
Received: from linux1 ([67.71.124.169]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050421052718.DBVG3701.simmts7-srv.bellnexxia.net@linux1>;
          Thu, 21 Apr 2005 01:27:18 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3L4Rv7p019571;
	Thu, 21 Apr 2005 00:27:57 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 21 Apr 2005 00:27:59 -0400 (EDT)
In-Reply-To: <20050420221451.36c98f62.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, April 21, 2005 1:14 am, Randy.Dunlap said:

>> In _any_ real system you'll be getting thousands of lines of output.
>> Possibly millions. unpaginated? What the hell are you talking about?
>
> Who in the world would look at thousands or millions of lines on a
> tty using a pager?
>

This conversation is getting a bit silly, but to answer your question a
pager has a search feature which would let you bypass the first 900,000
lines to find the ones you're interested in.

Cheers,
Sean


