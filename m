X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: information for a 60-minute "intro to git" needed
Date: Sat, 11 Nov 2006 11:09:17 -0800
Message-ID: <7vac2xkdgi.fsf@assigned-by-dhcp.cox.net>
References: <8664dmxdrf.fsf@blue.stonehenge.com>
	<20061111143304.GA7201@pasky.or.cz> <ej4teo$bjo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 19:09:32 +0000 (UTC)
Cc: jnareb@gmail.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ej4teo$bjo$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	11 Nov 2006 17:24:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31237>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiyEG-0000q5-Gf for gcvg-git@gmane.org; Sat, 11 Nov
 2006 20:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424595AbWKKTJT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 14:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424597AbWKKTJT
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 14:09:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42648 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1424595AbWKKTJS
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 14:09:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061111190918.WGCA18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sat, 11
 Nov 2006 14:09:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id lX9P1V00n1kojtg0000000; Sat, 11 Nov 2006
 14:09:24 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Petr Baudis wrote:
>
>> and http://git.or.cz/gitwiki/GitLinks for links to plenty
>> of "using git" pages for various projects and other introductory
>> articles.
>
> GitLinks has now links to junio, jdl and pasky slides from OLS,
> and junio slides from OSDL Japan Linux Symposium.

The OSDL Japan one is much more suitable for stealing tutorial
material from than the OLS one, but they took the pages on old
seminars down without telling me, it seems.  I've updated the
link in GitLinks page.  The presentation is designed to be run
in 25 minutes using the first half of slides (pretty pictures),
followed by a 25 minutes demo (reproducing the second half of
slides).

I think Martin Langhoff promised to make his presentation done
in Mexico available to us sometime ago, but I wonder what
happened to it...
