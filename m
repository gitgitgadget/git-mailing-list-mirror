From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] i18n win32: add git-am eval_gettext variable prefix
Date: Thu, 26 May 2011 17:16:04 +0200
Message-ID: <BANLkTiku4RuY=3CCSxsbSgWgVna5UL9Qww@mail.gmail.com>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
	<1306365594-22061-2-git-send-email-avarab@gmail.com>
	<4DDDF483.70805@viscovery.net>
	<7vlixtzh1q.fsf@alter.siamese.dyndns.org>
	<4DDE6AC9.9090003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 26 17:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcIG-0008Jc-QS
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab1EZPQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 11:16:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43787 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab1EZPQF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 11:16:05 -0400
Received: by fxm17 with SMTP id 17so757681fxm.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rOKiuOkpTZSkKjgQKQR5DwhVgng4jE7a1ala2MHqOsc=;
        b=MtA13V94IT2Td+gO4DJwC9DSMVdpYTTkyPlcs9qJmBk/dpdidw+XYPHJUvuQXv+FFY
         f9o6tDWwvOiHAzf/GupCx5/dcT63Dt83jr017eP172fU7VCT75m9SrWoW5ZWReFrHJvE
         wIfjNAHU27qVcmf0QQSfhQNd7AjOTfma1P9kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SDMKgkXH0DWnmBmdl/4qtggtrjCKHCk0lKxcE7Vt7ldN3WkMdI/0pGgC3Mih2KLjS5
         v++rAM9XSb8y9WUKXO7tfn+ccZHm5cdfbS3m3MUBiXVbyebCDixzL+oOOXwXDLKDghHO
         w0YSzAm19qDKgvCKoVbbaLHtjE92DpqErp/y4=
Received: by 10.223.73.139 with SMTP id q11mr1081363faj.56.1306422964390; Thu,
 26 May 2011 08:16:04 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Thu, 26 May 2011 08:16:04 -0700 (PDT)
In-Reply-To: <4DDE6AC9.9090003@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174520>

On Thu, May 26, 2011 at 16:59, Johannes Sixt <j.sixt@viscovery.net> wro=
te:

> I can write one, no problem; and, =C3=86var, I'm awfully sorry for se=
nding you
> in the wrong direction.

That's very nice. Having a compat/getenv.c to solve this would be great=
=2E

I look forward to seeing it. Thanks for writing it, since I can't test
stuff on Windows.
