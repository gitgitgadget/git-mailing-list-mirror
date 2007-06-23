From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add example to move everything into a subdirectory
Date: Fri, 22 Jun 2007 23:22:41 -0700
Message-ID: <7vwsxv8a1a.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706211805010.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 08:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1z1T-0004FQ-Ql
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 08:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbXFWGWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 02:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXFWGWo
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 02:22:44 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62344 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbXFWGWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 02:22:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070623062242.OHVE3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Jun 2007 02:22:42 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EuNh1X00V1kojtg0000000; Sat, 23 Jun 2007 02:22:42 -0400
In-Reply-To: <Pine.LNX.4.64.0706211805010.4059@racer.site> (Johannes
	Schindelin's message of "Thu, 21 Jun 2007 18:05:30 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50721>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ffb31d6..297e09e 100644
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -181,6 +181,14 @@

Keeping your private repository out of sync with me is Ok, but
can you fix the filemode when you have chance?  The warning I
get every time I apply a patch from you to this file about mode
mismatch somewhat annoys me.

Thanks.
