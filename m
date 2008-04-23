From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Linked glossary from cvs-migration page
Date: Wed, 23 Apr 2008 12:50:11 -0400
Message-ID: <20080423165011.GE31576@fieldses.org>
References: <1208956431-1955-1-git-send-email-mdg149@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:51:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoiBV-0000r2-14
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 18:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbYDWQuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbYDWQuS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 12:50:18 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44804 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbYDWQuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 12:50:17 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JoiAd-0000qX-9J; Wed, 23 Apr 2008 12:50:11 -0400
Content-Disposition: inline
In-Reply-To: <1208956431-1955-1-git-send-email-mdg149@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80229>

On Wed, Apr 23, 2008 at 09:13:51AM -0400, Matt Graham wrote:
> Coming from CVS, I found the git glossary vital to learning git and learning
> how terms in git correlate to the cvs terminology with which I am familiar.
> 
> This patch links the glossary from the cvs-migration page so cvs users will
> be able to fine the glossary as soon as they start looking at git documents.
> 
> Signed-off-by: Matt Graham <mdg149@gmail.com>

Fine by me.--b.

> ---
>  Documentation/cvs-migration.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
> index ea98900..00f2e36 100644
> --- a/Documentation/cvs-migration.txt
> +++ b/Documentation/cvs-migration.txt
> @@ -8,7 +8,8 @@ designating a single shared repository which people can synchronize with;
>  this document explains how to do that.
>  
>  Some basic familiarity with git is required.  This
> -link:tutorial.html[tutorial introduction to git] should be sufficient.
> +link:tutorial.html[tutorial introduction to git] and the
> +link:glossary.html[git glossary] should be sufficient.
>  
>  Developing against a shared repository
>  --------------------------------------
> -- 
> 1.5.5.49.gf43e2
> 
