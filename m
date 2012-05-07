From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/5] l10n: de.po: translate "track" as "folgen"
Date: Mon, 7 May 2012 12:09:38 +0200
Message-ID: <87obq08fq5.fsf@thomas.inf.ethz.ch>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
	<1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
	<1543115.9YNtu9coLS@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, <jk@jk.gs>,
	<git@vger.kernel.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon May 07 12:09:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKt4-0007wi-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 12:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab2EGKJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 06:09:45 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:49751 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2EGKJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 06:09:44 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 7 May
 2012 12:09:41 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.209.244) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 12:09:41 +0200
In-Reply-To: <1543115.9YNtu9coLS@cs-pc> (Christian Stimming's message of "Sun,
	6 May 2012 17:20:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.209.244]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197256>

Christian Stimming <stimming@tuhh.de> writes:

> Am Freitag, 4. Mai 2012, 21:48:23 schrieb Ralf Thielow:
>> The word "track" was translated as "verfolgt"
>> which is not the correct word for it. We've
>> changed it to "folgen".
>
> I'm not so sure about this choice. We're talking about files which ar=
e tracked=20
> by git (i.e. being versioned) vs. files or content that are not track=
ed, i.e.=20
> those are just existing in the working copy's directory but are not t=
racked by=20
> git. I think from the point of view of git, the content of the files =
is being=20
> "verfolgt" vs. "nicht verfolgt", as git checks whether the content is=
 changing=20
> vs. git doesn't check this. Saying "folgen" here rather sounds like g=
it is=20
> following something, just as your twitter account is following other=20
> twitterers. Consider a choicebox "=C3=84nderungen dieser Datei verfol=
gen" vs.=20
> "=C3=84nderungen dieser Datei folgen". In the former case, git is the=
 subject and=20
> it is tracking the file's content. In the latter case, the file is th=
e subject=20
> and git is triggered into some action when the file content changes. =
I think=20
> the former fits the use case more.

Good point.  In addition, both "folgen" and "verfolgen" have the proble=
m
that several derived words sound funny; e.g. "verfolgt" and "folgend".

How about "beobachten" (for the English readers, roughly "observe") or
"beachten" ("pay attention to") for this meaning of tracking?  The
latter even forms a nice group with "unbeachtet" and "ignoriert".

You could use "folgen" in the remote-tracking sense instead?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
