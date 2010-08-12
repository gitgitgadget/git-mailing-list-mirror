From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Where do I stick development documentation?
Date: Thu, 12 Aug 2010 15:33:59 -0500
Message-ID: <20100812203359.GE2029@burratino>
References: <AANLkTi=dS1DYJ3MB-Du34sVPy8Qw8VNck=Lx54DtSfO0@mail.gmail.com>
 <20100812023922.GB19174@burratino>
 <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeV0-0006Zx-GE
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760570Ab0HLUfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:35:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49814 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760531Ab0HLUfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:35:33 -0400
Received: by ywh1 with SMTP id 1so571358ywh.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Douqv82R2a6+m3WVnu9++RwMCA7QDuIb0+EVb1NspFg=;
        b=TxsIXTNGMlOsWGhscM8B+HBzYvhnea/ITM788GehNi3ZxNQS2MfQFOOpmF/gZ6cv00
         hzmqsL7TmElDTkH1zLhd2Fusjdmi/ZImKsmoxAP0z4x/GyVXL1fQVTFrS1UmrgiYBhz4
         +x2v5tgw/tML8UQp4GiM7Aj5uBQQ6byveW2gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=blHq/GNXHJv4JeMIGUtfRHPNpvud1ugegP+zCyQel9hdIYCIJvsgo7LPa0KBSezqch
         5z+l0oSHVCXWCm3K1+m2Hi/DpUAPYHZvsNDTLczrr9pVLH/2UcAd/w1QDS9UxUKSXy2U
         UT160dZLsCIaK06av8QSIRQORRAR7HDCZ9PHM=
Received: by 10.231.182.201 with SMTP id cd9mr687519ibb.21.1281645331976;
        Thu, 12 Aug 2010 13:35:31 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id n20sm254249ibe.23.2010.08.12.13.35.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 13:35:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinPUqSywAscEG=VsYdFPwS=x0izM1cw-J1EBDGT@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153412>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>>> =C2=A0 =C2=A0* Core git concepts (that need to be translated), mayb=
e I could
>>> =C2=A0 =C2=A0 =C2=A0adopt the gitglossary to this task, but it'd ne=
ed to be a bit
>>> =C2=A0 =C2=A0 =C2=A0more structured, i.e. describe core data concep=
ts first, then
>>> =C2=A0 =C2=A0 =C2=A0some other terms.
[...]
> What I had in mind was something like this (incomplete, and mostly in
> Icelandic): http://gist.github.com/425917
>=20
> I.e. just a bulletpoint list of core terms that you need to translate
> for Git.

You may like git-gui/po/glossary/, then.

Too bad --- I was looking forward to the gitglossary improvements. :)
