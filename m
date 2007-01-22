From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 17:27:26 -0800
Message-ID: <7vk5zfyhoh.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<20070121134308.GA24090@1wt.eu>
	<7v7ivg1a25.fsf@assigned-by-dhcp.cox.net>
	<200701212001.l0LK1ofV022758@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, hpa@zytor.com
X-From: git-owner@vger.kernel.org Mon Jan 22 02:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8nyE-0008Aj-Lo
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXAVB13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbXAVB13
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:27:29 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:50750 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbXAVB12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:27:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122012727.EDNY29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 20:27:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E1Tk1W00w1kojtg0000000; Sun, 21 Jan 2007 20:27:45 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701212001.l0LK1ofV022758@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Sun, 21 Jan 2007 17:01:50 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37377>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Willy Tarreau <w@1wt.eu> writes:
>> > Anything you can do to make tester's life easier will always slightly
>> > increase the number of testers.
>> > ...
>> > Pre-release tar.gz and rpms coupled with a freshmeat announcement should
>> > get you a bunch of testers and newcomers. This will give the new doc a
>> > real trial, and will help discover traps in which beginners often fall.
>> 
>> One worry I had about releasing git-1.5.0-rc2-1.rpm and friends
>> just like the "official" ones was that people might have scripts
>> to automate downloading & updating of packages, and they may not
>> like to get "beta" installed for them.
>
> Then put them into a "testing" or "pre-release" directory...

Ok, thanks for the suggestion.

The preview RPMs for i386 and x86_64 and an SRPM are available at:

	/pub/software/scm/git/testing/

The tarball for 1.5.0-rc2 is found at:

	/pub/software/scm/git/git-1.5.0.rc2.tar.gz

along with tarballs of preformatted htmldocs and manpages.
