X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 21:09:01 -0800
Message-ID: <457A44ED.4080606@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>	 <200612081438.25493.jnareb@gmail.com>	 <46a038f90612081728s65d65ccewe64fa1a496de76fa@mail.gmail.com>	 <457A1962.6000401@zytor.com> <46a038f90612081852u63e05da1qe57504636f3578fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 05:09:33 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <46a038f90612081852u63e05da1qe57504636f3578fd@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.6/2308/Fri Dec  8 08:10:24 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33801>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsuSj-0007JU-1h for gcvg-git@gmane.org; Sat, 09 Dec
 2006 06:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758976AbWLIFJP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 00:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758957AbWLIFJP
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 00:09:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55231 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1758940AbWLIFJO (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 00:09:14 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net
 [67.180.238.27]) (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7)
 with ESMTP id kB9591Pc014984 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Fri, 8 Dec 2006 21:09:03 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> I posted separately about those. And I've been mulling about whether
> the thundering herd is really such a big problem that we need to
> address it head-on.

Uhm... yes it is.

