From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 000/159] [PULL] Updated + rebased ab/i18n
Date: Tue, 28 Sep 2010 18:32:52 +0000
Message-ID: <AANLkTik_QB8Ly=NM=SFjnXC=ALz5cy-i75_Xf9ijF9Yq@mail.gmail.com>
References: <1285666838-7471-1-git-send-email-avarab@gmail.com>
	<7veicdu4v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 20:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ez4-00058M-MK
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 20:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442Ab0I1Scy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 14:32:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39990 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab0I1Scx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 14:32:53 -0400
Received: by iwn5 with SMTP id 5so6284128iwn.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A77FS9SR3Ps6DOpJK5N23JcrrE9TebqPrPeB5v4bXtU=;
        b=TnwH2jLYRo7YJMw7VDH52v94kxHcOe5A+WGoU/7y8Hij9+5aHuO5hlkprKw4/OZW8X
         sy502MxqZe27QgM0e9tXVbA6/WgkLCBc1zLaAZJ4BppKUzefC2r0QJgDUBCKqytbEzj9
         wMdIAGML/iFDHZ402KU5akC6RdcwyOo3z7TrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NuOZlshJ1vt2O2yHgTFJGuNsrPq+iCQKLzsA7zr7yhWjrKKALNggy8nxTBHZzzYlkQ
         9jg2A/vNkQI8b2O7XWLgHnMOFE1mMqVazAPl3VcLWiGP+rQ8MzN7a+xZl9PgLAFERRDQ
         DaUFRlcKjESfEji2xb7WOaCapoidN4gCnogxA=
Received: by 10.231.179.24 with SMTP id bo24mr142164ibb.193.1285698772791;
 Tue, 28 Sep 2010 11:32:52 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 11:32:52 -0700 (PDT)
In-Reply-To: <7veicdu4v3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157454>

On Tue, Sep 28, 2010 at 17:58, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Please pull an updated ab/i18n. The version you have now should be
>> ejected in favor of it:
>>
>> =C2=A0 =C2=A0 git://github.com/avar/git.git ab/i18n
>>
>> There are no code changes since my last pull request, just a rebase.
>
> If it is "just a rebase", I do not see a reason to pull from you, but=
 you
> seem to have some updates and they look sane ;-)

I should have said:

These patches aren't different from when I last sent a pull request,
but I'm sending one again since I had a lot of (maybe confusing)
updates to the old one, and I'm sending one again now that we're
picking up after the last release.

And while I was at it I rebased it on the current master.

Anyway, thanks :)
