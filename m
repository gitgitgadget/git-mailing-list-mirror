From: "Aaron Gray" <angray@beeb.net>
Subject: Re: Does Git run on Windows ?
Date: Thu, 6 Jul 2006 18:18:13 +0100
Message-ID: <003701c6a120$2a15e060$0200a8c0@AMD2500>
References: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500> <46a038f90607051956w72c5e662g72feb242795e61c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 06 19:18:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyXUl-00019R-AP
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 19:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWGFRS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 13:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWGFRS2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 13:18:28 -0400
Received: from lon1-mail-2.visp.demon.net ([193.195.70.5]:31545 "EHLO
	lon1-mail-2.visp.demon.net") by vger.kernel.org with ESMTP
	id S1030311AbWGFRS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 13:18:27 -0400
Received: from AMD2500 (mwgray.force9.co.uk [212.159.110.144])
	by lon1-mail-2.visp.demon.net (MOS 3.5.8-GR)
	with ESMTP id EEI91048 (AUTH angray);
	Thu, 6 Jul 2006 18:18:24 +0100 (BST)
To: "Git Mailing List" <git@vger.kernel.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23398>

>> This maybe the crunch and reason to use CVS for now :(?)
>
> If you are only supporting some users on Windows, you may be able to
> use git-cvsserver for them. Looks like a cvsserver but it is a GIT
> repository ;-)

Thanks. This looks like the best option. Run Git, GitWeb, and git-cvsserver
on our Linux server. Allowing Windows users to connect via CVS and GitWeb.
Nice, looks like the right solution, best of both worlds.

Running Cygwin, Perl, and Python is not really something I could expect of
Windows programmers.

Many thanks,

Aaron
