From: Bill Lear <rael@zopyra.com>
Subject: Re: choosing an issue tracker
Date: Wed, 2 Dec 2009 05:54:24 -0600
Message-ID: <19222.21872.425947.273352@lisa.zopyra.com>
References: <4B16331A.3060606@gulfsat.mg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rakotomandimby Mihamina <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Wed Dec 02 12:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFnnC-00066Y-RX
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 12:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbZLBLye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 06:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZLBLye
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 06:54:34 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:36823
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZLBLye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 06:54:34 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id nB2BsWG00755;
	Wed, 2 Dec 2009 05:54:32 -0600
In-Reply-To: <4B16331A.3060606@gulfsat.mg>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134331>

On Wednesday, December 2, 2009 at 12:27:54 (+0300) Rakotomandimby Mihamina writes:
>Hi all,
>
>For a while, I used SVN and Trac.
>They have a satisfying mutual integration.
>
>I am looking for our new issue tracker, and would like to be advised.
>
>Our context:
>- developpers using git, developping
>   - web based applications (PHP, Python, OCaml,...)
>   - Unix-like system maintainance scripts (SHELL, Perl,...)
>- a QA guy that makes functional tests only on the web applications
>   and reports bugs and potential improvements. He does not use git.
>- multiple projects
>
>What we look for:
>something like the (Trac, SVN) but with git as SCM.
>
>What issue tracker would you recommend?

You might be interested in Jira, which I have tied to git with my
open-source niftyism:

http://github.com/rael/git-jira


Bill
