From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] completion: Get rid of tabbed indentation in
	comments. Replace with spaces.
Date: Fri, 6 Feb 2009 07:58:23 -0800
Message-ID: <20090206155823.GO26880@spearce.org>
References: <1233935210-4941-1-git-send-email-ted@tedpavlic.com> <1233935210-4941-2-git-send-email-ted@tedpavlic.com> <1233935210-4941-3-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:00:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVT7e-0000zQ-P7
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbZBFP6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbZBFP6Z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:58:25 -0500
Received: from george.spearce.org ([209.20.77.23]:36846 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZBFP6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:58:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6AC2F38210; Fri,  6 Feb 2009 15:58:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233935210-4941-3-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108746>

Ted Pavlic <ted@tedpavlic.com> wrote:
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>

Both patches,

Trivially-acked-by: Shawn O. Pearce <spearce@spearce.org>


> ---
>  contrib/completion/git-completion.bash |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6e04985..f44f63c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -34,11 +34,11 @@
>  #       are currently in a git repository.  The %s token will be
>  #       the name of the current branch.
>  #
> -#	In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
> -#	value, unstaged (*) and staged (+) changes will be shown next
> -#	to the branch name.  You can configure this per-repository
> -#	with the bash.showDirtyState variable, which defaults to true
> -#	once GIT_PS1_SHOWDIRTYSTATE is enabled.
> +#       In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
> +#       value, unstaged (*) and staged (+) changes will be shown next
> +#       to the branch name.  You can configure this per-repository
> +#       with the bash.showDirtyState variable, which defaults to true
> +#       once GIT_PS1_SHOWDIRTYSTATE is enabled.
>  #
>  # To submit patches:
>  #
> -- 
> 1.6.1.2.319.gbd9e
> 

-- 
Shawn.
