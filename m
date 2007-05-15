From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 02/10] user-manual: revise birdseye-view chapter
Date: Mon, 14 May 2007 17:07:04 -0700
Message-ID: <7v4pmflzkn.fsf@assigned-by-dhcp.cox.net>
References: <11791560893572-git-send-email->
	<30964.7168651738$1179156134@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue May 15 02:07:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnkZM-0002jD-70
	for gcvg-git@gmane.org; Tue, 15 May 2007 02:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbXEOAHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 20:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbXEOAHG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 20:07:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58011 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557AbXEOAHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 20:07:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515000704.YYPN24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 20:07:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zC741W00C1kojtg0000000; Mon, 14 May 2007 20:07:04 -0400
In-Reply-To: <30964.7168651738$1179156134@news.gmane.org> (J. Bruce Fields's
	message of "Mon, 14 May 2007 11:21:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47303>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> From: J. Bruce Fields <bfields@citi.umich.edu>
>
> Some revisions suggested by Junio along with some minor style fixes and
> one compile fix (asterisks need escaping).
>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
> ---
>  Documentation/user-manual.txt |   43 +++++++++++++++++++---------------------
>  1 files changed, 20 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index bac9660..7abdc3e 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3161,8 +3161,12 @@ contrast, running "git prune" while somebody is actively changing the
>  repository is a *BAD* idea).
>  
>  [[birdview-on-the-source-code]]
> -A birdview on Git's source code
> ------------------------------
> +A birds-eye view of Git's source code
> +-------------------------------------
> +
> +It is not always easy for new developers to find their way through Git's
> +source code.  This section gives you a gentle guidance to show where to
> +start.
>  
>  While Git's source code is quite elegant, it is not always easy for
>  new  developers to find their way through it.  A good idea is to look

Perhaps you meant to drop this first sentence "While ... through
it." from the original?
