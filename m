X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 09:47:23 -0400
Message-ID: <4540BC6B.1050009@utoronto.ca>
References: <20061022185350.GW75501@over-yonder.net>	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>	<20061023222131.GB17019@over-yonder.net>	<Pine.LNX.4.64.0610231534010.3962@g5.osdl.org>	<20061024002622.GC17019@over-yonder.net>	<Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz>	<20061024163458.GH17019@over-yonder.net>	<Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz>	<20061025002713.GN17019@over-yonder.net>	<Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>	<20061025235306.GD17019@over-yonder.net> <45408A53.10400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 13:48:54 +0000 (UTC)
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com,
	David Lang <dlang@digitalinsight.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
In-Reply-To: <45408A53.10400@op5.se>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30219>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5ah-0003dd-0p for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161387AbWJZNsM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWJZNsL
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:48:11 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:7085 "EHLO
 server4.panoramicfeedback.com") by vger.kernel.org with ESMTP id
 S1161387AbWJZNsK (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 09:48:10 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]
 helo=[192.168.2.19]) by server4.panoramicfeedback.com with esmtp (Exim 3.36
 #1 (Debian)) id 1Gd5aD-0008PJ-00; Thu, 26 Oct 2006 09:47:45 -0400
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas Ericsson wrote:
> The only issue I have with bzr's revno's and truly distributed setup is
> that, by looking at the table, it seems to claim that you have found
> some miraculous way to make revnos work without a central server. Since
> everyone agrees that they don't, this should IMO be listed as mutually
> exclusive features.

The "simple namespace" is both a URL and a revno.

And therefore, it's just as distributed and decentralized as the web.

There is very little difference between this:

http://example.com/mywebpage#5

And this:

http://example.com/mybranch 5

In fact, we've been planning to unify them into one identifier.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFQLxr0F+nu1YWqI0RAiVrAJ9rb+uylIuxqMo2VMelI3Qm6oNQOwCfeTAb
kOkp9kOkRl1YEVEP+G3y2SU=
=Zgsg
