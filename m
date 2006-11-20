X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Mon, 20 Nov 2006 14:46:37 -0500
Message-ID: <20061120194637.GB1498@spearce.org>
References: <7vslgjaa0c.fsf@assigned-by-dhcp.cox.net> <200611201944.kAKJiCAw014973@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 19:47:06 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, hanwen@xs4all.nl,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611201944.kAKJiCAw014973@laptop13.inf.utfsm.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31930>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmF6Y-0007ug-N7 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 20:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966585AbWKTTqx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 14:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966586AbWKTTqw
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 14:46:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:10971 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S966585AbWKTTqv
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 14:46:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmF68-0001J0-Mv; Mon, 20 Nov 2006 14:46:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 01C8520FB09; Mon, 20 Nov 2006 14:46:38 -0500 (EST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> If you make pushing into an empty repository work also, you fix the case of
> "create an empty repo for somebody, let them fill it up remotely later".

This seems to work just fine now.  I do it all of the time.

-- 
