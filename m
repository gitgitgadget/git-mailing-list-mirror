From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sun, 15 May 2011 07:56:03 -0500
Message-ID: <20110515125603.GA3178@elie>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
 <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
 <20110514192154.GA17271@elie>
 <BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 14:56:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLaro-0002TD-0p
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 14:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118Ab1EOM4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 08:56:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60993 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390Ab1EOM4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 08:56:09 -0400
Received: by iyb14 with SMTP id 14so3097675iyb.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZF38so4Xcb31ISwJTiXvTzsJwryGw9XDDVlV8AChnwg=;
        b=W4XZnTfIhb599llxQmiLHrOvUSoxK6yGslnXB/RFsz1nIzI2x2jIY3s7KK/TUaAQ05
         UPqaAhuqhpZITKp05+lRI5F4n7UgV4PgDlljh19eXVH6gRBAVVMN0uMYC2K1Y16/0WnR
         9oxXsmFmk+sZwGxRjtvZf3DDf+8mktZk2Jles=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GIgXWSA9b/UegnTTGx2gjUNXNWIyhOH7DHpeUKKC0t4JCXBkZM6bg/CzJ5oX/BTjLd
         HVsrhPlVKTEorHOWlNMtPdNBFPUAbo35DaIL3v3wjbM9gfOBb57NIKIcwaUdnK+aB1eE
         YpnSVKbKd/gIzpTrFdUBi9JGaIOQG10/doT3w=
Received: by 10.42.180.198 with SMTP id bv6mr3940622icb.398.1305464168901;
        Sun, 15 May 2011 05:56:08 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id a1sm1609065ics.4.2011.05.15.05.56.07
        (version=SSLv3 cipher=OTHER);
        Sun, 15 May 2011 05:56:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173631>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We went over this for the main gettext series.

I mean no unkindness by this: Junio's answer was a little more
helpful.

> Having a merge strategy to deal with them would be nice, but that can
> be done by using the existing gitattributes config + msgmerge(1) to d=
o
> the work.

Could you spell that out?  I haven't seen a working example of such
configuration before, and when I tried I wasn't able to get msgmerge
to do it.  I'd be happy to summarize the result of such an explanation
as an example for the gitattributes manpage.
