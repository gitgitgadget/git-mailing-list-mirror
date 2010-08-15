From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2010" - features used, features wanted
Date: Mon, 16 Aug 2010 00:51:22 +0200
Message-ID: <201008160051.23283.jnareb@gmail.com>
References: <201008152357.29889.jnareb@gmail.com> <20100815221327.GB2666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 00:50:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okm2R-0001TR-GW
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 00:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab0HOWum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 18:50:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56242 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab0HOWul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 18:50:41 -0400
Received: by fxm13 with SMTP id 13so2667934fxm.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yPmp0be2d+zM7qsDFwYfL+F0bJj+no2bsRogagjhiZs=;
        b=FPV3mBhzp6qrUil64lw5tl/srkM6M9KiwyUSUn7xNk2BB37/n5GXhtv07G85Y0p9OQ
         rfHjhGeejrFLlaUnjIdSrQYJpUauIpgt53vjt7I7YukXIHcmRpLIWbjXVhlTO73dxPHi
         WibzO/Y1NMMeTFx4LriXTzq1eO36JrdecAk/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=k41JCsdS1Dx+3BLXcSVTAfx0H69UFmBy57sfvq/q91cZFNVhlm4Yj+OFgRoaZNOHrx
         Hz7GlC/mqfpn8fN/2+cN2HrG1dX320UGjbCyoDX7iPULRpwxT9+TWKfx5Bkoa1Gmx3sC
         15mDbwUM95i2Ij423xa/K72FeD+oS4qDWyJlc=
Received: by 10.223.112.10 with SMTP id u10mr4476995fap.50.1281912640168;
        Sun, 15 Aug 2010 15:50:40 -0700 (PDT)
Received: from [192.168.1.13] (abvw76.neoplus.adsl.tpnet.pl [83.8.220.76])
        by mx.google.com with ESMTPS id r10sm2168395faq.5.2010.08.15.15.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 15:50:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100815221327.GB2666@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153627>

On Mon, 16 Aug 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
>=20
> > 15. Which of the following features do you use?
> >=20
> > (multiple choice, with other)
>=20
> Very nice list!  =E2=80=9Cother=E2=80=9D seems odd --- what would the=
 expected
> response look like?

As you can see in https://www.survs.com/survey/T9FQCAWN7A (test channel=
,
might be closed when editing survey), this means that the last option
is "other (please specify)" with text field where you can write what
feature not included on the list you are using.

> > 16. Which of the following features would you like to see implement=
ed
> >     in git?
> [...]
> >  + environmental variables in config, expanding ~ and ~user
>=20
> I think we have ~ and ~user now.

Thanks, will fix.

--=20
Jakub Narebski
Poland
