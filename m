From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: does the clone I do have the commits within them .
Date: Tue, 1 Feb 2011 17:47:48 +0300
Message-ID: <20110201174748.a450b30b.kostix@domain007.com>
References: <AANLkTim4EPoYujCcxMMTnOZ4kYR_zG_Nfra2=9am-bLa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vaishali <vaishali.dhakate@sukrutsystems.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 15:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkHWY-0004ih-PZ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 15:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab1BAOsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 09:48:00 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:46412 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab1BAOr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 09:47:59 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id p11Elmmi016722;
	Tue, 1 Feb 2011 17:47:53 +0300
In-Reply-To: <AANLkTim4EPoYujCcxMMTnOZ4kYR_zG_Nfra2=9am-bLa@mail.gmail.com>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165812>

On Tue, 1 Feb 2011 18:50:39 +0530
Vaishali <vaishali.dhakate@sukrutsystems.com> wrote:

>  hi , I am have cloned the
> git://gitorious.org/~dbeck/hawkboard/dbeck-hawkboard-linux-omapl1.git
>   found at
> http://gitorious.org/~dbeck/hawkboard/dbeck-hawkboard-linux-omapl1...
> Now I see there is a tab called Commit log ...The git that I have
> cloned , would it include the commits in totality or will I have to
> do somethng diferent to get the commits into the git that I cloned on
> my PC. git checkout -f master git pull  ... Is this .? Thanks

If I got it right, the question is "does cloning a repository bring
all the data or just changelogs?". In this case the answer is "yes, it
brings all the data". That is, you can check out any commit in the
history record of any branch fetched by git-clone.

As usually, starting from a good book on Git it recommended, see
http://git-scm.com/documentation
