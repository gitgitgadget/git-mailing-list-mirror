From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Fri, 26 Dec 2008 22:33:39 +0800
Message-ID: <20081226143339.GB7103@b2j>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org> <20081225100033.GA8451@b2j> <3af572ac0812251053q3b3c27e1i109a780fa657dd1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 26 15:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGDmZ-0002Aw-B9
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 15:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYLZOdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 09:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYLZOdq
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 09:33:46 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:43817 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYLZOdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 09:33:44 -0500
Received: by ti-out-0910.google.com with SMTP id b6so7080534tic.23
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aqT7ObsFI+DkGUsPF5Ex6vAmpmfZOkKwmRHTV/XG8TM=;
        b=smdXkiYwsFonfTlurMpXfRQlQ/T8J4qeK8c/1iD2TlBU+fVacMNbQb5jOpSdrnKqjj
         kIEh3sCbr2O2GyQ66Vmw1hdULfOQgglYYM7w8o6QAUEq7VDKN1sQTpL3f74+uD9HKAjs
         b+eViQWl75nqyYC+rvR8RaBr7xGSEoFOKhAyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=osEfTUo7NMmowepfv+0uBGkjVHRFBX33VAN88ZRhrBZll4tduh3ud+G+GgPOGPgNwa
         Ko2tpQt0vIQBCGnoHDMYXkefHjiIRrnEWNXrTSs/VqfpRjJ9UHkY138P4IdBymCvtYuh
         iU5+P/3w6BrdPryGnwoIZGaiRu/uN9w3V+QL8=
Received: by 10.110.109.12 with SMTP id h12mr16727146tic.56.1230302023277;
        Fri, 26 Dec 2008 06:33:43 -0800 (PST)
Received: from localhost (n218103234218.netvigator.com [218.103.234.218])
        by mx.google.com with ESMTPS id d7sm1093035tib.17.2008.12.26.06.33.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Dec 2008 06:33:42 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <3af572ac0812251053q3b3c27e1i109a780fa657dd1f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103942>

On Thu, 25 Dec 2008, Pau Garcia i Quiles wrote:
> Works for me both in Hardy and Intrepid. If you have trouble building
> from source, there are binary package for Hardy and Intrepid in my
> PPA:
> http://launchpad.net/~pgquiles/+archive

Thanks you head up. No problem now, but I'll bookmark your page.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9281 =E5=8A=89=E7=A6=B9=E9=8C=AB  =E6=98=A5=E8=A9=9E
    =E6=96=B0=E5=A6=9D=E5=AE=9C=E9=9D=A2=E4=B8=8B=E6=9C=B1=E6=A8=93  =E6=
=B7=B1=E9=8E=96=E6=98=A5=E5=85=89=E4=B8=80=E9=99=A2=E6=84=81  =E8=A1=8C=
=E5=88=B0=E4=B8=AD=E5=BA=AD=E6=95=B8=E8=8A=B1=E6=9C=B5  =E8=9C=BB=E8=9C=
=93=E9=A3=9B=E4=B8=8A=E7=8E=89=E6=90=94=E9=A0=AD
