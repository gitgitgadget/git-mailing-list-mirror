From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-Mediawiki: Future of the project
Date: Fri, 10 Jun 2011 06:22:01 -0700 (PDT)
Message-ID: <m3zklpddqm.fsf@localhost.localdomain>
References: <BANLkTimViRhN+mDWpHRbcFLs=DDgXU+EMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sylvain Boulme <sylvain.boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Claire Fousse <Claire.Fousse@ensimag.imag.fr>,
	=?iso-8859-15?q?J=E9r=E9mie_Nikaes?= 
	<Jeremie.Nikaes@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 10 15:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV1fG-0001NT-Om
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 15:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab1FJNWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 09:22:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45689 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684Ab1FJNWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 09:22:03 -0400
Received: by wwa36 with SMTP id 36so2776397wwa.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=2pWRx/GFR0sG1XGPx6a/i7ToqHLig65U739sWjXbQfw=;
        b=GBbQZEVNW5wk9XbdBWr/qXEGZ6t+HISIjMAUi7GnwqGA+l6lHM4uOFgOM1kZrMSaen
         fpdZXZD0vNdxAp1dECvUBh3asfkCR9tiZp5V6FpJ6I/kw/KJLqkj5Hw2FK9wgRp95WB1
         ByXc1OcZJIrv+MGwflBP6jLGqOPUyNuCeU6DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=OjXjIJMA2yrhvwjQw/1c3MbAu14Kpn5SUhMz5f0gNAP4j6Mes53jSZunG5AiDfYLY/
         HIO4Fqk7JJAx5NyZVmtKErSHC8+O++C3Y6J1xDYSC29MetKTZ6VQ5mxZ/lxvrJ4GgZiH
         zvOikxyQzjA0wLE2kPjPuYtIEt3wXMbp9/dE0=
Received: by 10.227.164.202 with SMTP id f10mr2173099wby.92.1307712122023;
        Fri, 10 Jun 2011 06:22:02 -0700 (PDT)
Received: from localhost.localdomain (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id b10sm2022386wbh.43.2011.06.10.06.21.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 06:22:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5ADLGv8018078;
	Fri, 10 Jun 2011 15:21:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5ADKoW9018064;
	Fri, 10 Jun 2011 15:20:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTimViRhN+mDWpHRbcFLs=DDgXU+EMA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175609>

Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr> writes:

> This is the end of our school project meaning we won't be able to
> spend as much time as in the past three weeks on Git Mediawiki.

[...]

> The full documentation of our project is on this github :
> https://github.com/Bibzball/Git-Mediawiki/
>=20
> Thank you all!
>=20
> Best regards.
>=20
> Arnaud Lacurie, J=E9r=E9mie Nikaes, Claire Fousse, David Amouyal

Could you please add short information about this project in correct
place on "Interfaces, frontends and tools" page on Git Wiki?  Thanks
in advance.

  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

--=20
Jakub Narebski
Poland
ShadeHawk on #git
