From: Jack Nagel <jacknagel@gmail.com>
Subject: Re: [PATCH] Add MYMETA.json to perl/.gitignore
Date: Thu, 29 Dec 2011 11:40:46 -0600
Message-ID: <CAMYxyaWLy6ab7M0QW-zGPbZNahY7XpXVmN6AiwmA1oerNDM29w@mail.gmail.com>
References: <1325133725-20671-1-git-send-email-jacknagel@gmail.com>
 <7vty4kx7ol.fsf@alter.siamese.dyndns.org> <7vmxabyiby.fsf@alter.siamese.dyndns.org>
 <CACBZZX5kkX3jc-PvSe2=ZWm1DC8tWvsZN9q5G4JabEVnvf6TQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 18:41:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgJyg-0007jz-JS
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 18:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab1L2RlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Dec 2011 12:41:10 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34921 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab1L2RlI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2011 12:41:08 -0500
Received: by werm1 with SMTP id m1so6246627wer.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tPgeuzb3ffExRDLgif767VP64N39loT6UGTFkuOu+PA=;
        b=QiWZUrwcq0FxAy7hup5BIiAdElUIGItuhGSOrOnqaJrhB3ZMpNpw0++MJkvu+PXrR6
         92PbAn++xM2XgVLLdqhNXKPjVw/RupjWnJQ+xQ0XUe0EdAFVWkWavGVNsmPcUIz6S/ek
         P7rBaR244Hg7xoSNH+wy52kN9sLxtfUpNwcr4=
Received: by 10.216.139.197 with SMTP id c47mr20081063wej.23.1325180467461;
 Thu, 29 Dec 2011 09:41:07 -0800 (PST)
Received: by 10.223.89.134 with HTTP; Thu, 29 Dec 2011 09:40:46 -0800 (PST)
In-Reply-To: <CACBZZX5kkX3jc-PvSe2=ZWm1DC8tWvsZN9q5G4JabEVnvf6TQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187780>

On Thu, Dec 29, 2011 at 3:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Dec 29, 2011 at 07:58, Junio C Hamano <gitster@pobox.com> wro=
te:
>> I am simply asking because I do not know.
>
> It'll stay JSON for the forseeable future. It's part of the CPAN META
> Specification.

Yep, cf. [1]. Thanks.

Jack

[1] http://search.cpan.org/~mschwern/ExtUtils-MakeMaker-6.62/lib/ExtUti=
ls/MakeMaker.pm#Module_Meta-Data_(META_and_MYMETA)
