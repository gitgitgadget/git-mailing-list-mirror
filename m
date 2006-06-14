From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 6/8] Make git-update-ref a builtin
Date: Tue, 13 Jun 2006 22:22:28 -0400
Message-ID: <20060614022228.GA13232@spearce.org>
References: <448EF791.7070504@etek.chalmers.se> <448F1E68.5090504@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 04:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqL2T-0007DW-D1
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 04:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWFNCWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 22:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWFNCWm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 22:22:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60069 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964924AbWFNCWm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 22:22:42 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FqL1R-0007aF-S5; Tue, 13 Jun 2006 22:22:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F119920FB20; Tue, 13 Jun 2006 22:22:28 -0400 (EDT)
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <448F1E68.5090504@etek.chalmers.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21822>

Lukas Sandstr?m <lukass@etek.chalmers.se> wrote:
> Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>
> ---
>  Makefile                             |    7 ++++---
>  update-ref.c =3D> builtin-update-ref.c |    5 ++++-
>  builtin.h                            |    1 +
>  git.c                                |    3 ++-
>  4 files changed, 11 insertions(+), 5 deletions(-)

Thanks for doing this.  I know I had written this change and I was
pretty sure I had sent it to Junio a while ago but I guess it got
lost in the shuffle and I just failed to follow through with it
when it didn't show up in `next`.

--=20
Shawn.
