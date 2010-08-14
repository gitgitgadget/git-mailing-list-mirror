From: Chris Packham <judge.packham@gmail.com>
Subject: Re: windows smoke tester (was Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Fri, 13 Aug 2010 17:42:08 -0700
Message-ID: <4C65E660.9030707@gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>	<4C63BD9B.6000608@viscovery.net>	<AANLkTi=9_FPS=zzcZ3ndqcd83KmQ-eVT9JmLbwjiZtXz@mail.gmail.com>	<AANLkTi=N-fA9r-Akm3_=ucFYew8BhcsQoWM-Z9S8+58C@mail.gmail.com>	<AANLkTina+62MczLNhXC6VCtz_kQZ_t0+uZ8fH=vTV=XO@mail.gmail.com>	<4C64308D.8030000@gmail.com>	<AANLkTikh14FVmE6E78FNRvSG0B_5ZmNcOLSwye4ExNVx@mail.gmail.com>	<4C647360.50304@gmail.com>	<AANLkTimp5TSvjcmZG-pGtG6ep3axertqWuooS7e+A3Ow@mail.gmail.com>	<4C647C85.2080109@gmail.com> <AANLkTikuy3q8JrppTr+YPwZHFh2PNk+An2qvdoWiuAJH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	kusmabite@gmail.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4pD-0002tZ-4M
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0HNAmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 20:42:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:54000 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab0HNAmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 20:42:08 -0400
Received: by pxi10 with SMTP id 10so999320pxi.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3IkkSBJAYolg4fFYB4BRioyEZ2To0Sk8syE7Gd7cDVk=;
        b=BdKAPkNoHmrsodU7jMAAJB5nfNw6iFdIoncVvl8PRonKCNE2CRCmsUtInSISZRcDni
         XokhQlGaqAgdmNl2R5Q6Wm8KZiPWPfSwBx6kAR8jcI1v6r7/wUMUCuM89ajyJBnPZB/v
         ipiHoKR1WDr6HOCpce9e1Gw7cI9ZVmcrViV+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oCfaa86pPktHCsXnlqoc0oW1XdlG2NsulgC2JQCVvs8Sl2ZtOenfY69M0YB6AR50Zf
         zQPLge006KwI7EPwkd0hbq3XU2mVcB1WQp/+6c0AzJ4BgrKptXa0z7if72P58U8IA30S
         MzR/Y/16E6r2LaEnMU43BzbjLEnvLlt+j4sF8=
Received: by 10.115.109.6 with SMTP id l6mr2534466wam.164.1281746528133;
        Fri, 13 Aug 2010 17:42:08 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d38sm5653189wam.8.2010.08.13.17.42.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 17:42:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTikuy3q8JrppTr+YPwZHFh2PNk+An2qvdoWiuAJH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153537>

On 12/08/10 18:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> If it comes with its own perl it should also have a cpan shell:
>=20
>     perl -MCPAN -e 'install TAP::Harness::Archive'
>=20
> That should be easier than installing strawberry in addition to the
> mingw perl.

OK this is me officially giving up on windows (or at least this
particular windows box).

I couldn't install any perl modules with the environment provided by
msysgit, I couldn't make msys play nice with strawberry perl. In
desperation I tried cygwin and again I failed to get any perl modules
installed (although it did get further than msys).

I think a major part of the problem is the way the box was setup by the
IT department at work. It has its home drive set to a network share
which both cygwin and msys pick up on. This seems to cause problems for
the CPAN module when it tries to download and build stuff there.

I'd like to be able to help, but I lack the windows knowledge to change
any of the setup that was made by the IT team. If I get my hands on
another windows box with a more standard install I'll give it another
try. For now, I'm admitting defeat.

-C
