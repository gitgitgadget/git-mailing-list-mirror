From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Refactor project list routines
Date: Fri, 6 Nov 2009 16:22:54 +0100
Message-ID: <20091106152254.GH17748@machine.or.cz>
References: <1257520255-12698-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 16:23:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6QeU-0008AH-C1
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758850AbZKFPWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758489AbZKFPWv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:22:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43138 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbZKFPWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 10:22:51 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9479486201A; Fri,  6 Nov 2009 16:22:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257520255-12698-1-git-send-email-pasky@suse.cz>
 <1257520265-16699-1-git-send-email-pasky@suse.cz>
 <1257520246-6548-1-git-send-email-pasky@suse.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132308>

  Oops, I'm sorry, I expected tg mail to submit the mails in series...
The correct order is:

	[PATCH] gitweb: Refactor project list routines
	[PATCH] gitweb: Support for no project list on gitweb front page
	[PATCH] gitweb: Polish the content tags support

(The blob linenr patch is independent.)

				Petr "Pasky" Baudis
