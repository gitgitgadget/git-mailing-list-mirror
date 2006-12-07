X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 07 Dec 2006 11:57:34 -0800
Message-ID: <4578722E.9030402@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 19:59:05 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <20061207193012.GA84678@dspnet.fr.eu.org>
X-Virus-Scanned: ClamAV 0.88.6/2301/Thu Dec  7 07:20:18 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33623>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPOW-0002eq-Lw for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163251AbWLGT65 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163250AbWLGT65
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:58:57 -0500
Received: from terminus.zytor.com ([192.83.249.54]:40027 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1163248AbWLGT64 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:58:56 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id
 kB7Jvb7j024497 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 7 Dec 2006 11:57:37 -0800
To: Olivier Galibert <galibert@pobox.com>
Sender: git-owner@vger.kernel.org

Olivier Galibert wrote:
> On Thu, Dec 07, 2006 at 11:16:58AM -0800, H. Peter Anvin wrote:
>> Unfortunately, the most common queries are also extremely expensive.
> 
> Do you have a top-ten of queries ?  That would be the ones to optimize
> for.

The front page, summary page of each project, and the RSS feed for each 
project.

