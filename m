From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Sat, 12 Jun 2010 14:44:20 -0400
Message-ID: <4C13D584.1000604@gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>	<422F3619-25EC-4509-8EE3-78B6C765AB2A@wincent.com>	<4C12B20F.3080709@gmail.com> <AANLkTinec7_D-WHRfetVRVvmG0EGoW4ZTdiTvoGMgJvQ@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 20:44:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONVh2-0005Uo-61
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 20:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab0FLSoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 14:44:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53169 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab0FLSoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 14:44:24 -0400
Received: by gye5 with SMTP id 5so1608138gye.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4qvg4+Cpz3biEOmG+PgwqDC+h5VRHJArrR2XQmMjLfs=;
        b=xMFaomW3WGAimDopVuIYQ8OXjjxvnuiiUr2pC3l6H0kty8XcflQ1Wq1j7Y0bF8X/Oo
         onnRKm0rk8WYpfJb9CQn1Xrt5yS/YDQTJxB8Gd4h2dl32jlOEPdkFwbGrFB7t9hbZT0w
         qQeDWmp2E8CtGDfP+T66BUKucmrreTZVdS0NY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=MgAB4MFbuGBAvZes/lmlW98hjC9fgH2YPtyZz/Mnux+dnCu53fM2CZJs+fLQZHvp+Q
         PJQUKXwKT2+7lnlp375h+vGR7tJF5kw3uLSp1i8wK9j6ohj1Ci7N5yoPnz5yg8DPZMmJ
         29Vt4LbrhMM8JRyaGujQrERrq07wgP9S4MZPU=
Received: by 10.151.127.35 with SMTP id e35mr3008273ybn.168.1276368263474;
        Sat, 12 Jun 2010 11:44:23 -0700 (PDT)
Received: from [10.0.0.6] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id q8sm19334768ybk.31.2010.06.12.11.44.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 11:44:22 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <AANLkTinec7_D-WHRfetVRVvmG0EGoW4ZTdiTvoGMgJvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149028>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Jun 11, 2010 at 22:00, A Large Angry SCM <gitzilla@gmail.com>=
 wrote:
>> Can a command be listed twice? Some of these commands _really_ belon=
g in
>> more than one category.
>=20
> Of course it can. But what specific commands do you mean?
>=20

Start with git-checkout since it's a basic command and a branching comm=
and.
