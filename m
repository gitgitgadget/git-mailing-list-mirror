X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 07 Dec 2006 14:11:11 -0800
Message-ID: <7vveknqruo.fsf@assigned-by-dhcp.cox.net>
References: <45708A56.3040508@drzeus.cx>
	<Pine.LNX.4.64.0612011639240.3695@woody.osdl.org>
	<457151A0.8090203@drzeus.cx>
	<Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	<45744FA3.7020908@zytor.com>
	<Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
	<45778AA3.7080709@zytor.com>
	<Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
	<4577A84C.3010601@zytor.com>
	<Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
	<45785697.1060001@zytor.com>
	<Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
	<457868AA.2030605@zytor.com>
	<Pine.LNX.4.64.0612071121410.3615@woody.osdl.org>
	<7vac1zsc8z.fsf@assigned-by-dhcp.cox.net> <45787515.4010200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 22:11:54 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45787515.4010200@zytor.com> (H. Peter Anvin's message of "Thu,
	07 Dec 2006 12:09:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33639>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsRT0-00050e-0d for gcvg-git@gmane.org; Thu, 07 Dec
 2006 23:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163489AbWLGWLl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 17:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163492AbWLGWLl
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 17:11:41 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51926 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163489AbWLGWLj (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 17:11:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207221112.NRXG15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 17:11:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vyBN1V00e1kojtg0000000; Thu, 07 Dec 2006
 17:11:23 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> If I understand correctly, kernel.org is still running the
>> version of gitweb Kay last installed there (I am too busy to
>> take over the gitweb installation maintenance at kernel.org, and
>> I did not ask the $DOCUMENTROOT/git/ directory to be transferred
>> to me when I rolled gitweb into the git.git repository).
>
> That's correct.  I can transfer that directory to you if you want; I
> can't realistically track gitweb well enough to do this myself...

Well, the reason I haven't asked to is because I don't have
enough time myself, so....
