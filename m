From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Sun, 5 Jul 2009 02:46:50 +0300
Message-ID: <94a0d4530907041646i770b14f5ic5c0b76dc6189b17@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
	 <20090704012635.GB39268@gmail.com>
	 <94a0d4530907040124i32abe421x86e5c8f0839bf2fa@mail.gmail.com>
	 <200907050043.58875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 01:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNEwf-0004cu-Md
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 01:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZGDXqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jul 2009 19:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZGDXqs
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 19:46:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:56959 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZGDXqs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jul 2009 19:46:48 -0400
Received: by fg-out-1718.google.com with SMTP id e12so344491fga.17
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ou4gG9vWCdeTgFisUnIBlaZYcUYXmAslivRB+oPN6q4=;
        b=OMn6Ael0/7I0M8pTIBaQdyu48iRuVpJpVHrGgaBYs3unqI49NlBB93SWWb+jrnGgh9
         mT+DFs5lhBXZSfoWbnlyZzmSGIuLIBrBpQmFmltexLKuxp93QQNzKwSIUU0hJ/JRr7pm
         dBgpR2+kUQVnhKpbodbKnG9msuhD2qcK2oZrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vwg67gcX2B9q63SS9CjMKQBs6jOEzq54Mqm3vckr3ZiETlyfNmUNrhAo+SAWcGZCqB
         xIfBV1THmEy3pPU91OJkZ3eDo6EGnlSCCNcX8kPwu/fP8blw0wNDyrIVFBsIIAIifVhQ
         YOZLb0ZY3x1H0JpP2z6MB5UREvCu4g1HNhlOM=
Received: by 10.86.54.7 with SMTP id c7mr1545002fga.24.1246751210172; Sat, 04 
	Jul 2009 16:46:50 -0700 (PDT)
In-Reply-To: <200907050043.58875.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122732>

On Sun, Jul 5, 2009 at 1:43 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> On Sat, 4 July 2009, Felipe Contreras wrote:
>> On Sat, Jul 4, 2009 at 4:26 AM, David Aguilar<davvid@gmail.com> wrot=
e:
>>> On Sat, Jul 04, 2009 at 02:19:25AM +0300, Felipe Contreras wrote:
>>>> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:
>>>>
>>>>> 20. Overall, how happy are you with Git?
>>>>> =C2=A0 =C2=A0* unhappy
>>>>> =C2=A0 =C2=A0* not so happy
>>>>> =C2=A0 =C2=A0* happy
>>>>> =C2=A0 =C2=A0* very happy
>>>>> =C2=A0 =C2=A0* completely ecstatic
>>>>
>>>> Let's leave room for git haters too:
>>>> =C2=A0* I hate it
>>>
>>> Umm, let's not.
>>>
>>> If they hate it, they'll be in the "unhappy" category.
>>> And if they hate it, I doubt they'll be filling out this survey.
>
> [...]
>>> Let's not encourage them by including including "I hate git"
>>> in our survey.
>>
>> That's a good point, I just thought it would be nice to spot them;
>> which would be easy if they answer "I hate it". But also, if there's
>> an extreme positive (completely ecstatic) I thought there should be =
an
>> extreme negative, just in case.
>>
>> Probably not important at all.
>
> Hmmm...
>
> On the one hand side it would be better, I think, to have balanced se=
t
> of answers, with neutral position in the middle, and unhappy/happy
> along the axis.
>
> On the other hand that was the set of answers used in previous survey=
s,
> so if we change it it would be harder to compare against surveys in p=
ast
> years.

That's another good point, I don't have a strong opinion about this,
and now I don't think there's any good reason for changing it.

Cheers.

--=20
=46elipe Contreras
