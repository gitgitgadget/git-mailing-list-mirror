From: Dill <sarpulhu@gmail.com>
Subject: Re: Git Wiki improvements
Date: Sun, 13 Apr 2008 18:47:37 -0700 (PDT)
Message-ID: <0c43e61a-af62-4bee-88de-f3a62948bb58@f63g2000hsf.googlegroups.com>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca> 
	<200804140303.22624.jnareb@gmail.com> <1208137224.2867.110.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 03:48:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlDo2-0006Gv-Cl
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 03:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYDNBrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbYDNBrm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 21:47:42 -0400
Received: from wr-out-0708.google.com ([64.233.184.243]:57000 "EHLO
	wr-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbYDNBrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 21:47:41 -0400
Received: by wr-out-0708.google.com with SMTP id c7so3441949wra.5
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 18:47:38 -0700 (PDT)
Received: by 10.100.239.11 with SMTP id m11mr385265anh.14.1208137657984; Sun, 
	13 Apr 2008 18:47:37 -0700 (PDT)
In-Reply-To: <1208137224.2867.110.camel@localhost.localdomain>
X-IP: 207.236.24.133
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 
	1.1.4322; InfoPath.1),gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79451>

Interesting. I like how kernel.org uses the same software as
wikipedia. More familiar. Plus I probably would trust kernel.org more
than wikidot.com being more reliable. If it was indeed moved to
kernel.org I volunteer to help port and transfer the data over.

On Apr 13, 7:40=A0pm, "J.H." <wartho...@eaglescrag.net> wrote:
> Depending on the level of customization your really looking for, you
> could always make a request to kernel.org to host the wiki ( already
> hosting ext4.wiki.kernel.org, btrfs.wiki.kernel.org,
> moin.wiki.kernel.org, etc)
>
> It's running a shared hosted version of mediawiki, however I know for=
 a
> fact the admin doesn't want to do *too* much customization of the
> underlying wiki and doesn't have a lot of time to devote to it, he's
> good at keeping it running but the content / customization would need=
 to
> be handled by a more dedicated person.
>
> - John 'Warthog9' Hawley
>
>
>
>
>
> On Mon, 2008-04-14 at 03:03 +0200, Jakub Narebski wrote:
> > [Cc: g...@vger.kernel.org, Petr Baudis <pa...@suse.cz>]
>
> > Pack, Dylan wrote:
> > > Jakub Narebski wrote
> > >> On Mon, 14 April 2008, Pack, Dylan wrote:
>
> > >>> I've noticed to that the wiki gets mixed up if I use the GUI ed=
itor.
> > >>> Looks like I'm going to have the syntax after all of well.
>
> > >> Unfortunately Git Wiki administrator (Petr Baudis, who also main=
tains
> > >> git homepage), doesn't have much time to spend on configuring wi=
ki,
> > >> and doesn't know well MoinMoin. =A0The problem seems to lie in t=
he fact
> > >> that Wikipedia-like (or rather MediaWiki-like) syntax provided b=
y
> > >> (I guess) media4moin plugin doesn't modify GUI editing. =A0This =
affect
> > >> mosts macros, which in default MoinMoin syntax are written as
> > >> e.g. [[BR]], while Wikipedia-like syntax uses e.g. {{BR}}.
>
> > > Perhaps a move to wikidot.com would work? They have an awesome se=
t up
> > > for wikis. I've tried them out and they are fast and always impro=
ving
> > > the wiki. We could even add google adsense on the wikidot site fo=
r
> > > money to be put into various git projects decided on by the
> > > developers. Not sure how much money though a git wiki site would =
make.
>
> > I'm not sure if it is a good idea. =A0We would loose a bit control,=
 and
> > would have git homepage and git wiki in separate domains. =A0On the=
 other
> > hand some of admin stuff would be passed to wiki hosting site. =A0
> > Bazaar-NG, Mercurial and Monotone (and also Emacs) have their own s=
elf
> > hosted wikis.
>
> > Git homepage at git.or.cz (or git-scm.org), Git Wiki at
> > git.or.cz/gitwiki and free git hosting at repo.or.cz are all provid=
ed
> > by Petr 'Pasky' Baudis (thanks a lot, again!).
>
> > By the way, Git Wiki initially began as a "staging ground" for cont=
ents
> > which would get incorporated into Git Homepage...
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majord...@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html-=
 Hide quoted text -
>
> - Show quoted text -
