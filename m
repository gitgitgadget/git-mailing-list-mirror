From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] add--interactive: added [c]heckout
Date: Mon, 6 Oct 2008 07:51:37 -0700
Message-ID: <20081006145137.GC8203@spearce.org>
References: <20081005152654.GA13618@gmx.de> <20081005164124.GA31903@coredump.intra.peff.net> <20081005214644.GB32727@gmx.de> <20081005221150.GA22007@coredump.intra.peff.net> <353e718308129444268e61f251dab769761f095f.1223304141.git.marco-oweber@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 06 16:58:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmrS6-0000l0-6X
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYJFOvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYJFOvj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:51:39 -0400
Received: from george.spearce.org ([209.20.77.23]:45113 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYJFOvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:51:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EE9293835F; Mon,  6 Oct 2008 14:51:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <353e718308129444268e61f251dab769761f095f.1223304141.git.marco-oweber@gmx.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97590>

Marc Weber <marco-oweber@gmx.de> wrote:
> this is convinient for cygwin users not using rxvt.
> 
> added last (before quit and help) to not break menu layout and keep exisiting
> numbering
> 
> Signed-off-by: Marc Weber <marco-oweber@gmx.de>
> ---
>  git-add--interactive | 1129 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1129 insertions(+), 0 deletions(-)
>  create mode 100755 git-add--interactive
> 
> diff --git a/git-add--interactive b/git-add--interactive
> new file mode 100755
> index 0000000..2e7fa55
> --- /dev/null
> +++ b/git-add--interactive

Uhm, what is this patch against?  git.git?  If so why are we creating
a new 1129 line script named something erily close to a script we
already have?

-- 
Shawn.
