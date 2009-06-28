From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Mon, 29 Jun 2009 01:23:08 +0200
Message-ID: <200906290123.09701.jnareb@gmail.com>
References: <200906252122.51737.jnareb@gmail.com> <200906261508.46176.jnareb@gmail.com> <200906261644.02694.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 29 01:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML3ie-0001F8-3L
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbZF1XXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Jun 2009 19:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752445AbZF1XXQ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 19:23:16 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62454 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZF1XXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 19:23:15 -0400
Received: by fxm18 with SMTP id 18so669149fxm.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=dn3Ro0pLiLwydbSrG3/LSCViYj83BlRt3k/cyRHvw5M=;
        b=Fj075KLlBVDueh8MnSLJqRZEN/00dsKtBcgniYKgWSzEQ1ZvZu8EiEGlSkP5/H+L/U
         6K91p6UihrApElPt+XHhag1LL9Lgrp6lGlenanCUvJpXDfduX+/dvbfKrzpfQFGMNRnC
         jzZXW6xuSpCkxgK5BZcD5K5plzuN/vA2H+Yho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=gLeW4WaoQJ47i8XX588nhEUbWNGafn6CvwpPJlJVb6z4fcVQO7OX4QviEsfBRx4iKm
         ypSu5Y5ZMcdgH3/I0soQOREoC5/5y515XTdFBKLPMg8prMKfq0S8In4ajsZkRKYqUst2
         bSiIZLJuu1fSfudMjYsw/IYYqJ04ypmm8pOpc=
Received: by 10.103.6.14 with SMTP id j14mr3709674mui.48.1246231397484;
        Sun, 28 Jun 2009 16:23:17 -0700 (PDT)
Received: from ?192.168.1.13? (abvg228.neoplus.adsl.tpnet.pl [83.8.204.228])
        by mx.google.com with ESMTPS id 25sm11863830mul.50.2009.06.28.16.23.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 16:23:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906261644.02694.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122429>

Dnia pi=B1tek 26. czerwca 2009 16:44, Johan Herland napisa=B3:
> On Friday 26 June 2009, Jakub Narebski wrote:

>> Too large number of questions in the survey, and filling survey
>> taking too long were, I think, the most common complaints about
>> survey in the year before.
>=20
> Yes, that's why I focused on decreasing the number of questions even
> further.

Having less questions (currently trying to fit within 30 questions)
is not the only criterion.  It is also important to not have too=20
complicated questions (with large number of possible responses),
see e.g. question 10 (editors and RAD) which got slimmed down by
asking about kind of editors and not individual editors.

>>> There seems to be some unnecessary overlap among questions 11,
>>> 16/17 and 18.
>>
>> Overlap between questions 16/17 and 18 is, to some extent, intended.
>> Those two questions ask about similar area but from the two differen=
t
>> points of view: question 16/17 is about git commands, 18 about
>> features.
>=20
> I see, but in the cases where the feature questions in 18 are tied to
> a specific git command already mentioned in 16/17, I believe you can
> drop it from 18 (since we already got our answer in 16/17).

Actually if I could I'd rather drop it from 16/17... but this question
is about comprehensive list of git commands (one can use).  I think
that some people won't answer 16/17 because it is long and time-consumi=
ng
(and difficult to answer, if you want to do it truthfully).

On the other hand trimming down the list of possible answers in=20
18 (features of git) could be a good idea...

>> It there are votes for removing questions 16/17 I can remove it from
>> survey (again).
>=20
> No, I don't want to remove 16/17. I'd rather remove 18, since it
> overlaps so much with several of the earlier questions.

I'd rather not.  I prefer 18 to 16/17.
=20
>>> - 17/"git reflog" and 18/reflog
>>
>> I think I'll remove 'reflog' from 18 (features), not because it is
>> present in 16/17 (git commands), but because this is feature one
>> uses, I think, quite often and less 'conscious'.
>=20
> agreed.
>=20
>> OTOH one can use reflog feature without using "git reflog" or
>> "git log -g" ("git log --walk-reflogs") -- HEAD@{1} or @{yesterday}
>> uses reflog feature without using mentioned git commands :-)
>=20
> But _why_ are we asking this question? If the reflog feature is used
> all the time without people having to know about it, then there's no
> point in asking about it. It's not like it's going to be removed in
> the next version because people dislike it. It's like asking "Are you
> using Git blob objects?". What are you going to do with the answer?

Actually I think this answer is here because it was present in previous
survey... and then reflog was not turned on by default, and <rev>@{<n>}
syntax didn't exist then.  Using reflog was then conscious choice.
Not nowadays.
=20

Thank you for all your comments.  I'll try to come up soon with next
version of "Git User's Survey 2009", hopefully the last one before star=
t
(and question about announcing it).

--=20
Jakub Narebski
Poland
