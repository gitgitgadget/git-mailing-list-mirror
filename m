From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 21:58:36 -0400
Message-ID: <BAYC1-PASMTP03770EEC1581564F1E1330AE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.
  15344.qmail@web51005.mail.yahoo.com>
	<BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1
 A0@CEZ.ICE>
	<20060926205632.5d487cc9.seanlkml@sympatico.ca>
	<Pine.LNX.4.63.06
 09261746160.22495@qynat.qvtvafvgr.pbz>
	<7vk63qnlc2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 03:58:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSOh9-0004hC-1s
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWI0B6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWI0B6j
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:58:39 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:40314 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932252AbWI0B6j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 21:58:39 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 18:58:38 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSOh3-0004Hm-09; Tue, 26 Sep 2006 21:58:37 -0400
To: David Lang <dlang@digitalinsight.com>
Message-Id: <20060926215836.f4a25297.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 01:58:38.0262 (UTC) FILETIME=[72D89560:01C6E1D8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2006 18:31:59 -0700 (PDT)
David Lang <dlang@digitalinsight.com> wrote:

> if that repository is then merged into another one, what date would that second 
> one record for that commit? the date it was pulled there?

Yes of course.  The question being posed and answered is.. when did the local
repository first get any specific commit.  For the sake of such a question
its merge history and path into the local repository doesn't matter, only
when the commit arrived locallly.

Sean
