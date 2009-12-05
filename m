From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH RESEND] git gui: make current branch default in "remote
	delete branch" merge check
Date: Sat, 5 Dec 2009 13:18:51 -0800
Message-ID: <20091205211851.GD5610@spearce.org>
References: <20091204212648.GA3979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 22:19:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH21z-0004o0-Qn
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 22:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbZLEVS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 16:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbZLEVS4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 16:18:56 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:42070 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbZLEVS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 16:18:56 -0500
Received: by yxe17 with SMTP id 17so2983434yxe.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 13:19:02 -0800 (PST)
Received: by 10.90.14.35 with SMTP id 35mr7791636agn.73.1260047935122;
        Sat, 05 Dec 2009 13:18:55 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm2188033iwn.3.2009.12.05.13.18.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 13:18:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091204212648.GA3979@book.hvoigt.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134624>

Heiko Voigt <hvoigt@hvoigt.net> wrote:
> We already do the same when locally deleting a branch.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> 
>  lib/remote_branch_delete.tcl |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

Thanks, applied.
 
-- 
Shawn.
