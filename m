From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 22:45:16 +0200
Message-ID: <20060505204516.GA82888@dspnet.fr.eu.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 22:45:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc7Aw-0000fk-SR
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWEEUpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWEEUpT
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:45:19 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:41740 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751216AbWEEUpR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 16:45:17 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id BFB43A3556; Fri,  5 May 2006 22:45:16 +0200 (CEST)
To: linux@horizon.com
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>, linux@horizon.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060505181540.GB27689@pasky.or.cz>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19640>

On Fri, May 05, 2006 at 08:15:41PM +0200, Petr Baudis wrote:
> The automatic vs. explicit movement tracking is a lot more
> controversial. Explicit movement tracking is pretty easy to provide for
> file-level movements, it's just that the user says "I _did_ move file
> A to file B" (I never got the Linus' argument that the user has no idea
> - he just _performed_ the move, also explicitly, by calling *mv).

In one of my projects 99% or the renames are "done" when unzipping the
source release of the next version.  Explicit tracking would be
unbearable, frankly.

And once you have a good enough implicit tracking, why bother with an
explicit one?

  OG.
