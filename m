From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Completion: add missing '=' for 'diff --diff-filter'
Date: Fri, 22 Aug 2008 10:27:37 -0700
Message-ID: <20080822172737.GM3483@spearce.org>
References: <279b37b20808221025l5e3b1e53gc9aa2d84e5aa6ea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 19:28:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWaRK-0007T6-UP
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbYHVR1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbYHVR1i
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:27:38 -0400
Received: from george.spearce.org ([209.20.77.23]:50457 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYHVR1i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 13:27:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9810938375; Fri, 22 Aug 2008 17:27:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <279b37b20808221025l5e3b1e53gc9aa2d84e5aa6ea3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93332>

Eric Raible <raible@gmail.com> wrote:
> Signed-off-by: Eric Raible <raible@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 158b912..f76545e 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -769,7 +769,7 @@ _git_diff ()
>                 __gitcomp "--cached --stat --numstat --shortstat --summary
>                         --patch-with-stat --name-only --name-status --color
>                         --no-color --color-words --no-renames --check
> -                       --full-index --binary --abbrev --diff-filter
> +                       --full-index --binary --abbrev --diff-filter=
>                         --find-copies-harder --pickaxe-all --pickaxe-regex
>                         --text --ignore-space-at-eol --ignore-space-change
>                         --ignore-all-space --exit-code --quiet --ext-diff

-- 
Shawn.
