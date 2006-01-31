From: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 21:56:48 +0100 (CET)
Message-ID: <29639.194.237.142.10.1138741008.squirrel@194.237.142.10>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> 
    <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> 
    <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> 
    <1138446030.9919.112.camel@evo.keithp.com> 
    <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> 
    <20060130185822.GA24487@hpsvcnb.fc.hp.com> 
    <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
     <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org>
    <1138734110.18852.26.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, keithp@keithp.com,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Carl Baldwin" <cnb@fc.hp.com>, "Junio C Hamano" <junkio@cox.net>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 21:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F42Zj-00032V-9K
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 21:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWAaU4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 15:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWAaU4x
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 15:56:53 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:61969 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S1751479AbWAaU4t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 15:56:49 -0500
Received-SPF: none (dslsmtp.struer.net: 62.242.36.15 is neither permitted nor denied by domain of ravnborg.org) client-ip=62.242.36.15; envelope-from=sam@ravnborg.org; helo=squirrelmail.post1.dk;
Received: from squirrelmail.post1.dk (unknown [62.242.36.15])
	by dslsmtp.struer.net (Postfix) with ESMTP id 4DE219373;
	Tue, 31 Jan 2006 21:56:48 +0100 (CET)
Received: from 194.237.142.10
        (SquirrelMail authenticated user sam@ravnborg.org);
        by squirrelmail.post1.dk with HTTP;
        Tue, 31 Jan 2006 21:56:48 +0100 (CET)
In-Reply-To: <1138734110.18852.26.camel@evo.keithp.com>
To: "Keith Packard" <keithp@keithp.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15343>

> As a newly initiated user, this would have been a more gentle
> introduction to the system. But, it would be hard to make it entirely
> invisible given the current interfaces. I'm not sure if obscuring the
> presense of the index is a great plan; it's already hard enough to
> figure out how it works.

I have found myself using a mixture of cogito and git commands lately.
Part of it being that my finger type something like:
rm `git ls-files -m`
cg-restore

and I have not convinced them about git reset --hard


But the primary thing is cg-commit
I give you a list of files modified which can be edited and
it have saved me a couple of times commiting to much.
And I get vi fired up so no need to fiddle with command line argumetns.

   Sam
