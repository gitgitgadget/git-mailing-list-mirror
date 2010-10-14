From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Thu, 14 Oct 2010 23:26:11 +0200
Message-ID: <AANLkTikB3RCVc=D559Z7BnXm5hKJD=fV9+mh_BqRvWsp@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org> <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino> <AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
 <20101014205413.GD28958@burratino> <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 23:33:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6VQU-00043w-Do
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 23:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab0JNVdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 17:33:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33618 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0JNVdT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 17:33:19 -0400
Received: by ywi6 with SMTP id 6so55995ywi.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iedg5CSo2Z3g/1QUzB8OHT1yN0JginJz6Sl5X6kBrfU=;
        b=n6HyT5XiueozF3fyFfh8GJKUVN/jIjkG4p/wkmUWzxxywgkjaYHsJcBtV7icEHlRPZ
         03jyY4IAii4lSaan0Bu6fVA2noFsgSrv22aQVPhhQq7WIWE5/2IuGs9bL4kvvo6zOGeL
         4Bs5a3mqepGzLbiJ1cSFpfIn6PEwFduVDL4Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rUhg42jaL2dvDwVC1ohM7IkjOlR3EJhQyYbd3Vs7mn1fzW6bSQ4O23xSd4p4YJAWWo
         YVo5ObQspPzR2A0mp5oB8r8OS+ON5TuWk/cMGA/aijefZmEnIyhJmN6S3cukQtpY/VhU
         quD4fYDP7MJp+3VKQ8u/9FHLvicMUwbTVAT/o=
Received: by 10.151.10.17 with SMTP id n17mr112931ybi.215.1287091591741; Thu,
 14 Oct 2010 14:26:31 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 14 Oct 2010 14:26:11 -0700 (PDT)
In-Reply-To: <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159077>

Heya,

On Thu, Oct 14, 2010 at 23:18, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Thu, Oct 14, 2010 at 20:54, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> I'm interested in it, at least.
>
> That's good to hear.

Ditto, especially since i18n, once the groundwork has been done,
requires very little work to support (as long as someone keeps an eye
out for people forgetting to _("") a string).

--=20
Cheers,

Sverre Rabbelier
