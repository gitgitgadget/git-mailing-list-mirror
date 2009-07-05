From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Sun, 5 Jul 2009 23:12:57 +0300
Message-ID: <94a0d4530907051312u1c4bc811i4015b1eb753a8b1e@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
	 <7vprcfj83z.fsf@alter.siamese.dyndns.org>
	 <94a0d4530907051215h755f634bkfd043d88289df29e@mail.gmail.com>
	 <200907052145.27995.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 22:13:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNY5L-0000mw-IG
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 22:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZGEUM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jul 2009 16:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbZGEUM5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 16:12:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:63525 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbZGEUMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 16:12:55 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1082488fga.17
        for <git@vger.kernel.org>; Sun, 05 Jul 2009 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mlSRfvx5I9Zw+HHQchRF4ZbnvDn4hXlLS59Rw/FTCWM=;
        b=P5qgGkply/sN2y8+YlueBSYnQj6lZJPgBYltBtYKoR94eMCirB5wJIYSQD9XgqB8kD
         YLUk2b5PDhYDD9DwZ0gPvYDyB7s1pvJXZkNXCUPhANL51e3DfoqPA0ZbRbbdUcPHMJz0
         5qsXDaVgd8uFOJ/lQFqy67unZ3wU8aqt3qRQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q8edGF4Lbgbg+qwWn6kcEuEy5t6XQc7JuPWsXmDEVXG1dlnFUl0kNOHIxI9qa9c2Iw
         7KXEVNRvrKVHXqRxAC3HF9aMVhtmGCXUB5LVwKPwDdctDyFnsBapbwKcUIRMQQEc1TrF
         e7SLNbASjnBOiDSO9RNZaehgEStJieWKdLbKU=
Received: by 10.86.25.19 with SMTP id 19mr1771614fgy.71.1246824777354; Sun, 05 
	Jul 2009 13:12:57 -0700 (PDT)
In-Reply-To: <200907052145.27995.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122755>

On Sun, Jul 5, 2009 at 10:45 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> On Sun, 5 July 2009, Felipe Contreras wrote:
>> On Sun, Jul 5, 2009 at 9:30 PM, Junio C Hamano<gitster@pobox.com> wr=
ote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> I guess Junio's blog is the most official one ATM,...
>>>
>>> Sorry, don't.
>>>
>>> =C2=A0- Even if you are pretending to be a git community member, yo=
u are merely
>>> =C2=A0 a phoney if you are not reading it.
>>>
>>> =C2=A0- If you want to be up-to-date with what is happening in the =
community,
>>> =C2=A0 you should be reading it. =C2=A0Any important announcement a=
lways will
>>> =C2=A0 appear there.
>>>
>>> That would be an official blog. =C2=A0I do not use mine that way, a=
nd nobody
>>> has to follow it in order to function better in the git land.
>>>
>>> It's like expecting Linus to announce the kernel release in his blo=
g.
>>>
>>> Not going to happen. =C2=A0The official channel of this community h=
as always
>>> been this list.
>>>
>>> I'm OK if somebody declares that he will use his blog to relay impo=
rtant
>>> announcements from this list, to help blog minded people to follow =
it
>>> instead of reading the list.
>
> There is always http://gitrss.q42.co.uk/announce.rss which extracts
> "[ANNOUNCE]" emails from git mailing list into an RSS feed, for those
> who prefer this way of watching for git news.

That's nice, although relatively unknown it seems.

>>> But that won't be me.
>>
>> I know there's no official git blog, I've tried to change that, but =
so
>> far that hasn't happened. IMHO for now the most popular git blog(s)
>> should announce the survey, I'll announce it at gitlog.wordpress.com
>> but it is far from being popular.
>>
>> I understand your position for not making your personal blog the
>> official one; I wouldn't do that on my personal blog either
>> (felipec.wordpress.com) that's why I created a separate blog for tha=
t,
>> where you, or anyone else, can do official git posts instead of on
>> their personal blog.
>
> It's just that somehow for "Git Development Community" a mailing list
> is enough. =C2=A0We don't have official git blog, we don't have bugtr=
acker
> (issue tracker). =C2=A0At the beginning git didn't even had _homepage=
_.

How do you know that? Have you already asked that question in a survey
already? ;)

As an experiment I added http://gitrss.q42.co.uk/announce.rss to my
Google Reader, and through some tricks you can actually see how many
people are subscribed to that feed: 26. For reference
gitlog.wordpress.com has 28, and Planet IM, a relatively unknown
planet: 844.

And I have many friends who don't follow git's mailing list, so no, I
don't think a mailing list is enough for official announcements.

It would be interesting to clone http://gitrss.q42.co.uk/announce.rss
into gitlog.wordpress.com... I'll see if I can find a way to do that
:)

> A propos blogs: Elijah Newren writes from time to time about git
> on http://blogs.gnome.org/newren/ ; I think this blog is in a few
> GNOME planets, so if he were so kind as put announcement there
> when the time comes... =C2=A0It would be good to have such announceme=
nt
> on some blog which is in Perl blog planet (Perlsphere and/or Planet
> Perl Iron Man), and similarly for other communities which rely on
> blogs (KDE, Ruby: anyone?).
>
> There is also http://www.versioncontrolblog.com (which is currently
> off-line, so I can't check who to contact).

Yeap, posting on planets will get a lot of attention.

Cheers.

--=20
=46elipe Contreras
