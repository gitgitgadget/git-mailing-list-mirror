From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: [Foundation-l] Wikipedia meets git
Date: Wed, 21 Oct 2009 22:08:39 +0200
Message-ID: <ee9cc730910211308u5a0284d6he483b0904ddb6068@mail.gmail.com>
References: <ee9cc730910151155w307a87f0w7bba5c4039bb1ef9@mail.gmail.com>
	 <71cd4dd90910170705o7c61e06fuacba41f447571b45@mail.gmail.com>
	 <deea21830910170804s61786d8ewae0bc9390baaed71@mail.gmail.com>
	 <71cd4dd90910170823o3f58b8c2x1d39040e7582634@mail.gmail.com>
	 <ee9cc730910170939m6e83ad2fy5f22a541c3679638@mail.gmail.com>
	 <deea21830910170953o33823dd3rd7a9305f9ea794d@mail.gmail.com>
	 <ee9cc730910171011l1b68a1a0q7096a93c36362959@mail.gmail.com>
	 <e405c96a0910190830y51009225lc72942a703575042@mail.gmail.com>
	 <5396c0d10910210543i4c0a3350je5bee4c6389a2292@mail.gmail.com>
	 <1256154567.1477.87.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Klein <meta.sj@gmail.com>,
	Wikimedia Foundation Mailing List 
	<foundation-l@lists.wikimedia.org>, git <git@vger.kernel.org>
To: Bernie Innocenti <bernie@codewiz.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:08:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hUF-0007Zr-Ns
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZJUUIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 16:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZJUUIh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:08:37 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:52776 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbZJUUIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 16:08:36 -0400
Received: by fxm18 with SMTP id 18so8193111fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y5OsaMqOcaCprpipAS0VUFjCdXmZPOaTTNKFIy0dyDY=;
        b=F3WmPKswl0sDmB6B1NH8OkFic26FInfOGjHM75nGBkZPhbTkG+I4dzo/sKlRj0Hi4l
         ilEzl2aNWWgpGKHRs1IpvCQ8h3WaFs4vyWD4GbhUzR3QicESd2mC53eG8RakSyKEYuHo
         E64qCv8uz5+ZDK3XMs3GQBlT1CnQAdbz4Njrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SrML9JGHVrHt0l4ntYK71ZppE8fKQ/84tiPWvAH4K3Uq/VGGEIvsHfMvjrPNrRJO3e
         YiUI0Q1gYCoVAC/9ufRqvEdfHn+JwhoTzO/letNGGi3g89GpslbV8HuDFD79SYdkN8f0
         C998vADEeck3Bg+B71hKBn3mtTASM9YwqXFL4=
Received: by 10.204.154.85 with SMTP id n21mr8272631bkw.171.1256155720495; 
	Wed, 21 Oct 2009 13:08:40 -0700 (PDT)
In-Reply-To: <1256154567.1477.87.camel@giskard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130958>

Wow,
I am impressed.
Let me remind you of one thing,
most people are working on very small subsets of the data. Very few
people will want to have all the data, think about getting all the
versions from all the git repos, it would be the same.
My idea is for smaller chapters who want to get started easily, or
towns, regions to host their own branches of relevant data.
Given a world full of such servers, the sum would be great but the
individual branches needed at one time would be small.

mike

On Wed, Oct 21, 2009 at 9:49 PM, Bernie Innocenti <bernie@codewiz.org> =
wrote:
> [cc+=3Dgit@vger.kernel.org]
>
> El Wed, 21-10-2009 a las 08:43 -0400, Samuel Klein escribi=F3:
>> That sounds like a great idea. =A0I know a few other people who have
>> worked on git-based wikis and toyed with making them compatible with
>> mediawiki (copying bernie innocenti, one of the most eloquent :).
>
> Then I'll do my best to sound as eloquent as expected :)
>
> While I think git's internal structure is wonderfully simple and
> elegant, I'm a little worried about its scalability in the wiki useca=
se.
>
> The scenario for which git's repository format was designed is "patch
> oriented" revision control of a filesystem tree. The central object o=
f a
> git tree is the "commit", which represents a set of changes on multip=
le
> files. I'll disregard all the juicy details on how the changes are
> actually packed together to save disk space, making git's repository
> format amazingly compact.
>
> Commits are linked to each other in order to represent the history. G=
it
> can efficiently represent a highly non-linear history with thousands =
of
> branches, each containing hundreds of thousands revisions. Branching =
and
> merging huge trees is so fast that one is left wondering if anything =
has
> happened at all.
>
> So far, so good. This commit-oriented design is great if you want to
> track the history *the whole tree* at once, applying related changes =
to
> multiple files atomically. In Git, as well as most other version cont=
rol
> systems, there's no such thing as a *file* revision! Git manages enti=
re
> trees. Trees are assigned unique revision numbers (in fact, ugly sha-=
1
> hashes), and can optionally by tagged or branched at will.
>
> And here's the the catch: the history of individual files is not
> directly represented in a git repository. It is typically scattered
> across thousands of commit objects, with no direct links to help find
> them. If you want to retrieve the log of a file that was changed only=
 6
> times in the entire history of the Linux kernel, you'd have to dig
> through *all* of the 170K revisions in the "master" branch.
>
> And it takes some time even if git is blazingly fast:
>
> =A0bernie@giskard:~/src/kernel/linux-2.6$ time git log =A0--pretty=3D=
oneline REPORTING-BUGS =A0| wc -l
> =A06
>
> =A0real =A0 0m1.668s
> =A0user =A0 0m1.416s
> =A0sys =A0 =A00m0.210s
>
> (my laptop has a low-power CPU. A fast server would be 8-10x faster).
>
>
> Now, the English Wikipedia seems to have slightly more than 3M articl=
es,
> with--how many? tenths of millions of revisions for sure. Going throu=
gh
> them *every time* one needs to consult the history of a file would be
> 100x slower. Tens of seconds. Not acceptable, uh?
>
> It seems to me that the typical usage pattern of an encyclopedia is t=
o
> change each article individually. Perhaps I'm underestimating the rol=
e
> of bots here. Anyway, there's no consistency *requirement* for mass
> changes to be applied atomically throughout all the encyclopedia, rig=
ht?
>
> In conclusion, the "tree at a time" design is going to be a performan=
ce
> bottleneck for a large wiki, with no useful application. Unless of
> course the concept of changesets was exposed in the UI, which would b=
e
> an interesting idea to explore.
>
> Mercurial (Hg) seems to have a better repository layout for the "one
> file at a time" access pattern... Unfortunately, it's also much slowe=
r
> than git for almost any other purpose, sometimes by an order of
> magnitude. I'm not even sure how well Hg would cope with a repository
> containing 3M files and some 30M revisions. The largest Hg tree I've
> dealt with is the "mozilla central" repo, which is already unbearably
> slow to work with.
>
> It would be interesting to compare notes with the other DSCM hackers,
> too.
>
> --
> =A0 // Bernie Innocenti - http://codewiz.org/
> =A0\X/ =A0Sugar Labs =A0 =A0 =A0 - http://sugarlabs.org/
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
