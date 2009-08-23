From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 17:13:38 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <20090823171819.6117@nanako3.lavabit.com> <7v1vn2yklo.fsf@alter.siamese.dyndns.org>
 <20090824060708.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 00:14:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfLKH-0003wa-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 00:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbZHWWOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbZHWWOE
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 18:14:04 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:40541 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZHWWOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 18:14:03 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MfLK7-0004Z3-LR; Sun, 23 Aug 2009 17:14:03 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <20090824060708.6117@nanako3.lavabit.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126889>

Nanako Shiraishi (nanako3@lavabit.com) wrote on Aug 23, 2009:

> Quoting Junio C Hamano <gitster@pobox.com>
> 
> > Having said that, I could use something like this.
> >
> > -- >8 -- cut here -- >8 -- 
> > Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
> >
> > This teaches mailinfo the scissors -- >8 -- mark; the command ignores
> > everything before it in the message body.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> There are left handed people whose scissors run in the wrong direction.
> 

Woohoo!  Glad the left handed people aren't being discriminated against. 
;)

BTW - I'm happily using this and think it should be in git!

-- 
Thell
