From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Fix typo in remote branch example in git user manual
Date: Tue, 5 Jun 2007 18:46:35 -0400
Message-ID: <20070605224635.GG2352@fieldses.org>
References: <20070605084751.23322.qmail@fcde833ae749fc.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 00:46:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvhnZ-00049Y-AV
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 00:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215AbXFEWqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 18:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762644AbXFEWqh
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 18:46:37 -0400
Received: from mail.fieldses.org ([66.93.2.214]:49809 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758215AbXFEWqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 18:46:36 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HvhnP-0005Nq-Fd; Tue, 05 Jun 2007 18:46:35 -0400
Content-Disposition: inline
In-Reply-To: <20070605084751.23322.qmail@fcde833ae749fc.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49234>

On Tue, Jun 05, 2007 at 08:47:51AM +0000, Gerrit Pape wrote:
> In Documentation/user-manual.txt the example
>  $ git checkout --track -b origin/maint maint
> under "Getting updates with git pull", should read
>  $ git checkout --track -b maint origin/maint

Yep, thanks for the fix!--b.
