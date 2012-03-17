From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: git push default behaviour?
Date: Sat, 17 Mar 2012 10:51:26 +0100
Message-ID: <CAAGHeXFFrHnDz-SA8V2awBpi3Cwfxj_C3p=N16qZZFEW3L5Vtw@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <CAAGHeXHWfEAym63jXFNvcBddp00joBzNuFEjhKZpqDQcn1d0kA@mail.gmail.com> <CAFsnPqpS7srjHu1Wnx60qcwN_PV83uxvtWoniFBgRH2MjJzzzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 10:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8qJX-0000FO-Rq
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 10:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840Ab2CQJwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 05:52:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60299 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711Ab2CQJwJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 05:52:09 -0400
Received: by bkcik5 with SMTP id ik5so3380178bkc.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DxwD/MWSN5uzLI04uCtPKCZL3vdaXLWMU+XGcbJzROs=;
        b=BEiPckNrhoTgf0QC3YbA7h4ToYDZjXpZzfeWpVjv0SEvjdfRQHAl8U+86z346IVb1G
         /tf0zzBiGMsMf4OwYgJOGZaMt3mFquLt13Cd4mqmE4Sz5iSosYNtVF1yFuGwlhZNbcUZ
         x/o9jKLynzCxfGER9hj5FH+x2dk1y9M47AEJPKUomC7zMoH2mcqShX3XV0sVEKloFsV+
         kkLm3VSU/Sk7vRvZPfa6iVHH/skpkoq+b5PO9twDAitoMZkQwQsqJF1Yf8viPuwa15Lp
         /WKpV6I+AAIM1N7NGFc8jW+FjyhGozCks6iC7Gs9WbtfcNTK3pmjOEB1wBA8mkEXBxfL
         NPmg==
Received: by 10.204.132.80 with SMTP id a16mr2109335bkt.18.1331977926305; Sat,
 17 Mar 2012 02:52:06 -0700 (PDT)
Received: by 10.204.224.204 with HTTP; Sat, 17 Mar 2012 02:51:26 -0700 (PDT)
In-Reply-To: <CAFsnPqpS7srjHu1Wnx60qcwN_PV83uxvtWoniFBgRH2MjJzzzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193314>

On Sat, Mar 17, 2012 at 10:38, Jeremy Morton <jeremy@configit.com> wrot=
e:
>> I made many Git presentation and managed a lot of training[1] and th=
e
>> first thing I explain on the configuration is :
>>
>> 1. set your name and email
>> 2. change the default push option[2]
>
> So, that would seem to be a rather strong indication that the default
> push option is a bad one. =C2=A0:-)

True. Never understood why matching is the default value :). Btw,
thank you for the discussion, I forgot to do that :(.

--=20
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche / G+: +sdouche
