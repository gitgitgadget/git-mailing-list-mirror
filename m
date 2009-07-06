From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/4] First set of improvements to git-svn user doc
Date: Mon, 6 Jul 2009 15:20:28 -0700
Message-ID: <20090706222028.GB11043@dcvr.yhbt.net>
References: <1246831397-19489-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 00:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNwY7-0005Ih-JW
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 00:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbZGFWUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 18:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZGFWUZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 18:20:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47631 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbZGFWUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 18:20:24 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 73834113077;
	Mon,  6 Jul 2009 22:20:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1246831397-19489-1-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122805>

Yann Dirson <ydirson@altern.org> wrote:
> From my previous post, I have splitted the changes to the manpage for easier
> review and incremental integration.  Here are the parts I consider mature
> enough to be proposed into master.  The other ones are still WIP and I'll
> repost them when I have made real progress on them.
> 
> Yann Dirson (4):
>   git-svn.txt: stop using dash-form of commands.
>   git-svn.txt: make formatting more consistent.
>   git-svn.txt: fix fetch flags incorrectly documented as init flags.
>   git-svn.txt: fix description of fetch flags accepted by clone.

Thanks Yann,

Text-wise, these changes look good and I trust you won't knowingly
introduce formatting errors, so consider them:

  Acked-by: Eric Wong <normalperson@yhbt.net>

On a side note, what kind of machine is needed to build documentation at
non-painful speeds these days?
