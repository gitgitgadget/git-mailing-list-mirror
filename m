From: Dill <sarpulhu@gmail.com>
Subject: Re: RFC: Website redesign
Date: Mon, 14 Apr 2008 08:38:25 -0700 (PDT)
Message-ID: <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com> 
	<2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 17:57:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlQm5-0004MH-A1
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 17:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759543AbYDNPi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 11:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758967AbYDNPi3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 11:38:29 -0400
Received: from ag-out-0910.google.com ([72.14.246.184]:17824 "EHLO
	ag-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758312AbYDNPi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 11:38:28 -0400
Received: by ag-out-0910.google.com with SMTP id 40so3132328agd.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 08:38:25 -0700 (PDT)
Received: by 10.100.136.15 with SMTP id j15mr432445and.21.1208187505737; Mon, 
	14 Apr 2008 08:38:25 -0700 (PDT)
In-Reply-To: <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
X-IP: 161.184.192.94
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) 
	Gecko/20080311 Firefox/2.0.0.13,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79511>

Isn't it possible to set up a git repo that has all the web page files
and have it set up so the web site updates from that repo. Or just
have Petr run a few commands. Or maybe that's what happens already.
Then allow a few people to write to that repo. As far as the news go,
the web page I set up is easily edited by hand and updated it's just
how do we quickly allow updates without bothering people. Heres some
more designs:

http://sarpulhu.googlepages.com/git5
http://sarpulhu.googlepages.com/git6  -my personal favorite
http://sarpulhu.googlepages.com/git7

Jonas Fonseca wrote:
> Hello Dill,
>
> On Mon, Apr 14, 2008 at 7:37 AM, Dill <sarpulhu@gmail.com> wrote:
> > I was looking at the main git site and thought that maybe it could be
> >  done differently. I tried to make it simple and professional looking
> >  and have all the same information as the old site. I've spend a good
> >  portion of the day hashing it out and wanted to hear what others
> >  thought. Worth changing? Like it or not?
>
> Yes, it is definitely worth changing. In all the user surveys to date people
> has commented on the design of the git homepage mentioning words like
> ugly, not useful, strangely named, etc. After the last survey I registered
> git-scm.org to have a more friendly name.
>
> Question is what kind of "official" home page is suitable for git? As it is now,
> most projects using git provides documentation for what kind of workflow
> they recommend for their specific project, and else the git distribution point
> on kernel.org has the latest manpages, tutorials etc. supplemented by the
> git wiki.
>
> Your examples capture this very good in the sense that the homepage should
> basically be a very simple page that send visitors in the "right" direction for
> getting documentation, downloading the latest release, and joining the
> community.
> I like the restlet.org page with its four basic tasks. As your
> examples also suggest
> and as a fourth task, it could be nice to also in time fill the void
> of having a news
> source about git related releases, developer interviews, GSoC info, the Msysgit
> Herald, and other interesting stuff happening in the community for people who do
> not feel they have the time to read the mailing list. This of course
> requires that there
> is a small dedicated team for collecting and preparing these updates. I would be
> willing to help, but have occasional fall-outs where I do not read the
> mailing list.
>
> Regarding the design/style etc, I am credited for the current one that
> Petr forked from
> the ELinks homepage. It is ugly, and git deserved better! This is just
> to say that I probably
> shouldn't be part of this work. I find your redesign proposal 1, 3 and
> 4 a too dark or gray.
> Number 2 (git2) with its bluish has some nice ideas. The text might be
> too small, at least
> from what I am seeing and the list menu has a strange coloring.
>
> If the home page should carry news it needs to have infrastructure so
> that we don't need
> to bug Petr each time it should be updated. I have commit access to
> the git-homepage
> repo and maybe Petr could add others as well, but the question is if
> we want some web
> interface for submitting news. I registered git-scm.org after the last
> survey and right now
> it is just set up as an alias for git.or.cz. It comes with some PHP
> capability which could
> serve as a place to develop a redesign, however, I am not hosting it
> myself and I don't
> know what kind of traffic will be required.
>
> --
> Jonas Fonseca
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
