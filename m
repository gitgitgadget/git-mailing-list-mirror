From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 21:07:21 -0400
Message-ID: <BAYC1-PASMTP073037545878F6FEB7E88FAE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.
 15344.qmail@web51005.mail.yahoo.com>
	<BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1A0@CEZ.ICE>
	<20060926205632.5d487cc9.seanlkml@sympatico.ca>
	<Pine.LNX.4.63.0609261746160.22495@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthew L Foster <mfoster167@yahoo.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 03:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSNtX-0003qW-5o
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWI0BHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWI0BHY
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:07:24 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:34546 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932194AbWI0BHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 21:07:23 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 18:12:47 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSNtS-0004CQ-2K; Tue, 26 Sep 2006 21:07:22 -0400
To: David Lang <dlang@digitalinsight.com>
Message-Id: <20060926210721.36eb509d.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0609261746160.22495@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 01:12:47.0703 (UTC) FILETIME=[0B629670:01C6E1D2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Sep 2006 17:47:27 -0700 (PDT)
David Lang <dlang@digitalinsight.com> wrote:

> would it?
> 
> remember that a pach could be merged to many trees in any order. which merge 
> date do you want to know about?

I *think* it would be useful information to know when it was merged with the
_local_ repository.   So in the case of kernel.org gitweb, you'd essentially
be able to find out when _Linus_ received the commit and published it to the
world.  Doesn't that sound worthwhile?

Sean
