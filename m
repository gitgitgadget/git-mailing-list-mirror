From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 17:24:26 +0200
Message-ID: <4d8e3fd30605030824v40017178o366a9d8aa83557e8@mail.gmail.com>
References: <20060502232553.GL27689@pasky.or.cz>
	 <7virooj92i.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com>
	 <20060503090007.GM27689@pasky.or.cz>
	 <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com>
	 <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
	 <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Nicolas Pitre" <nico@cam.org>, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 17:25:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbJDm-0005O9-Bm
	for gcvg-git@gmane.org; Wed, 03 May 2006 17:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbWECPY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 11:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWECPY2
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 11:24:28 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:38073 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965210AbWECPY1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 11:24:27 -0400
Received: by py-out-1112.google.com with SMTP id x31so246696pye
        for <git@vger.kernel.org>; Wed, 03 May 2006 08:24:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KT8jklH1SmwsAeoNvFddyGeUx4Yv/E9/6NZVXxxONogILQaK/ssgx3qWiIwLE7a0dMZFdZ+JhGjYGx7w2dZ+CrjneJwKU7y8T2zdqqAb+3ykqhc4naiaz+Qbct6VdCwyUh+WWxJ+JIVZVcsVmzoUolhhju0k4SVOnmHOTVajRew=
Received: by 10.35.70.17 with SMTP id x17mr1376016pyk;
        Wed, 03 May 2006 08:24:26 -0700 (PDT)
Received: by 10.35.26.15 with HTTP; Wed, 3 May 2006 08:24:26 -0700 (PDT)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <4458C5D7.8010501@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19489>

On 5/3/06, Andreas Ericsson <ae@op5.se> wrote:
> >>On Wed, 3 May 2006, Paolo Ciarrocchi wrote:
> >>
> >>>On 5/3/06, Petr Baudis <pasky@suse.cz> wrote:
> >>>
> >>>>Dear diary, on Wed, May 03, 2006 at 10:39:07AM CEST, I got a letter
> >>>>where Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> said that...
> >>>>
> >>>>>On 5/3/06, Junio C Hamano <junkio@cox.net> wrote:
> >>>>>
> >>>>>BTW, do you know why GIT has not been selected as SCM for OpenSolaris?
> >>>>>(they choose Mercurial).
> >>>>
> >>>>I think it's explained somewhere in their forums (or mailing lists or
> >>>>whatever they actually _are_).
> >>>
> >>>I only found the announcement, not the rationales.
> >>
> >>http://mail.opensolaris.org/pipermail/tools-discuss/2006-April/000366.html
> >>
> >>Looks like they didn't buy the argument about the uselessness of
> >>recording file renames.
> >
> >
> > The final evaluations are available from here (at the very bottom
> > of the page):
> >
> >   http://opensolaris.org/os/community/tools/scm/
> >
> > It looks like Mercurial doesn't support renames either, but a lot
> > of users are asking for it to be supported.  So I don't think that's
> > the reason.  It looks more like they didn't enjoy porting GIT 1.2.2
> > (as 1.2.4 was found to not work in all cases) to Solaris and the
> > tester ran into some problems with the conflict resolution support.
> >
> > My own reading of the two final evaluations for GIT and Mercurial
> > leaves me feeling like GIT is a more mature tool which is faster
> > and more stable then Mercurial.  GIT seemed to be more reliable
> > during testing then Mercurial was, despite the cloning issue.
> > Which makes me surprised that OpenSolaris selected Mercurial instead.
> >
>

Would be fantastic to see a fair comparison of the two tools but I
can't find anything useful on the web.

--
Paolo
http://paolociarrocchi.googlepages.com
