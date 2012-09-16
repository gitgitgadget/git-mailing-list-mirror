From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Unable to clone GIT project
Date: Sun, 16 Sep 2012 14:46:51 +0400
Message-ID: <20120916104651.GF32381@localhost.localdomain>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ankush_Aggarwal@DELL.com
X-From: git-owner@vger.kernel.org Sun Sep 16 12:47:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDCNb-0004gi-1M
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 12:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab2IPKrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 06:47:01 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:35468 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2IPKrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 06:47:01 -0400
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q8GAkqB6003655;
	Sun, 16 Sep 2012 14:46:54 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 4319EB23185; Sun, 16 Sep 2012 14:46:52 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205604>

On Sun, Sep 16, 2012 at 03:19:25AM +0000, Ankush_Aggarwal@DELL.com wrote:

> I have created a GIT repository on Linux 64 bit machine.
> 
> When I tried to clone GIT repository on windows 7 machine then I am getting below error. 
> 
> Error:
> git-upload-pack: error while loading shared libraries: libiconv.so.2: cannot open shared object file: No such file or directory
> fatal: The remote end hung up unexpectedly
> 
> anyone please help me resolve the issue.
See [1] and generally search google for msysgit+libiconv.so.2 as it
contains links to other approaches to working around this problem.

Note that questions about technical issues with Git for Windows are
better asked on the msysgit mailing list [2] or in the project bug
tracker [3] (after searching both places for the relevant information).

1. http://groups.google.com/group/msysgit/msg/1c32f034869ffa93
2. http://groups.google.com/group/msysgit/
3. https://github.com/msysgit/msysgit/issues
