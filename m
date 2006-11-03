X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 01:59:18 -0800 (PST)
Message-ID: <511753.217.qm@web31807.mail.mud.yahoo.com>
References: <46a038f90611030122reecee87ufac5bbaa910ee933@mail.gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 3 Nov 2006 09:59:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=DZiE0CCo840o6/RUHMJlLlkcpnEqdFYf5Z4avBiCaKefLM42kG8NP68QkagLw0ufTuh1/t7zB58i+MtFHBCNbA0GjDRhWZgLWwesdt+BpLX5RsF6Gmm6wvfk/EI0DC9Nj6D2XMsiHfyn1lkR/EGiMeTyNrfABComHMhRQrQpY3w=  ;
X-YMail-OSG: WstFL3cVM1nBaREAq0hJPt46_A7anFZ23eNDJAiekBwMhtTebxRkc3eZVMBcnraUhcBSnr5hPrVTNcvpRCleyF2HNJs6d.zPycTFj1_q8HB_QvuSxXTKZI3YRboF5sjZpo73ctRGGpw-
In-Reply-To: <46a038f90611030122reecee87ufac5bbaa910ee933@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30812>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfvpb-00039m-06 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752807AbWKCJ7U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbWKCJ7U
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:59:20 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:33432 "HELO
 web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1752808AbWKCJ7T (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 04:59:19 -0500
Received: (qmail 497 invoked by uid 60001); 3 Nov 2006 09:59:18 -0000
Received: from [71.80.233.118] by web31807.mail.mud.yahoo.com via HTTP; Fri,
 03 Nov 2006 01:59:18 PST
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

--- Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/3/06, Luben Tuikov <ltuikov@yahoo.com> wrote:
> > Yep, after more than a year, I simply cannot get used to it...
> > http://marc.theaimsgroup.com/?l=git&m=113259043217761&w=2
> > And as I've seen, other people brought that up too.
> 
> Hi Luben,
> 
> reading the thread, it sounds like you have a couple of shells scripts
> or aliases that do what you want already ;-)

Yeah, would you know it those scripts got lost somewhere.  I now
know better -- branch off of git "next" and store in USB key. :-)
So I generally work off of "next" merged to my own branch which includes
extras I've collected along the way.

But what wouldn't I give to have
  git-format-_patch_ -o /tmp/ <commit>
generate a _single_ patch just as its name implies...

   Luben

