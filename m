From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 1/7] CodingGuidelines: mention whitespace preferences
 for shell scripts
Date: Fri, 3 Dec 2010 23:46:11 +0100
Message-ID: <AANLkTinDAZ2O6CHjK-7bmtUn42+z06A3BdXfURWV6mZt@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7vsjyemt1f.fsf@alter.siamese.dyndns.org> <AANLkTi=PmGR23AMog4UWQVNKPWrDUM_kYWV_Bn1vvSwE@mail.gmail.com>
 <7v39qemqyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POeOk-00043m-69
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab0LCWqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:46:33 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46432 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422Ab0LCWqc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:46:32 -0500
Received: by iwn6 with SMTP id 6so404710iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Y4AE6dIwHvlZtC8y18OerO77BZe2d9jFpSEseUYttK0=;
        b=b1P5uzGcUD4YTSd6WqxWwksHp0qN5hDpYahmxGRa8sow5Y7RhUD58YoLQ5acIZGRBZ
         85gxGP3BthYluZjE3j9hXahPIMm3kG54jakfkwmawWOhKUGDv6UqFtgF3EHNIXZkaLG8
         pKyHBOqbzM8Mbp2hZB3xhkFwN0qA3Q4LIRLNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=E+k1PBVPA3tHL6n75QBeV0zP4Wya1CilDTRq2SV5a9+0d3msESlY9dEk0aBGXREzTd
         0/CmEWGuz5Ny53Pzc4333Tk9MMu2z2mNiyKUj7vC0ntJ14nF1+MoWU4t51GmTIHlvQL5
         yDqBh6G6UQKjqx4Q0WNoFbWjvdzE8Axw+1oxM=
Received: by 10.231.14.135 with SMTP id g7mr2413033iba.106.1291416392056; Fri,
 03 Dec 2010 14:46:32 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 14:46:11 -0800 (PST)
In-Reply-To: <7v39qemqyc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162874>

On Fri, Dec 3, 2010 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Good idea. I'll rephrase in that sense and add a couple more entries
>> about the | spacing and long case arm splitting, for the next rehash
>> of the series.
>
> Hm, I don't think there needs a rehash of the whole thing. =A0This on=
e is
> ready for 'maint' with the rewording), and 2-4 looked Ok.

Ok then. Do you still want the two extra entries or are they superfluou=
s too?

--=20
Giuseppe "Oblomov" Bilotta
