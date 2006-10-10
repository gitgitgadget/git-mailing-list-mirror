From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 11:50:06 -0700 (PDT)
Message-ID: <20061010185006.34796.qmail@web31813.mail.mud.yahoo.com>
References: <200610101514.20705.Josef.Weidendorfer@gmx.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 10 20:50:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXMgD-0001LA-0C
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWJJSuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJJSuM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 14:50:12 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:15983 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932126AbWJJSuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 14:50:10 -0400
Received: (qmail 34811 invoked by uid 60001); 10 Oct 2006 18:50:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iu2+ghMcd4mb8nMZQRe1xJRx3y4qqeelTVHnWKP8fZ9Y+WF2mzUv0ByKGFAf/TweBSeQjOacCkcmlj48A6qY2aAbqZRMHCEUPo936A36hlrX0oSmakeFoSdF376bXYPB1eHdQbbN8SCURs09vDNWsbGuRWEBaLWNayauh3nxQKA=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 11:50:06 PDT
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andreas Ericsson <ae@op5.se>
In-Reply-To: <200610101514.20705.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28652>

--- Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 10 October 2006 10:07, Andreas Ericsson wrote:
> > I like my links blue and underlined. Can't be arsed to mouse over things 
> > to figure out if they're clickable. If they're not blue and underlined, 
> > they're not, insofar as I'm concerned.
> 
> Same opinion here.
> 
> Better be functional than beautiful but confusing.

Indeed.

The larger the group of people deciding on an issue, the less
forward ideas and thinking is introduced.  They are inversely
proportional.

Note that almost all forward ideas and ground breaking thoughts have
always been introduced by one, at most two people, not in a forum
or committee.  For example (relavant to the audience of this list):
Linux, git, sparse.

Imagine if the design of git has been initiated in a committee or
a mailing list or a forum...

Can someone please submit those two patches
  a) one which underlines ALL clickable links in ALL of gitweb, and
  b) second which puts redundant links of everything to everything,
     just because we can,
and then we can move on?

Thanks,
    Luben
