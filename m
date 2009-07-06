From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Mon, 6 Jul 2009 15:31:11 +0300
Message-ID: <94a0d4530907060531n264d416u615f6924969dd277@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
	 <7vprcfj83z.fsf@alter.siamese.dyndns.org>
	 <94a0d4530907051215h755f634bkfd043d88289df29e@mail.gmail.com>
	 <200907052145.27995.jnareb@gmail.com>
	 <94a0d4530907051312u1c4bc811i4015b1eb753a8b1e@mail.gmail.com>
	 <4A51B25C.9040904@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 06 14:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNnLr-0001jQ-AU
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 14:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbZGFMbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2009 08:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZGFMbL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 08:31:11 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57429 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZGFMbK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 08:31:10 -0400
Received: by fxm18 with SMTP id 18so4058734fxm.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uAQb7EsVvMnJjqTV0P/QrvQcy1u0kk9tOmMl4H+BAA0=;
        b=kQaZBV0l7ts7ZJXnIhv8W64xk+gbMMYtgMV4T8jwRLraStue6DVCaxe1CfzfFC7xXd
         yZ6f0+mCqJ8YVp2eXIl6JbVldt18+KDteGbEpiRkPoP3e9B939cYQDNOoXwu/ul+cZi6
         OfthwihPGzwpWP0+rhy2HAWtDjUbr/8cydJ1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=knbbm4nGCIUwVvgrNGrQ9bQXDxebQP0ore8gSu3SEL311CR83oHEhBks+MSjOi6MKL
         JyMFkw2S6pfaO/eKNv989PSyKe2DgvvkzFC7n9Rqk48maIO3XPNgsLrBVvMGirVqvnXx
         opIhZI9HNwC3Mgs6hL9/4X//3QyqLE7/+eQfk=
Received: by 10.86.25.10 with SMTP id 10mr2022417fgy.44.1246883471286; Mon, 06 
	Jul 2009 05:31:11 -0700 (PDT)
In-Reply-To: <4A51B25C.9040904@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122785>

On Mon, Jul 6, 2009 at 11:14 AM, Andreas Ericsson<ae@op5.se> wrote:
> Felipe Contreras wrote:
>>
>> On Sun, Jul 5, 2009 at 10:45 PM, Jakub Narebski<jnareb@gmail.com> wr=
ote:
>>
>>> It's just that somehow for "Git Development Community" a mailing li=
st
>>> is enough. =C2=A0We don't have official git blog, we don't have bug=
tracker
>>> (issue tracker). =C2=A0At the beginning git didn't even had _homepa=
ge_.
>>
>> How do you know that? Have you already asked that question in a surv=
ey
>> already? ;)
>>
>
> The git developer community flourishes without official blogs, and it
> did so even before we had a webpage. In truth, I visit the mailing
> list archives more often than I visit the webpage. It doesn't *need* =
a
> blog (or a forum, or a tracker, or whatever), but some people might
> find such things helpful. Personally, I'm a huge fan of having it all
> in one place.

I'm not saying a blog is needed for git to flourish.

I'm saying a blog would help to send official messages.

>> As an experiment I added http://gitrss.q42.co.uk/announce.rss to my
>> Google Reader, and through some tricks you can actually see how many
>> people are subscribed to that feed: 26. For reference
>> gitlog.wordpress.com has 28, and Planet IM, a relatively unknown
>> planet: 844.
>>
>> And I have many friends who don't follow git's mailing list, so no, =
I
>> don't think a mailing list is enough for official announcements.
>>
>
> There are no forums suitable for everyone who are interested in git
> development. We can (sort of) rely on package maintainers for the
> various distros to keep track of groundbreaking changes. People who
> compile from source are sort of on their own if they don't want to
> follow the mailing list or in some other way find out what's going
> on. I don't have a problem with that, and it matches what I'd have
> expected myself if I was building something from source.

I'm not talking about people that compile git, I'm talking about the
bulk of the users; the ones who use package management to install git
and most of the time don't even know which version they are running
nor what new features are available.

In any case, you think there's no need for a blog, I think there is,
how about the rest of the users? Isn't that a question suitable for
asking in the survey?

--=20
=46elipe Contreras
