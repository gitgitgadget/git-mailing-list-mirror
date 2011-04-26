From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #06; Mon, 25)
Date: Tue, 26 Apr 2011 07:56:24 +0200
Message-ID: <BANLkTik+roEa_A1Zh=DTDGzP0ouJVReK1g@mail.gmail.com>
References: <7v39l6hqog.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 07:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEbGp-0006Zw-Q3
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 07:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab1DZF5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 01:57:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52815 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab1DZF5F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 01:57:05 -0400
Received: by vws1 with SMTP id 1so248079vws.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ORbKYEnrVK/N5XHX/JaitgiFeJAmETOTC+CNyoOJ/OA=;
        b=suOV8QzbywOXVtn+0jOPSBnqZNGxkyIM8sYKmDi2EPApg4D6bBOhBQ7JSGNEtm/s0k
         zA2xObd4k5sM3GZkxOx2D/SOvwEUHoaOCIO9jeui7e/c4exSND5VsjireS7YKXAphHSQ
         +S0LcyDh7o5D2KBp522HQm8EooexCorUVUPSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=biu+5c7gI70lWD83D4ec8TAqqMuRtWwK2sHZjzRCcB5Ib2B98hQib3a2J2r8ue6R0Y
         vfh3L2peOtMuIA8DOjjIeuLnBoDvoXjD3EOHfjcpBcjh0k9TYdNz3aCo5q7LxonA7eS4
         3btq7tIYtQ0XUU8aD8zbco4s7UtLZpZ9aaDXs=
Received: by 10.52.95.84 with SMTP id di20mr490719vdb.292.1303797424081; Mon,
 25 Apr 2011 22:57:04 -0700 (PDT)
Received: by 10.52.182.230 with HTTP; Mon, 25 Apr 2011 22:56:24 -0700 (PDT)
In-Reply-To: <7v39l6hqog.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172066>

Heya,

On Tue, Apr 26, 2011 at 01:11, Junio C Hamano <gitster@pobox.com> wrote=
:
> The main part of this cycle is expected to run thru May, aiming for a
> feature freeze in early June. =C2=A0We are at the beginning of week #=
1 of this
> cycle and week #2 starts on May 2nd.

I like the week annotations in this "What's cooking", in particular
the ones indicating when something will be merged, it gives a better
picture of what still needs cooking and what's just waiting for the
"let's all focus on making sure 1.7.5 isn't broken" window to end.

--=20
Cheers,

Sverre Rabbelier
