From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 16:38:56 -0400
Message-ID: <20060629203856.GG14287@fieldses.org>
References: <20060629194723.GD14287@fieldses.org> <7vd5crranq.fsf@assigned-by-dhcp.cox.net> <20060629202234.GE14287@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 22:39:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw3IK-0006Nz-KZ
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 22:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWF2UjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWF2Ui7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 16:38:59 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41114 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932447AbWF2Ui6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 16:38:58 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fw3Ht-0008GN-0k; Thu, 29 Jun 2006 16:38:57 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060629202234.GE14287@fieldses.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22903>

On Thu, Jun 29, 2006 at 04:22:34PM -0400, bfields wrote:
> I realized after I sent that that "origin" in that public repository actually
> isn't the same as "origin" in the local repo that I'm working on.  So I just
> ran a GIT_DIR=. git-fetch there, and now both branches agree.

By the way, I should also have said:

bfields@puzzle:git$ git --version
git version 1.4.1.rc2

--b.
