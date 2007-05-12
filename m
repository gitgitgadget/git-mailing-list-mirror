From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] link to HTML version of external doc if available
Date: Sat, 12 May 2007 18:59:21 -0400
Message-ID: <20070512225921.GA20785@fieldses.org>
References: <7v3b21281h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 00:59:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn0Yg-0000ZA-KQ
	for gcvg-git@gmane.org; Sun, 13 May 2007 00:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbXELW7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 18:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbXELW7X
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 18:59:23 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33666 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbXELW7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 18:59:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hn0Yb-000885-FM; Sat, 12 May 2007 18:59:21 -0400
Content-Disposition: inline
In-Reply-To: <7v3b21281h.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47106>

On Sat, May 12, 2007 at 11:47:38AM -0700, Junio C Hamano wrote:
> Currently 
> 
> $ git grep '\([^t]\|^\)'link: user-manual.txt
> 
> gives four hits that refer to .txt version of the documentation
> set, but at least "hooks" and "cvs-migration" have HTML variants
> installed, so refer to them instead.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Oops, makes sense to me, thanks!

Acked-by: "J. Bruce Fields" <bfields@citi.umich.edu>

--b.
