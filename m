From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig] typo in man tig
Date: Wed, 25 Feb 2009 22:58:01 +0100
Message-ID: <2c6b72b30902251358x590c953dk9df2e3d90a1d9e24@mail.gmail.com>
References: <20090223054118.GB7435@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRmw-0007s8-Ov
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758814AbZBYV6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 16:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbZBYV6G
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:58:06 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:52291 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbZBYV6F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 16:58:05 -0500
Received: by bwz26 with SMTP id 26so208101bwz.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 13:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=10Ut1snEsnXJxYwp2jyToj5yk7tvPOejSfuyuG0RDD8=;
        b=JAKQLkW0pKK7AqYKIGUwVQnzhSAlLg9AFPsiRsvJhiYsIDWNRpA6+1elDxwMUDYUQl
         8YGk/2dvl5DZoKrFhFz1onxmfGylUyRRKhptQTTon8dnaCqUvAshLi/3/sIdZRt+dBPj
         WQg42aAcDngC0h1jwYhbcMJBZOyI21vDYyeJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=gBCCYejHZhPK6inBq4MtYrgBnvr6RA9dgcbvuVWT8MJ9PWIWP2J5JI0MooZX0BRSMV
         VKufqbfqgiE0YYkOKCPmOkCYZlVdFs3r+HlCqkfd6eVtMMomXfp0U83AOgdbhkPBTI8h
         0HRKgV727JDvDbQjauCPIkhosyJVk7fdu/5F8=
Received: by 10.181.158.3 with SMTP id k3mr183417bko.134.1235599081272; Wed, 
	25 Feb 2009 13:58:01 -0800 (PST)
In-Reply-To: <20090223054118.GB7435@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111502>

2009/2/23 bill lam <cbill.lam@gmail.com>:
> In man tig example section,
>
> =A0 =A0 =A0 =A0 =A0 [...]
> =A0 =A0 =A0 =A0 =A0 set encoding =3D "UTF-8" =A0 =A0 =A0 =A0 =A0# Com=
mit encoding
>
> the last variable should be commit-encoding

This has already been fixed in tig-0.14.1

http://repo.or.cz/w/tig.git?h=3D7b507b4156865c87a78f9ae8b22267264b9f908=
3

--=20
Jonas Fonseca
