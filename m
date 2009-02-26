From: bill lam <cbill.lam@gmail.com>
Subject: Re: [tig] typo in man tig
Date: Thu, 26 Feb 2009 08:43:36 +0800
Message-ID: <20090226004336.GH20441@b2j>
References: <20090223054118.GB7435@b2j> <2c6b72b30902251358x590c953dk9df2e3d90a1d9e24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 01:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcUNa-0008K6-1x
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 01:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbZBZAnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 19:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZBZAnq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 19:43:46 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:23538 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZBZAnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 19:43:45 -0500
Received: by yx-out-2324.google.com with SMTP id 8so228473yxm.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 16:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aQRpEFyYz8fQI7apTTX7ewaBw9adQxdyb2fqxrzPkMk=;
        b=gZZx39e7pTCA0vzazQJECeiEKJoj1HDb5bQzDfL9fiPa7lTGQO0dle1S+Q6FsTp7Oi
         6hDzcC4u2BqwmvRMm534nph80vDw1BEPGZe/Yo3NmleN14c0632qUn/etBnrRowg0QYH
         DF0RLtkQ9MBO2rYmg6fXB1353fnPUKZwvdwRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=VffBmAaMh03jWJei+iBHRiggxwKBVk1t1CY6L5yIk+0Vylpl5vXzU2obv7tEx3aWVx
         KHHVxG3Jz7sn98BejOcAHOOY6rqMn2oyTEWWBW/xiDxXFnYILM23FWj0wpvE9Qeq4i/c
         h/SovgwinQGlAmI1GfT9ra4McL5jz9s6Vdtbg=
Received: by 10.110.26.8 with SMTP id 8mr1058259tiz.27.1235609021783;
        Wed, 25 Feb 2009 16:43:41 -0800 (PST)
Received: from localhost (pcd589002.netvigator.com [218.102.121.2])
        by mx.google.com with ESMTPS id a14sm2751082tia.7.2009.02.25.16.43.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 16:43:40 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <jonas.fonseca@gmail.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2c6b72b30902251358x590c953dk9df2e3d90a1d9e24@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111514>

I forgot to make install-doc. Sorry for noise.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9223 =E6=B2=88=E4=BD=BA=E6=9C=9F  =E5=8F=A4=E6=84=8F=E5=
=91=88=E8=A3=9C=E9=97=95=E5=96=AC=E7=9F=A5=E4=B9=8B
    =E7=9B=A7=E5=AE=B6=E5=B0=91=E5=A9=A6=E9=AC=B1=E9=87=91=E9=A6=99  =E6=
=B5=B7=E7=87=95=E9=9B=99=E6=A3=B2=E7=8E=B3=E7=91=81=E6=A2=81  =E4=B9=9D=
=E6=9C=88=E5=AF=92=E7=A0=A7=E5=82=AC=E6=9C=A8=E8=91=89  =E5=8D=81=E5=B9=
=B4=E5=BE=81=E6=88=8D=E6=86=B6=E9=81=BC=E9=99=BD
    =E7=99=BD=E7=8B=BC=E6=B2=B3=E5=8C=97=E9=9F=B3=E6=9B=B8=E6=96=B7  =E4=
=B8=B9=E9=B3=B3=E5=9F=8E=E5=8D=97=E7=A7=8B=E5=A4=9C=E9=95=B7  =E8=AA=B0=
=E7=82=BA=E5=90=AB=E6=84=81=E7=8D=A8=E4=B8=8D=E8=A6=8B  =E6=9B=B4=E6=95=
=99=E6=98=8E=E6=9C=88=E7=85=A7=E6=B5=81=E9=BB=83
