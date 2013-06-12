From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Wed, 12 Jun 2013 08:58:06 -0500
Message-ID: <CAMP44s2uR5dtRkgwWNJzCgGzbDVNHF_vZCbqCuYNVcRpg=UNgQ@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<CALkWK0nNn8Rcu4JpV4r+0ct+_cuW3aUHXKV4bcB-Hn6Xg8Y+bA@mail.gmail.com>
	<87li6g969j.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0kMvac7Sp3QwvEm+J_-Hj7JAn-AY-juDDw1HR3oQ+hamA@mail.gmail.com>
	<20130612115641.GA8427@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 15:58:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmlYz-000140-TX
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 15:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab3FLN6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 09:58:09 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:42613 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FLN6I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 09:58:08 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so7781096lab.41
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qsEGKUZGUGRknRZEKHyOAZPq2GXjLbLw2AnwBZ1ooz8=;
        b=NgeN4z4xaVNljW2GzjD9Smohfneipe9W6fRx1PkEU+8AaJ1muqT2cOQ9evgb+YM8gU
         +pRXsIWui/lXBmxttjkDE8UuOZfcpHmGbotWVpo9J4ed5Qly6f3zYpP7olyBUt5ZF3Me
         apCq5dER0kIm8oSv28EZrmgYJhI4Vg4G6/w/iDBHFrJZS1z0dw76LieL+IUNJgn/yKl+
         tJy5iV+mecNM7qRwD0rW0PQbLAMPqyNZJWPHepV/PDvLpZiUXrW+4YN2HnNP9babpW7/
         w1qPRZECaUCS++WgD3TLJ+XMMPUqhPGprftAQgXflvZUP85gUqktzr6QoQ2Iroh/5tBg
         Hefg==
X-Received: by 10.112.156.5 with SMTP id wa5mr10961532lbb.63.1371045486751;
 Wed, 12 Jun 2013 06:58:06 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Wed, 12 Jun 2013 06:58:06 -0700 (PDT)
In-Reply-To: <20130612115641.GA8427@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227616>

On Wed, Jun 12, 2013 at 6:56 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Jun 11, 2013 at 07:10:11PM +0530, Ramkumar Ramachandra wrote:
>>
>> Presumably, Felipe is the "fire hazard" that we are talking about, a=
nd
>> nobody else is to blame.  He must be "removed" to prevent future
>> fires.  This is the "perception of the regulars", correct?
>>
>> Then why haven't you removed him yet?  What are you waiting for?  Yo=
u
>> don't need my "approval".
>
> He (and you) get "removed" when individuals who have decided the vast
> majority of their e-mails shed more heat than light, and so people
> decide that it's not worth reading their e-mails.  I have persionally
> made this determination for both you and for Felipe;

On what basis have you made that determination? Have you made that
determination based on my contributions?

% git shortlog -n -s --no-merges --since '3 months ago'
   221	Felipe Contreras
    83	Junio C Hamano
    69	Jeff King
    62	Michael Haggerty
    48	Ramkumar Ramachandra
    35	Thomas Rast
    33	Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
    32	John Keeping
    30	Ren=C3=A9 Scharfe
    21	Kevin Bracey

Have you read each and every one of my 800 patches in the last three
months? Plus all my replies?

Or have you made that determination based on the tiny subset of those
that are controversial?

--=20
=46elipe Contreras
