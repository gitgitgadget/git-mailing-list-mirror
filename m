X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [StGIT PATCH] StGIT bash completion
Date: Mon, 13 Nov 2006 00:04:53 -0500
Message-ID: <20061113050453.GA31488@spearce.org>
References: <20061112211813.19959.73406.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 05:05:28 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061112211813.19959.73406.stgit@localhost>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31289>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjU0X-0000W0-Sk for gcvg-git@gmane.org; Mon, 13 Nov
 2006 06:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753885AbWKMFE7 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 00:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbWKMFE7
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 00:04:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:30600 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753885AbWKMFE6
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006
 00:04:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GjTzv-0001Yh-Lr; Mon, 13 Nov 2006 00:04:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CB35720E42F; Mon, 13 Nov 2006 00:04:53 -0500 (EST)
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr?m <kha@treskal.com> wrote:
> From: Karl Hasselstr=F6m <kha@treskal.com>
>=20
> A minimal bash completion script for StGIT. It completes the
> subcommand names, and options and patch names for some subcommands.
>=20
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
> ---
>=20
> I'm not good at all at bash programming -- this script was basically
> put together by pattern-matching Shawns git completion code -- so
> comments are even more welcome than usual.

I'm not an StGIT user, but this looks pretty good.

--=20
