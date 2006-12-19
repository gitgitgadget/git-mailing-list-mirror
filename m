X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 02:58:05 -0500
Message-ID: <20061219075805.GE2511@spearce.org>
References: <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <Pine.LNX.4.64.0612182248420.3479@woody.osdl.org> <20061219072607.GD2511@spearce.org> <20061219075256.GA30448@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 07:58:31 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219075256.GA30448@fiberbit.xs4all.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34794>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwZrm-0007Qm-Du for gcvg-git@gmane.org; Tue, 19 Dec
 2006 08:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932626AbWLSH6P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 02:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWLSH6P
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 02:58:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57057 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932626AbWLSH6O (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 02:58:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwZrR-0005BQ-SR; Tue, 19 Dec 2006 02:58:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 720DD20FB65; Tue, 19 Dec 2006 02:58:05 -0500 (EST)
To: Marco Roeland <marco.roeland@xs4all.nl>
Sender: git-owner@vger.kernel.org

Marco Roeland <marco.roeland@xs4all.nl> wrote:
> The kernel git repository isn't very handy on the Mac HFS+ filesystem,
> due to it being case-insensitive, but I suppose it won't influence
> git-index-pack.

Yea, I just play with it in packed format on this system.  :-)

-- 
