From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2010, #01; Wed, 13)
Date: Thu, 14 Oct 2010 13:51:13 +0800
Message-ID: <AANLkTinQi=S42zY-0HUw+_tMoO=W2ADN0NF3tRde7w4F@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 07:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Gim-0006GS-GW
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 07:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab0JNFvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 01:51:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52244 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab0JNFvO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 01:51:14 -0400
Received: by qwa26 with SMTP id 26so1445309qwa.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mW/7Px+AQgu95QKx/coI5XhcbRkxEfa9ptAgmXIsRwU=;
        b=rQyIPcCw5NqDCZTQSpIevot1LM0KwieXaafEH+E4kEPE0eo401TSGkOxkQWGHsQNez
         TGcUv/zXyp12ADvafCUenYyoezhEsabuvWipNm4tPV+uO1hxSd1KOz2ighNjdOMMn5Jm
         LlZdKK4RpdAH+9oLLHoH33KxZxCwxyYmeq2vE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VfGJjYluG6iSLW3upicklNCBqkZL9NQPJxI/3h3uEz593x56cpWzvle3evbq7+rJiJ
         pzSV0z6AU0jJOBIPHZyAHGcDuBQLa8lUGdK9kmVgf3q3PPgjfT0LiSmeY/bwN2TJuvtb
         +Z71ZFOUdJ52oIwXpHeqvAdEJDk2K/hooBa4c=
Received: by 10.229.75.3 with SMTP id w3mr5382369qcj.296.1287035473450; Wed,
 13 Oct 2010 22:51:13 -0700 (PDT)
Received: by 10.229.100.79 with HTTP; Wed, 13 Oct 2010 22:51:13 -0700 (PDT)
In-Reply-To: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159025>

On Thu, Oct 14, 2010 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> --------------------------------------------------
> [New Topics]
>
> * ab/send-email-perl (2010-09-30) 16 commits
> =A0(merged to 'next' on 2010-09-30 at cf8e58e)
> =A0+ send-email: extract_valid_address use qr// regexes
> =A0+ send-email: is_rfc2047_quoted use qr// regexes
> =A0+ send-email: use Perl idioms in while loop

A few of the Signed-off-by and Reviewed-by stanzas in this series are m=
essed up.

Have a look at

    $ git log 9855b0..41ae8f1

Copy and paste error?

nazri
