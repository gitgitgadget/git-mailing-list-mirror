From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 3 Sep 2008 20:38:35 -0600
Message-ID: <alpine.LNX.1.10.0809032035130.16857@suse104.zenez.com>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>  <alpine.LNX.1.10.0809031907540.12887@suse104.zenez.com> <32541b130809031904mb62d13du234da4558bead723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 04:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb4l8-0004HR-J6
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 04:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbYIDCih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 22:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYIDCih
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 22:38:37 -0400
Received: from suse104.zenez.com ([198.60.105.164]:10305 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbYIDCig (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 22:38:36 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id A8041A7C939; Wed,  3 Sep 2008 20:38:35 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 90965A7C935;
	Wed,  3 Sep 2008 20:38:35 -0600 (MDT)
In-Reply-To: <32541b130809031904mb62d13du234da4558bead723@mail.gmail.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94880>

On Wed, 3 Sep 2008, Avery Pennarun wrote:
> On Wed, Sep 3, 2008 at 9:10 PM, Boyd Lynn Gerber <gerberb@zenez.com> wrote:
>> I really hate getting everything working only to then have another break-age
>> from master on a pull.  Can we please try to keep some compatitbility with
>> other non linux OS's.
>
> Well, it's kind of unavoidable; presumably most of the developers
> don't have access to a UnixWare system, and thus have no idea if their
> patches will break compatibility with it.

I offer free access to the OpenServer 6.0, UnixWare 7.1.4 and OpenServer 
5.0.7 to oss developers.  The only condition is the use them for OSS 
development.  Free access is only for non commercial developement.  I do 
have paid access for non OSS.

> Perhaps what you need is an autobuilder running on UnixWare that will
> build Junio's pu and next branches, so that you can report problems
> before they make it all the way into master.
>
> Hey, what a coincidence!  I have just what you need! :)
> http://marc.info/?l=git&m=122015205123247&w=2

I cloned the repo when you announced it.  I was going to get the latest 
git master running and then use them.  I have them.  I hope to have them 
running in the next while.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
