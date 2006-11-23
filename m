X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Some tips for doing a CVS importer
Date: Thu, 23 Nov 2006 10:10:14 +0100
Organization: eudaptics software gmbh
Message-ID: <45656576.E10FA81D@eudaptics.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
	 <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com>
	 <20061121063934.GA3332@spearce.org> <20061121200341.GH7201@pasky.or.cz> <Pine.LNX.4.63.0611212116340.26827@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 09:10:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32124>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnAax-0000Ea-Jl for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933390AbWKWJKI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 04:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933395AbWKWJKH
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:10:07 -0500
Received: from main.gmane.org ([80.91.229.2]:39123 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933390AbWKWJKE (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 04:10:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnAal-0000Bz-Gj for git@vger.kernel.org; Thu, 23 Nov 2006 10:09:59 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 10:09:59 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 23 Nov 2006
 10:09:59 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> I started playing with MinGW, and got it to compile and run, with some
> features lacking. See
> 
> Message-ID: <Pine.LNX.4.63.0609021724110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
> 
> for details. From TFM
> 
> : The two biggest obstacles are fork() and the network stuff (I do not
> : plan on supporting Git.pm there). To overcome the absence of fork() I
> : wanted to use the subprocess stuff in MinGW's port of GNU make.

I'd like to do something about it. Is your work accessible in some way?

At the moment I'm limping along with CVS on Windows, which really is the
wrong tool for my current task (CVS I mean, not Windows ;)

-- Hannes
