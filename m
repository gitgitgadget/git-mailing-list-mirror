X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 10:30:03 -0800
Message-ID: <457B00AB.3030308@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <Pine.LNX.4.64.0612081453430.3516@woody.osdl.org> <46a038f90612081756w1ab4609epcb4a2cbd9f4d8205@mail.gmail.com> <200612091251.16460.jnareb@gmail.com> <457AAF31.2050002@garzik.org> <Pine.LNX.4.64.0612090957360.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 18:30:48 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>, Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612090957360.3516@woody.osdl.org>
X-Virus-Scanned: ClamAV 0.88.6/2311/Sat Dec  9 01:47:31 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33827>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt6y4-0004U8-1Q for gcvg-git@gmane.org; Sat, 09 Dec
 2006 19:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761819AbWLISaY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 13:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761820AbWLISaX
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 13:30:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60050 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1761818AbWLISaX (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 13:30:23 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net
 [67.180.238.27]) (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7)
 with ESMTP id kB9IU34x008989 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Sat, 9 Dec 2006 10:30:04 -0800
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> So there's probably tons of room for making this more efficient: using a 
> newer gitweb, packing refs, using the cgi cache thing.. It sounds like 
> what it really needs is just somebody with the competence and time to be 
> willing to step up and maintain gitweb on kernel.org...
> 

Indeed.  We have a lot of projects on kernel.org which are like this: 
not at all conceptually hard, but a huge time commitment for Doing It 
Right[TM].  This is why I sometimes think that it would be a Good Thing 
to get paid staff for kernel.org, although I was hoping to defer the 
need for that until at least we have our 501(c)3 paperwork done, which 
looks like mid-2007 at this point (assuming no further delays.)

