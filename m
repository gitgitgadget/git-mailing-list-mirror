From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Delaying 2.0 final
Date: Sun, 18 May 2014 08:31:05 +0800
Message-ID: <CANYiYbHYkCBmVfgpW8=1EZF4VkUuZM6kFuZP6fA2f7Wt9au5ig@mail.gmail.com>
References: <xmqqd2fd8hs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	=?UTF-8?Q?Gr=C3=A9goire_Paris?= <postmaster@greg0ire.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 02:31:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlp0T-0005hm-R0
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 02:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbaERAbI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 May 2014 20:31:08 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:49676 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaERAbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 20:31:07 -0400
Received: by mail-we0-f172.google.com with SMTP id k48so4111920wev.31
        for <git@vger.kernel.org>; Sat, 17 May 2014 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RkiqdkD/3UvdYjEs8wv5P2QD9Nyl/0aYOeLzJ/ErdDs=;
        b=InzwnwP08CwDIkJ1/YY5usDfYjGqd79PTSfhSdwE64mNIwwJb2FQEfuOkBCquA6RXI
         gaIY/5oiiKTfdZe36QJOeOXElDNZoS57tV70zBEdWZK8F1sGfsTI9vorbWKsakTtLor3
         St/pRVvzdheY6+xTV431Q5mMsIEgTzKelfW9oCC3KmuaQ6MRnzaSBmy5bv9w/Wn2iin7
         bvSLBkU8Iqsi9YHB0l0hTaUO1HcRyMu0Uo9iTVNzYErTCwlImS63fH7+gUVo3cEXV36j
         JR2TNvzkML6aoFtto42vBQAnMzlhQWo6ov25WfuD2lXIoJY+1JSoGSBv1E2NDYYtyZpG
         +Xcg==
X-Received: by 10.180.12.135 with SMTP id y7mr5198515wib.39.1400373065167;
 Sat, 17 May 2014 17:31:05 -0700 (PDT)
Received: by 10.194.104.9 with HTTP; Sat, 17 May 2014 17:31:05 -0700 (PDT)
In-Reply-To: <xmqqd2fd8hs9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249492>

2014-05-17 6:45 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> As we seem to have a few regressions we may want to fix, I will not
> be cutting the 2.0 final today (https://tinyurl.com/gitCal).
>
> I queued the following near the bottom of 'pu' (these are also
> merged to 'next' to keep pu^{/match.next} in sync with next), and
> plan to cut 2.0.0-rc4 early next week.
>

So the update window is still open? Please pull this.

The following changes since commit 6308767f0bb58116cb405e1f4f77f5dfc158=
9920:

  Merge branch 'fc/prompt-zsh-read-from-file' (2014-05-13 11:53:14 -070=
0)

are available in the git repository at:


  git://github.com/git-l10n/git-po

for you to fetch changes up to a6e888397ce46f9252ca89af46f3f6aaf18baf9b=
:

  fr: a lot of good fixups (2014-05-17 19:08:59 +0200)

----------------------------------------------------------------
Gr=C3=A9goire Paris (1):
      fr: a lot of good fixups

 po/fr.po | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)


--=20
Jiang Xin
