From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 14:12:59 +0300
Message-ID: <94a0d4530906260412h78b55458gc722964011edb54d@mail.gmail.com>
References: <200906252122.51737.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	David Aguilar <davvid@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 13:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK9Mj-0007jn-Dn
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 13:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbZFZLM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 07:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbZFZLM6
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 07:12:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:58206 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbZFZLM5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 07:12:57 -0400
Received: by fg-out-1718.google.com with SMTP id e21so461182fga.17
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pW5Mgz7Lo+KFGBc6qy+rf2MT46KlinOMxtf8XTQB2sA=;
        b=Q2RRG8zxyW0EDPRx/eDX7kb+BXHvsGv1REr3VVYurjKPJNqf5r/R1X62hxqYsq2ja9
         g6t/UevabdK7CeC/BogzcEELkOkdgvUt3P6lYQayZEir2kkhapOFhbv61KS+8qC59o4V
         /9x/xltFSLscyFQu/97aizwnD4DEZCeZYpkb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kzchxn8iefj28oUv2JJTJk5c36+zoXJLM94VOq/cmrIAz00k4gGhF6hzshxLGLo49Z
         cFTkwAc9ppa6/OemV8vykLM09pyI7tLGsEqMDj6Jtnmj3PyEse8eiqh+U7gbUzESLN8w
         nnQguws/F3Ye/Tqq8EJqbUMztRH0Lkv4cOL0U=
Received: by 10.86.31.18 with SMTP id e18mr3615779fge.72.1246014779608; Fri, 
	26 Jun 2009 04:12:59 -0700 (PDT)
In-Reply-To: <200906252122.51737.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122292>

2009/6/25 Jakub Narebski <jnareb@gmail.com>:
> I have created _proposed_ version of questions for upcoming
> "Git User's Survey 2009", based on (a bit of) feedback on git
> mailing list:
> =C2=A0"[RFH] Questions for Git User's Survey 2009"
> =C2=A0Msg-Id: <200905291855.03328.jnareb@gmail.com>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/120287
> and comments on #git IRC channel on FreeNode.
>
> Current version of survey has 30 questions, as compared to
> 60 questions last year; the number of free-form essay questions
> were also greatly reduced.
>
>
> The *test* version of this year survey can be now found at
> the following URL (as in previous year, we use Survs.com)
>
> =C2=A0http://www.survs.com/survey?id=3D2PIMZGU0&channel=3DTFN2Y52K7Y

These are my comments:

3. Did you find Git easy to learn?

That assumes the user already learned to use git, how about:
3. Have you found Git easy to learn?

8. How do you obtain Git?

Most people install once, or at least not very often:
8. How did you obtain Git? (maybe s/obtain/install/)

14. How do you fetch/get changes from upstream repository?

Only one repository?
14. How do you fetch/get changes from upstream repositories?

git ... --dirstat

Isn't '--stat' more common?
git ... --stat (or --dirstat)

18. Which of the following features do or did you use?

More readable:
18. Which of the following features have you used?

22. Did you participate in previous Git User's Surveys?
22. In which of the previous Git User's Surveys have you participated?

24. Which form of Git documentation do you use?
Do you consider them useful?
24. How useful have you found Git documentation?

28. Do you read the mailing list, or watch IRC channel?
28. Which communication channels do you use?

Also, I would like to see a list of areas users would like improvements=
:
XX. In you opnion, which areas need improvement?
 * user-interface
 * documentation
 * performance
 * more features
 * other

Is there a way for users to assign points? eg. user-interface: 2,
documentation: 1, more features: 1

I like it better than the previous one :)

Cheers.

--=20
=46elipe Contreras
