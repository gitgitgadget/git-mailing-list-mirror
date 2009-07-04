From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Sat, 4 Jul 2009 11:24:40 +0300
Message-ID: <94a0d4530907040124i32abe421x86e5c8f0839bf2fa@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
	 <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
	 <20090704012635.GB39268@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Graham Perks <graham@kace.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 10:24:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MN0YG-0006PL-NC
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 10:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbZGDIYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jul 2009 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbZGDIYj
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 04:24:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:13645 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbZGDIYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jul 2009 04:24:38 -0400
Received: by fg-out-1718.google.com with SMTP id e21so829459fga.17
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OeOX+iFv14yWtaTyQC02ZGGBiBcXLD4C21Vv1EU/WyI=;
        b=c9tIX9N/yoA/wG0r5cH2bYmAY43UOlroijrSbblrA6diflqd3wOy54JzufMuVtAyux
         kNxIMcev7z8VupfZt281nq0iBVkp53mjmT8u9d0Dz336OO9H7xqJmTsq+/Mg/xn/3DLg
         JIidmywSMZFvZJwoRb9PzzCNcDaDvXopAtSns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tlut2A6qQTTeuDLOCSwJoApX4qZhhoj3sTIcazjYRZi5p7IQsPtKOwsqn3fVtuW8o6
         r5DF28rNNuXJulLT0S60tZ1Kk48DGH6pQqIslKPl3+7tH8QCUl4WU1KUkDGA4jj+dlDq
         wJlF3HC+ChLp8CQZfqO3vnYcmQqIn2+/p73oc=
Received: by 10.86.35.18 with SMTP id i18mr1313281fgi.8.1246695880577; Sat, 04 
	Jul 2009 01:24:40 -0700 (PDT)
In-Reply-To: <20090704012635.GB39268@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122715>

On Sat, Jul 4, 2009 at 4:26 AM, David Aguilar<davvid@gmail.com> wrote:
> On Sat, Jul 04, 2009 at 02:19:25AM +0300, Felipe Contreras wrote:
>> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:
>>
>> > 20. Overall, how happy are you with Git?
>> > =C2=A0 =C2=A0* unhappy
>> > =C2=A0 =C2=A0* not so happy
>> > =C2=A0 =C2=A0* happy
>> > =C2=A0 =C2=A0* very happy
>> > =C2=A0 =C2=A0* completely ecstatic
>>
>> Let's leave room for git haters too:
>> =C2=A0* I hate it
>
> Umm, let's not.
>
> If they hate it, they'll be in the "unhappy" category.
> And if they hate it, I doubt they'll be filling out this survey.
>
> I've heard nothing but unhelpful, uneducated, and stubborn words
> from people who "hate git". =C2=A0They usually have nothing productiv=
e
> to say and spend their time complaining about really petty things
> like the fact that they have to paste in a SHA-1 every now and
> then. =C2=A0Worse still, they almost never have constructive
> criticism and thus will always be upset.
>
> Personally, I couldn't care less to hear what they have to
> say. =C2=A0The only thing worse then the haters are the ones who
> actually believe that they would hate hg less
> (even when they've never tried hg!).
>
> Let's not encourage them by including including "I hate git"
> in our survey.

That's a good point, I just thought it would be nice to spot them;
which would be easy if they answer "I hate it". But also, if there's
an extreme positive (completely ecstatic) I thought there should be an
extreme negative, just in case.

Probably not important at all.

Cheers.

--=20
=46elipe Contreras
