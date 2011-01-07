From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 7 Jan 2011 22:22:32 +0000
Message-ID: <20110107222232.GA10624@dcvr.yhbt.net>
References: <4D260A03.90903@ramsay1.demon.co.uk> <20110107173114.GA31376@dcvr.yhbt.net> <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:22:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbKhi-0003qv-V3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab1AGWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:22:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41018 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab1AGWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:22:33 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2381F68D;
	Fri,  7 Jan 2011 22:22:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164775>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Fri, Jan 7, 2011 at 12:31 PM, Eric Wong <normalperson@yhbt.net> wrote:
> > Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
> >> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk> ---
> >
> > Consider this
> > Acked-by: Eric Wong <normalperson@yhbt.net>
> 
> Acked-by: Steven Walter <stevenrwalter@gmail.com>

I've pushed out Ramsay's patch along with a small manpage fix
that was mailed to me privately to git://git.bogomips.org/git-svn.git

Ramsay Allan Jones (1):
      t9157-*.sh: Add an svn version check

StephenB (1):
      git svn: fix the final example in man page

-- 
Eric Wong
