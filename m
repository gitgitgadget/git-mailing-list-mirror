From: David Bainbridge <david.bainbridge@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sun, 4 Jul 2010 22:48:45 +0200
Message-ID: <AANLkTim0HypdTEwsTUQ-G8C3mAoZ-7Ro3zB4z7-hpFq2@mail.gmail.com>
References: <201007032158.57700.jnareb@gmail.com>
	<AANLkTimbpOEpi8QOqTOMav0whmLeHz3vQq_0KDnblRIK@mail.gmail.com>
	<201007041314.50591.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 22:49:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVW8U-0002dv-No
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 22:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757987Ab0GDUsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 16:48:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37000 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977Ab0GDUsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jul 2010 16:48:46 -0400
Received: by pxi14 with SMTP id 14so1446031pxi.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=68K8MlE9V/8/3VXW4ywkr7v3L9oTkR0VZcNMYuDC2EE=;
        b=As3uhiutB8UKhXdMj2olZNydvNP5XCHDQ6ZHdpGngRk1Fbtc94zA1JxkcOgiMehmWM
         6tyAv7VnOaOK7POJS2XHM3rouytQQL0SMh8IKEiQc8o1I0x0Tiqje8i0m9ZPjM3s8bYE
         cNFQ0WLlHBLE2tDbugvsUDrW5psVOxl/lv6Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pximRIrNlk6LaBrmI1AD9usmVR6QWu1qL/KlK8uksRu497c8YQVtGZu9YyoLZ1krSQ
         cU3cDJ1ehlqokQuP2PLleZL0DT/k9xHiyGXvcS6jCIrO36TJtl9nHoRxdYKrlEoA7pDf
         Auyu+vI5Qbnp+TH7+bkYX7iAgsxLlj5MQHOnU=
Received: by 10.142.178.2 with SMTP id a2mr2308809wff.139.1278276525499; Sun, 
	04 Jul 2010 13:48:45 -0700 (PDT)
Received: by 10.142.70.11 with HTTP; Sun, 4 Jul 2010 13:48:45 -0700 (PDT)
In-Reply-To: <201007041314.50591.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150229>

Hi Jakub,

It sounds like I was revisiting old territory in some cases :-)

The thoughts about free text analysis were interesting though ...

On 4 July 2010 13:14, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 4 July 2010, David Bainbridge wrote:
>
>> Have you considered the question: 'How long have you been using Git?=
'.
>> This combined the expertise level might yield some useful informatio=
n,
>> and could provide some weighting for the 'Getting started' questions
>> too. There are some problems with the question in that it could be,
>> say, 2 years intermittent use, or 2 years continuous use, and these
>> are different, of course.
>
> Well, such question was replaced by the question about one's own
> proficiency in Git in 2009 survey (IIRC).
>
>> > =3D=3D=3D 06. Rate your own proficiency with Git: =3D=3D=3D
>> > (single choice)
>> >
>> > =A0* 1. novice
>> > =A0* 2. casual, needs advice
>> > =A0* 3. everyday use
>> > =A0* 4. can offer advice
>> > =A0* 5. know it very well
>
> The problem with question "How long have you been using Git?" (beside
> what you have mentioned) is that it is hard to answer correctly / in
> detail for longer times.
>
> Perhaps something like this:
>
> =3D=3D=3D xx. How long have you been using Git? =3D=3D=3D
> (single choice, with other)
>
> =A0* less than week
> =A0* between a week and a month
> =A0* a few months
> =A0* a few years
> =A0* duration (please give units)
>
> What do you think?

I think that the granularity is about right. I think we could imagine
where we would expect people to be proficiency-wise with those
periods. Not sure about the last option ... You have everything from
days, to weeks to months to years in the main options. What did you
have in mind?

>
>> The demographic information is useful if you want to understand
>> whether Git is (for example) considered less usable in countries whe=
re
>> English is not the native language. But then if you want to know the
>> native language of the user rather than where they live then perhaps
>> this should be asked? (I was born in the UK, but now live in Sweden
>> ... so I am perhaps more conscious of this!). Where you are born doe=
s
>> not necessarily identify your native language either.
>
> The problem with this question in the past was twofold: first, people
> sometimes mistok it for question about _programming languages. =A0Sec=
ond
> should this question be about primary language / languages, or about
> language ones prefer the computer to communicate with?

Obviously you have been though this loop before! But perhaps if you
are using drop-down lists then this makes it obvious what is required.
I guess both the programming language, and the preferred interaction
language could be relevant.

We may want to know whether Git is more 'acceptable' to the Java
community or the C/C++ community for example, or whether certain
suggestions for improvement are coming from a community around a
particular language.

Then with the human languages this could drive the localization of the
commands, as well as the documentation localization. Interesting ...

>
>> Do you want to separate work usage and 'non-work' usage at all? The
>> two experiences may be completely different. If I am working at home=
 I
>> can use what ever I want, and work how I want. This will probably no=
t
>> be the case in a corporate environment, so I would report one set of
>> results for 'work' and another for 'non-work'. This could generate t=
wo
>> survey returns for a single user. Is this intended?
>
> Hmmmm... food for though. =A0It can be mentioned somewhere close to
> beginning that one can fill this survey more than once (from differen=
t
> computers if using default version with cookies) for different roles
> one plays. =A0Perhaps with checkbox "additional role" (aka. "I have a=
lready
> filed this survey" ;-))...
>

Thats sounds reasonable ... I think it is probably useful to capture a
user-role response. The priorities of users and their needs may be
completely different in a work situation.

>
>> Just a couple of thoughts :-)
>
> Thanks a lot for your comments. =A0I appreciate it.

No problem ... I will have another read through your original mail and
see if there is anything else!

All the best,

David Bainbridge
Sweden
> --
> Jakub Narebski
> Poland
>
