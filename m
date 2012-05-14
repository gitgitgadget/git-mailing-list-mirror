From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-l10n maint branch with de, zh_CN l10n updates
Date: Tue, 15 May 2012 07:29:23 +0800
Message-ID: <CANYiYbFX5_JuCdbrDQpY-oHuBgpskB-woYcfVgSxk222Mx4bGQ@mail.gmail.com>
References: <CANYiYbEyZsiE7MWbJVQGYM_1vyi+y8MVCeGGf7G-_y9vMRdxYQ@mail.gmail.com>
	<7vehqmha43.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 01:29:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU4hl-0003iU-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 01:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657Ab2ENX3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 19:29:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43860 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402Ab2ENX3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 19:29:24 -0400
Received: by yenm10 with SMTP id m10so4829711yen.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dT9Nadmaos/YJWX394GPJ0a1dThO1FUlN0s3AyuU5qs=;
        b=A42quNo+3Iz7Y3yfosvsf8XyYdTz1OHup2vMMbPMYbPqFoX+KSC3h2ZyPMdEH28rnv
         xFSB2mfylEWkuqvuVJNQujGloVGauE1BZ+idevKWI3As3uzgJ+1jfo5RtABo0KcV7peS
         oo653ubf4QZsyh8lkrt3I0i3qS1GvaLNIXl6aNLknSPx2A2O2lHvCG/Oadu31V3hcTiO
         IkOu9+/hScRkQL6KFfN3bBKJpvAMHg5W76MSLpaR0eFJpFxmh4uYAQ7LvvN3+yDl9ZLv
         wnpI6SsnHFTftZFKw6CYIfz315WDCxZXSlMUPHsN//9IuHYPRPPQt7hRCJ6ee4hwS+VI
         kPzQ==
Received: by 10.50.190.197 with SMTP id gs5mr606663igc.37.1337038163916; Mon,
 14 May 2012 16:29:23 -0700 (PDT)
Received: by 10.50.134.102 with HTTP; Mon, 14 May 2012 16:29:23 -0700 (PDT)
In-Reply-To: <7vehqmha43.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197814>

2012/5/15 Junio C Hamano <gitster@pobox.com>:
> Pulled; thanks.

Found new messages need to be translated in both maint and master branch.
So I update git.pot for both maint and master branch.

 * Update in maint branch:

    l10n: Update git.pot (3 new, 2 removed messages)

    Generate po/git.pot from v1.7.10.2-35-g0b9f4:

     - 3 new l10n messages at lines: 2743, 2751, 2759.

     - 2 removed l10n messages from lines: 1879, 2757.

 * Update in master branch:

    l10n: Update git.pot (8 new, 4 removed messages)

    Generate po/git.pot from v1.7.10.2-520-g6a4a48:

     - 8 new l10n messages at lines:

       977, 982, 1404, 1409, 1414, 1419, 1424, 1429.

     - 4 removed l10n messages from lines:

       977, 1399, 1404, 1409.

I will send another email to l10n team leader one by one latter.

-- 
Jiang Xin
