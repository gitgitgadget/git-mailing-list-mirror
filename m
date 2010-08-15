From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Pack v4
Date: Sun, 15 Aug 2010 11:45:17 +1000
Message-ID: <AANLkTimtxHtHt62TdKYQtq0ZYKAWidnbZv9mUrxaetXt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 03:45:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkSI3-0004HD-Hq
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 03:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644Ab0HOBpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 21:45:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52365 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab0HOBpS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 21:45:18 -0400
Received: by wwj40 with SMTP id 40so4774139wwj.1
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 18:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=ksBUeUV0SQfHPEoNjW+86KAg7wBgZxgA9dVzzZB8URA=;
        b=OkQKAoXePdMvLLCHyOqYdWKw1a6nD/0IOf1cirJiQlEpr0sebR7hAO9a+Ck/FWzyAv
         BXlpHZztpuD9AByUCQTL5EuXF+Ox8QRkonjlTu0CNhBay4hAtJER9Nl3uCKMOF2ooGHp
         c95VYao/qxeHSE/ubtfF0fhJllB4xIyrCADoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=L5DkpW4IVuPH98nqLyBh/GrAkNGvDHwHfeGKFdnkENsw7gsOv5sn5pqOrtQvCblHce
         0xjkZGjuOE4AeIrTd7y1ubzeXPvLnIlIEIu73oyf6LJgR37Jmn6OCZmTAyHXKJYILsgd
         B9/9HUBaLWgyEstVt3qdGPMBc4LcZyFFB82YY=
Received: by 10.216.38.20 with SMTP id z20mr2859347wea.108.1281836717059; Sat,
 14 Aug 2010 18:45:17 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Sat, 14 Aug 2010 18:45:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153590>

2010/8/15 Jakub Narebski <jnareb@gmail.com>:
> But we don't have packv4 yet, even though it is 3 years since a5bbda8=
=2E
> It looks like packv4 development moves with the speed of Perl 6
> development. =C2=A0But if Rakudo * (Perl 6 implementation) could have=
 get
> released (even if it is developers release), then there is hope for
> packv4 yet... I hope...

Yeah. As long as it does not go the way of Duke Nukem Forever, it'll
be there some day :)
--=20
Duy
