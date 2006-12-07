X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 07 Dec 2006 12:09:57 -0800
Message-ID: <45787515.4010200@zytor.com>
References: <45708A56.3040508@drzeus.cx>	<Pine.LNX.4.64.0612011639240.3695@woody.osdl.org>	<457151A0.8090203@drzeus.cx>	<Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>	<45744FA3.7020908@zytor.com>	<Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>	<45778AA3.7080709@zytor.com>	<Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>	<4577A84C.3010601@zytor.com>	<Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>	<45785697.1060001@zytor.com>	<Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>	<457868AA.2030605@zytor.com>	<Pine.LNX.4.64.0612071121410.3615@woody.osdl.org> <7vac1zsc8z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 20:10:27 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <7vac1zsc8z.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.6/2301/Thu Dec  7 07:20:18 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33628>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPZV-0004Hw-Od for gcvg-git@gmane.org; Thu, 07 Dec
 2006 21:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163266AbWLGUKR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 15:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163267AbWLGUKR
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 15:10:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38379 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1163266AbWLGUKQ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 15:10:16 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id
 kB7KA0kO025260 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 7 Dec 2006 12:10:00 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> If I understand correctly, kernel.org is still running the
> version of gitweb Kay last installed there (I am too busy to
> take over the gitweb installation maintenance at kernel.org, and
> I did not ask the $DOCUMENTROOT/git/ directory to be transferred
> to me when I rolled gitweb into the git.git repository).

That's correct.  I can transfer that directory to you if you want; I 
can't realistically track gitweb well enough to do this myself (in fact, 
it was pretty much a condition of having it up there that Kay would keep 
maintaining it.)

> I do not know what queries are most popular, but I think a newer
> gitweb is more efficient in the summary page (getting list of
> branches and tags).  It might be worth a try.

How do you want to handle it?

	-hpa

