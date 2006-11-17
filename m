X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 01:11:17 +0100
Message-ID: <455CFE25.8040705@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <20061116051240.GV7201@pasky.or.cz>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 00:11:56 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20061116051240.GV7201@pasky.or.cz>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31641>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkrKX-0006Lo-Ff for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424787AbWKQALh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424792AbWKQALh
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:11:37 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:28435 "EHLO
 smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S1424787AbWKQALg
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:11:36 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAH0BDRm091355; Fri, 17 Nov 2006 01:11:13 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis escreveu:
> (vi) Coding issues. This is probably very subjective, but a blocker for
> me. I have no issues about C here, but about the shell part of Git.
> Well, how to say it... It's just fundamentally incompatible with me. I

(on a tangent)

I concur, but probably in a different way.

some 10 years ago I vowed never to write perl code again, and some 5
years ago, I made the same pledge for shell scripts, because I spent
inordinate amounts of time debugging them.

When I see the GIT shell scripts, my hands start to itch to make a
nice object oriented Python wrapper for it.

-- 
