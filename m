From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Thu, 11 Nov 2010 21:28:03 +0700
Message-ID: <AANLkTinUpkhpNG+AFZ+WxnCtuowDMuSMaZWsVGh7Lr98@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 15:29:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGY9O-0003L7-EY
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 15:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844Ab0KKO2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 09:28:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35206 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab0KKO2Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 09:28:25 -0500
Received: by wwb29 with SMTP id 29so114826wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=A5VE9rpa8EwQapxemn9BrbUFd9y43PKXOMLH+xsdpY4=;
        b=IVd5ls0itci8t/aXl1KnWue7xk8kare/krRiB2Xnnio2e/WxyoD+yvzDlz7rcwLpMD
         FlPWBhNfcaTfYs8DaVYopgOPadIiBmVYbvbVQVNmfvLmjVtOCdHBGnmfNUPQNqK3zFLQ
         SB1GyK/4ggCSkXNfpEuruiPPv6fB0PfBOXEGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=v2d5C32xPwTln3DOhOv0Bk2QJwY3F6jDo/alZ1Cw23+45JT4HNMbz7z91O9ddSju6l
         OBbusACxrkx4wkqa/l5gJhLdByec4i0nSMS2ezZDtPTYbDfxeSTwUOprkS2F4BqkHwkf
         w6zb2WtR11WkPYYbUeWzCEEB787iqr1WTk9/E=
Received: by 10.216.172.9 with SMTP id s9mr778300wel.56.1289485704229; Thu, 11
 Nov 2010 06:28:24 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 11 Nov 2010 06:28:03 -0800 (PST)
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161262>

On Wed, Nov 10, 2010 at 2:53 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Here are the topics that have been cooking. =C2=A0Commits prefixed wi=
th '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'. =C2=A0The=
 ones
> marked with '.' do not appear in any of the integration branches, but=
 I am
> still holding onto them.

Can you revert the patch order in each topic? I find it easier to read
from the oldest summary line to the latest one, then your comments,
than the other way around.
--=20
Duy
