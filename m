From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Compiling git for Windows
Date: Thu, 27 Feb 2014 14:30:10 +0400
Message-ID: <20140227143010.85055162886495c17a6cb232@domain007.com>
References: <CAHd499Cr2g0MZs2XBCC-zZqjHeffqO0LXoP1ViaFOjQhTuPKzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 11:39:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIyNL-0007Z5-VN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 11:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbaB0Kjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 05:39:31 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:51789 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaB0Kja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 05:39:30 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 05:39:30 EST
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s1RAUA4K017521;
	Thu, 27 Feb 2014 14:30:11 +0400
In-Reply-To: <CAHd499Cr2g0MZs2XBCC-zZqjHeffqO0LXoP1ViaFOjQhTuPKzw@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242801>

On Wed, 26 Feb 2014 12:23:35 -0600
Robert Dailey <rcdailey.lists@gmail.com> wrote:

> Oddly I'm not able to find any instructions on how to build Git for
> Windows. I've done a clone of the repository here:
> 
> https://github.com/msysgit/git
> 
> I did attempt to try doing it myself. I installed 'make' and mingw-gcc
> in Cygwin and attempted 'make' from the git directory but it fails
> immediately (I can post information on the failure if needed, but I'm
> assuming I'm not taking the correct approach).
> 
> Can someone point me to some instructions on how to build Git for
> Windows? Thanks.

https://github.com/msysgit/msysgit/wiki/InstallMSysGit
and then
https://github.com/msysgit/msysgit/wiki/WorkingOnMsysGit

You might want to start at the README at
https://github.com/msysgit/msysgit
and then navigate to the wiki:
https://github.com/msysgit/msysgit/wiki
