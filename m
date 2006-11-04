X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 14:07:42 -0500
Message-ID: <20061104190742.GB2517@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103203610.GB7585@spearce.org> <BAYC1-PASMTP01F45766D9195AAFD81789AEFE0@CEZ.ICE> <7vejsjxvtw.fsf@assigned-by-dhcp.cox.net> <20061104103325.bfb5e33e.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 19:08:33 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Miles Bader <miles@gnu.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061104103325.bfb5e33e.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30937>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgQsT-0001nI-5T for gcvg-git@gmane.org; Sat, 04 Nov
 2006 20:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753622AbWKDTHx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 14:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbWKDTHx
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 14:07:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:23268 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753622AbWKDTHw
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 14:07:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgQrj-0008VA-Ns; Sat, 04 Nov 2006 14:07:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 73CF020E491; Sat,  4 Nov 2006 14:07:42 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> All that remains is coming to some consensus on which set of options
> should be enabled for new Git users.  Once someone is up to speed, they
> can enable whichever options support their workflow.  But once they've
> enabled those options, Git should do it's best to support that workflow
> without a lot of manual intervention most of the time.  That's what
> the options I was suggesting would do for some workflows.

Agreed.

Since I already have to spell out the entire clone command line
(including URL) for my users asking them to also include a few
options (such as the hypothetical "--only vmdvt,vmtip -n") is not
a problem.  As in my workflow could be in the more "advanced user"
category.  :-)

-- 
