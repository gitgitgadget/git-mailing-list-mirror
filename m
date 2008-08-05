From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/8] bash completion: more porcelain completions
Date: Tue, 5 Aug 2008 07:29:19 -0700
Message-ID: <20080805142919.GA27295@spearce.org>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 16:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQNYM-0001yn-Lo
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 16:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbYHEO3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbYHEO3U
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 10:29:20 -0400
Received: from george.spearce.org ([209.20.77.23]:51089 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbYHEO3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 10:29:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C75538419; Tue,  5 Aug 2008 14:29:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91441>

Lee Marlow <lee.marlow@gmail.com> wrote:
> This adds basic long option completion for some common commands that I
> use, as well as stash name completion.

Entire series is good.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
> Lee Marlow (8):
>   bash completion: Add completion for 'git clone'
>   bash completion: Add completion for 'git clean'
>   bash completion: Add completion for 'git init'
>   bash completion: Add completion for 'git revert'
>   bash completion: More completions for 'git stash'
>   bash completion: Add completion for 'git archive'
>   bash completion: Add completion for 'git ls-files'
>   bash completion: Add completion for 'git mv'
> 
>  contrib/completion/git-completion.bash |  143 +++++++++++++++++++++++++++++++-
>  git-stash.sh                           |    2 +-
>  2 files changed, 143 insertions(+), 2 deletions(-)
> 

-- 
Shawn.
