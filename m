From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 00:08:48 -0600
Message-ID: <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 07:09:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj1yp-0005sp-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 07:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab2LMGIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 01:08:49 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42919 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2LMGIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 01:08:48 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1712643oag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 22:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3zqbDs2wZk7o1BghLekKH7cwMcRWDmMzOcFnkA8KgGo=;
        b=TX3685l1KAVFd4p95gtKqH82GhNohtyh+MCxtHZjQS4CO7jnUlzHnCLI3UW7qsV7g9
         75fQwn6ya9WIpSDBEjyB/bybgoAj1yHqJjZjxmI6r1MKnl+R8xWqKT3eDqDhXZuUj7Sz
         hk0YuMHng0q0baAn3yWpNtlFtv3rV/E6ee3dwuLzZ5MXCgeTDX5Yi781TxkUGiqiZ05r
         8gqQ2j5hNYGaCOiTWhbqZTPT/1p+xV55IPFsYL2bRlORZeaCmcp9eFedn/pQB5E7kCmY
         gLog/phPamBTl6WxQCaf2S4nHeRP+ibBdpcPvf9/KNb4atATl6qRE1eGoXQm5nPkSbAq
         BSGw==
Received: by 10.182.21.135 with SMTP id v7mr515052obe.101.1355378928130; Wed,
 12 Dec 2012 22:08:48 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 12 Dec 2012 22:08:48 -0800 (PST)
In-Reply-To: <7vhanq257s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211436>

On Wed, Dec 12, 2012 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:

> [Stalled]
>
> * fc/remote-bzr (2012-11-28) 10 commits
>  - (fixup) test-bzr.sh: fix multi-line string assignment
>  - remote-bzr: detect local repositories
>  - remote-bzr: add support for older versions of bzr
>  - remote-bzr: add support to push special modes
>  - remote-bzr: add support for fecthing special modes
>  - remote-bzr: add simple tests
>  - remote-bzr: update working tree
>  - remote-bzr: add support for remote repositories
>  - remote-bzr: add support for pushing
>  - Add new remote-bzr transport helper
>
>  New remote helper for bzr (v3).  With minor fixes, this may be ready
>  for 'next'.

What minor fixes?

-- 
Felipe Contreras
