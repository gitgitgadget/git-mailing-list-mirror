From: Dill <sarpulhu@gmail.com>
Subject: Re: Git Wiki improvements
Date: Sun, 13 Apr 2008 19:25:41 -0700 (PDT)
Message-ID: <8c25cb7a-a544-4464-b0ac-c95f99b349a0@2g2000hsn.googlegroups.com>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca> 
	<200804140303.22624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 04:26:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlEP3-00044E-GE
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 04:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbYDNCZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 22:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753864AbYDNCZn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 22:25:43 -0400
Received: from yw-out-2122.google.com ([74.125.46.25]:59460 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbYDNCZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 22:25:42 -0400
Received: by yw-out-2122.google.com with SMTP id 1so949731ywp.61
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 19:25:41 -0700 (PDT)
Received: by 10.100.154.9 with SMTP id b9mr387907ane.7.1208139941753; Sun, 13 
	Apr 2008 19:25:41 -0700 (PDT)
In-Reply-To: <200804140303.22624.jnareb@gmail.com>
X-IP: 207.236.24.133
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 
	1.1.4322; InfoPath.1),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79452>

The more I think of it... maybe it's best to leave the wiki alone.
It's not broken...it's just not great. Maybe we should just leaves
things as they are? I'm sure we can work around the problems the
software sometimes gives us. But on the other hand a move to
git.kernel.org would be easier to use it's just a lot of work to move
it over there. Anyone else have complaints about the wiki? Or maybe
I'm the only one. ;)

On Apr 13, 7:03=A0pm, Jakub Narebski <jna...@gmail.com> wrote:
> [Cc: g...@vger.kernel.org, Petr Baudis <pa...@suse.cz>]
>
>
>
>
>
> Pack, Dylan wrote:
> > Jakub Narebski wrote
> >> On Mon, 14 April 2008, Pack, Dylan wrote:
>
> >>> I've noticed to that the wiki gets mixed up if I use the GUI edit=
or.
> >>> Looks like I'm going to have the syntax after all of well.
>
> >> Unfortunately Git Wiki administrator (Petr Baudis, who also mainta=
ins
> >> git homepage), doesn't have much time to spend on configuring wiki=
,
> >> and doesn't know well MoinMoin. =A0The problem seems to lie in the=
 fact
> >> that Wikipedia-like (or rather MediaWiki-like) syntax provided by
> >> (I guess) media4moin plugin doesn't modify GUI editing. =A0This af=
fect
> >> mosts macros, which in default MoinMoin syntax are written as
> >> e.g. [[BR]], while Wikipedia-like syntax uses e.g. {{BR}}.
>
> > Perhaps a move to wikidot.com would work? They have an awesome set =
up
> > for wikis. I've tried them out and they are fast and always improvi=
ng
> > the wiki. We could even add google adsense on the wikidot site for
> > money to be put into various git projects decided on by the
> > developers. Not sure how much money though a git wiki site would ma=
ke.
>
> I'm not sure if it is a good idea. =A0We would loose a bit control, a=
nd
> would have git homepage and git wiki in separate domains. =A0On the o=
ther
> hand some of admin stuff would be passed to wiki hosting site. =A0
> Bazaar-NG, Mercurial and Monotone (and also Emacs) have their own sel=
f
> hosted wikis.
>
> Git homepage at git.or.cz (or git-scm.org), Git Wiki at
> git.or.cz/gitwiki and free git hosting at repo.or.cz are all provided
> by Petr 'Pasky' Baudis (thanks a lot, again!).
>
> By the way, Git Wiki initially began as a "staging ground" for conten=
ts
> which would get incorporated into Git Homepage...
>
> --
> Jakub Narebski
> Poland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html-=
 Hide quoted text -
>
> - Show quoted text -
