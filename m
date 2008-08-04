From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: German translation of git man pages
Date: Mon, 4 Aug 2008 20:43:38 +0200
Message-ID: <20080804184338.GA6186@leksak.fem-net>
References: <1217408012.9486.13.camel@hydra.esse.ch> <alpine.LNX.1.10.0808031924490.13351@hydra.esse.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabio Scotoni <fabio@esse.ch>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ53A-0006Fc-Ud
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 20:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758351AbYHDSny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 14:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbYHDSnx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 14:43:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:33898 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756918AbYHDSnt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 14:43:49 -0400
Received: (qmail invoked by alias); 04 Aug 2008 18:43:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp028) with SMTP; 04 Aug 2008 20:43:45 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18MmsRy9HMMnmwbNgiTU3soIP8/vKhhCvUhfNvPfr
	YOdOzepKmW0ylP
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KQ51u-0001sa-4p; Mon, 04 Aug 2008 20:43:38 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808031924490.13351@hydra.esse.ch>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91385>

Hi,

Fabio Scotoni wrote:
> Hello,
>
> I ran into another problem: Should i write something like "translated by
> Fabio Scotoni <fabio@esse.ch>" in the Author-Part of the man pages, or
> just translate it without any note (It wouldn't be a problem for me)?

I do not see a reason why this could be forbidden ;-)
I think this is your decision.

If you write "translated by ...", people see that you are the original
author and then it could happen that you get patches for that.

If translated manual pages get included into git (I really don't know),
then it may be useful if you write "translated by Fabio Scotoni
<fabio@esse.ch> and the Git list <git@vger.kernel.org>"
(or "... and the git-list <git@vger.kernel.org>", as it can be found
for the authorship in the Documentation/ files.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
