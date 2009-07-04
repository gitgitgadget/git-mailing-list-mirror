From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Sun, 5 Jul 2009 02:53:09 +0300
Message-ID: <94a0d4530907041653n46c082e2ta5141e917f5bd84f@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
	 <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
	 <200907050040.21991.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 01:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNF2r-00066d-06
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 01:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbZGDXxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jul 2009 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbZGDXxK
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 19:53:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:47362 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbZGDXxJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jul 2009 19:53:09 -0400
Received: by fg-out-1718.google.com with SMTP id e12so345200fga.17
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D6Loa/Bl6ngkGzfmgRlhfJEJDe+lfTaSqgZDT7eM/HQ=;
        b=VDtQ+RwAgEeBIw37ASKRjWYAMXIztFTlnKVOiEQEruZE2ntbssM1lGaxaD5i17sNfV
         h/3FsKMGcKi2W0t7VzhMYic0FOsTOAS2gVTbxnSQW/f9lC8JVXybWM/83GRy7aS5+2++
         fVMe9oubjTbz4PvpSSd8C2+5K18ThHGaY6Jyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rGDuH7I0h7sNxSDYrA0hSUZSRdYqXWdgvRjU0r0imAv/2LMEWrbH9OQ2Xja0ke1eaJ
         ORzShMbaArGbdmLr38hgvDg2viqu3WehQQOjkHbo9AGz/u05miBa/NnqchYeIrLW9iad
         KV20QM1Dxo5tEEsNlDw+8AOWgmk8t0OKY3Lm8=
Received: by 10.86.58.9 with SMTP id g9mr1549437fga.18.1246751590185; Sat, 04 
	Jul 2009 16:53:10 -0700 (PDT)
In-Reply-To: <200907050040.21991.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122733>

On Sun, Jul 5, 2009 at 1:40 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> On Sat, 4 July 2009, Felipe Contreras wrote:
>> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:
>
>> > The last replacements reminds me of the problem of announcing this
>> > survey. =C2=A0Where to submit note announcing "Git User's Survey 2=
009"
>> > (tentative date of survey is 15 July 2009 -- 15 September 2009)?
>> > How such note should look like?
>>
>> I'm not sure what you mean. I think the best place to announce these
>> kinds of things is through a post in an official blog.
>
> The problem is that there isn't "official blog" for Git. =C2=A0There =
is
> gitster's (Junio C Hamano, git maintainer) blog at
> =C2=A0http://gitster.livejournal.com/
> there is yours 'A git blog looking to be official' at
> =C2=A0http://gitlog.wordpress.com/

I guess Junio's blog is the most official one ATM, but I'll post it on =
mine too.

And as I said before, if anyone wants to post in gitlog.wordpress.com
I can give you permissions; I don't want it to be *my* blog.

> Let me quote appropriate question from "Git User's Survey 2009" which
> lists possible announcement mechanisms I did think of:
>
> =C2=A029. How did you hear about this Git User's Survey?
> =C2=A0 =C2=A0* git mailing list
> =C2=A0 =C2=A0* git-related mailing list (msysGit, Git for Human Being=
s, ...)
> =C2=A0 =C2=A0* mailing list or forum of some project
> =C2=A0 =C2=A0* #git IRC channel topic
> =C2=A0 =C2=A0* announcement on IRC channel
> =C2=A0 =C2=A0* git homepage
> =C2=A0 =C2=A0* git wiki
> =C2=A0 =C2=A0* git hosting site
> =C2=A0 =C2=A0* software-related web site
> =C2=A0 =C2=A0* news web site or social news site
> =C2=A0 =C2=A0* blog
> =C2=A0 =C2=A0* other kind of web site
> =C2=A0 =C2=A0* Twitter or other microblogging platform
> =C2=A0 =C2=A0* other - please specify
>
> I will send announcement to Git mailing list (i.e. here) using
> "[ANNOUNCE]" in email subject, which means that 'GIT Mailing List
> RSS Feeds' script would pick it up for 'announce' feed
> =C2=A0http://gitrss.q42.co.uk/announce.rss
> which means that Ohloh would have it in "News" section for Git projec=
t:
> =C2=A0http://www.ohloh.net/p/git
> (and it is easy to add announcement in "Journal Entries" at Ohloh).
>
> I can add announcement about Git User's Survey 2009 at Git Wiki and
> create page about it at
> =C2=A0http://git.or.cz/gitwiki/GitSurvey2009
> I can ask Scott Chacon to put announcement on Git Homepage at
> =C2=A0http://git-scm.com
>
> What other places to ask to put note about this survey? =C2=A0For pas=
t
> surveys I was sending announcement to mailing list of projects using
> git (http://git.or.cz/gitwiki/GitProjects)... well, at least those
> which didn't require subscribing to mailing list before postiting on
> it (and even that for some cases can be worked around by sending
> announcement via GMane). =C2=A0But with number of projects using git =
so
> large nowadays I don't think it is good approach...

I would recommend against posting on client projects; IMHO that's a bit=
 spammy.

How about contacting big hosting sites; sourceforge, github, gitorious,=
 etc. ?

--=20
=46elipe Contreras
