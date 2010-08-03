From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 12:08:49 +0200
Message-ID: <201008031208.50149.jnareb@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <4C57D997.5010003@drmicha.warpmail.net> <201008031202.53804.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 12:08:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgEQY-0007nu-P7
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab0HCKIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 06:08:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41727 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab0HCKIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:08:38 -0400
Received: by fxm14 with SMTP id 14so1919001fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=i3K3hWHjVpILVh/JSQE4uvsSS2Y7JdhSXDEkUe2c+8Q=;
        b=exg+4ZDzkdzqeaW1mGKs645XMMZL8XUdVwPQxKVXc+ug18WPnd20A3zK56+gWAanEY
         Is+ExLbCdCdBmXKHXaq2wgWa2XNWMaqevOo8XFZNk1qylFfhQNl52fp5K7Dv/VZoqPu8
         3sAwhXVD918qxkmeiJJ7B42/lsSuHtL4XAeJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PxShSNyKUUcxoDNW76ma68y/R3Wvj8vHbUkoE8xA5OuG60YP1SX+qC4LjSd0lLsHRz
         /cL8XZag5rLC9w4b97o2yzzWtsHR5idWnekFcmPQpRpmCx1SAV3APzoPUG2CZ6SrrvBs
         UovwkAYxYkZu9sy8KD9zvuXlPipCSbStHf6/M=
Received: by 10.223.122.208 with SMTP id m16mr7024070far.88.1280830116258;
        Tue, 03 Aug 2010 03:08:36 -0700 (PDT)
Received: from [192.168.1.13] (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id k15sm2401863fai.40.2010.08.03.03.08.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:08:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201008031202.53804.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152498>

Jakub Narebski wrote:
> 3. edit tmp.txt, changing sign of author time
>=20
> =C2=A0 $ [edit tmp.txt]
> =C2=A0 $ cat tmp.txt
> =C2=A0 tree 953e0e451fdcb5c21a25ee7ef9faade5791b95ee
> =C2=A0 parent 6a28c9c996d785b716559f57149a9b5c11fd83ff
> =C2=A0 author Jakub Narebski <jnareb@gmail.com> -12808209400 +0200

Errr... wrong file copy'n'pasted.  It was

    author Jakub Narebski <jnareb@gmail.com> -1280820940 +0200

> =C2=A0 committer Jakub Narebski <jnareb@gmail.com> 1280820940 +0200

--=20
Jakub Narebski
Poland
