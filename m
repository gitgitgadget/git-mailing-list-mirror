X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Steven Grimm <koreth@midwinter.com>
Subject: Re: egit/jgit wishlist
Date: Mon, 04 Dec 2006 14:06:09 -0800
Message-ID: <45749BD1.6070804@midwinter.com>
References: <20061204172836.GB6011@spearce.org> <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net> <20061204182902.GG6011@spearce.org> <457490EE.30606@midwinter.com> <Pine.LNX.4.63.0612042235270.14187@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 22:06:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Zp4gQ5/+sSXjTxiVAM/BcJkxPxcg6yGIaQV8h1A4Ic9qmR2ULsCXQuATUX1wFl3v  ;
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <Pine.LNX.4.63.0612042235270.14187@alpha.polcom.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33260>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLwx-0007OO-RP for gcvg-git@gmane.org; Mon, 04 Dec
 2006 23:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967717AbWLDWGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 17:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967721AbWLDWGI
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 17:06:08 -0500
Received: from tater.midwinter.com ([216.32.86.90]:52049 "HELO midwinter.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S967717AbWLDWGG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 17:06:06 -0500
Received: (qmail 1112 invoked from network); 4 Dec 2006 22:06:05 -0000
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1) by localhost
 with SMTP; 4 Dec 2006 22:06:05 -0000
To: Grzegorz Kulewski <kangur@polcom.net>
Sender: git-owner@vger.kernel.org

Grzegorz Kulewski wrote:
> Can you name one system where Java (J2SE 1.4 or better 1.5) works 
> (fully, not sometimes) and where GIT does not work? Does Eclipse work 
> there too (or will in say next year)?

Sure, I can name a pretty significant one: Windows. Eclipse, and Java in 
general, runs fine under Windows and I doubt they'll drop support for it 
in the next year. Git doesn't run on Windows unless you're willing to 
fire up the Cygwin environment to run it, which is not acceptable to 
many Windows developers (see the discussion about the Mozilla project; 
that's not just my personal opinion.)

-Steve
