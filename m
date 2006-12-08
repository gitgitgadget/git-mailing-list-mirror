X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Fri, 08 Dec 2006 08:16:34 -0800
Message-ID: <45798FE2.9040502@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org> <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 16:17:17 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <4579611F.5010303@dawes.za.net>
X-Virus-Scanned: ClamAV 0.88.6/2307/Fri Dec  8 05:50:05 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33702>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsiPM-0004jK-4w for gcvg-git@gmane.org; Fri, 08 Dec
 2006 17:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425597AbWLHQRF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 11:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760755AbWLHQRF
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 11:17:05 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51884 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1760753AbWLHQRB (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 11:17:01 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net
 [67.180.238.27]) (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7)
 with ESMTP id kB8GGYfX010122 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Fri, 8 Dec 2006 08:16:40 -0800
To: Rogan Dawes <discard@dawes.za.net>
Sender: git-owner@vger.kernel.org

Rogan Dawes wrote:
> 
> How about extending gitweb to check to see if there already exists a 
> cached version of these pages, before recreating them?
> 

This goes back to the "gitweb needs native caching" again.

