From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rebase: suggest to use git-add instead of git-update-index
Date: Sat, 02 Jun 2007 12:07:20 -0700
Message-ID: <7v4plqqion.fsf@assigned-by-dhcp.cox.net>
References: <20070602175949.GB19952@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:07:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuYwp-0003DY-4i
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 21:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758552AbXFBTH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758490AbXFBTH2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 15:07:28 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42707 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbXFBTH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 15:07:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602190727.UXS15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 15:07:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6j7L1X0041kojtg0000000; Sat, 02 Jun 2007 15:07:25 -0400
In-Reply-To: <20070602175949.GB19952@diku.dk> (Jonas Fonseca's message of
	"Sat, 2 Jun 2007 19:59:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48949>

Jonas Fonseca <fonseca@diku.dk> writes:

> The command is part of the main porcelain making git-add more
> appropriate.
>
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  git-rebase.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
>  I don't know if this is good or not, maybe it is a matter of taste, but
>  as a new git user I prefer to use git add.

I like it.  Thanks.
