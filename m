From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Future suggestion's to assist with changes to git.
Date: Thu, 28 Aug 2008 17:48:47 -0600
Message-ID: <alpine.LNX.1.10.0808281739160.18129@suse104.zenez.com>
References: <alpine.LNX.1.10.0808281646570.18129@suse104.zenez.com> <20080828233045.GE29609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYrFR-0008MS-4o
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbYH1Xss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYH1Xss
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:48:48 -0400
Received: from suse104.zenez.com ([198.60.105.164]:8342 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYH1Xss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:48:48 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 3345FA7C8E6; Thu, 28 Aug 2008 17:48:47 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 15099A7C8E1;
	Thu, 28 Aug 2008 17:48:47 -0600 (MDT)
In-Reply-To: <20080828233045.GE29609@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94216>

On Thu, 28 Aug 2008, Jeff King wrote:
> On Thu, Aug 28, 2008 at 05:10:53PM -0600, Boyd Lynn Gerber wrote:
>> Maybe on item could be on the git web site news items could be created to
>> announce backward compatibility changes.  I think most people do visit the
>> main website to look for information.  Having these changes posted there
>> or linked from the main page could be a positive method so something like
>> this will not happen in the future.
>
> Do they? I haven't been to the git web site in quite a long time. Nor
> have I been to (for example) the vim web site. The two things I would
> personally notice are:

I only look at the web after reading the release notes.  But I think that 
if the web site had the notice then there could be no excuse about not 
having made it public.  Sure some people do not read the Release notes or 
follow the email lists, but maybe we could get those that miss the release 
notes or new users, a place to look in addition to the email list.  I know 
that it is hard to follow all the mails on the git list.

>  - a note during upgrade of my system's packages. And this is going to
>    be dependent on the packaging system used. 1.6.0 hasn't hit many
>    distributions yet, so maybe there is still time for this. Gerrit,
>    do you mind putting something into NEWS.Debian about the drop of
>    "git-*" so that people with apt-listchanges will see it?
>
>    For people building from source, we have the Release Notes, but
>    beyond that, I don't know where to put it (and I don't meant the web
>    site is a bad place -- the more places the better, but there is no
>    catch-all place).

+1.  I know that I expect break-eges on X.Y for many things.  So maybe a 
note on the website that git uses the second Y for compatiability changes 
could assist some users.

>  - the command complaining that my use of it is deprecated. In
>    retrospect, we probably should have done this.

I really want to make it possible to avoid any of these complaints in the 
future.  I knew it was comming and had to change my scripts, but I am just 
trying to provide further methods to announce changes that some may notice 
that miss the email list message.

I personally look at the change logs and release notes.  If something in 
them makes me really want more information then I go to the project web 
site to look.  I think new users would notice something on the web site 
and then could realise that maybe some example in old documents could have 
problem.  Just my outloud thinking.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
