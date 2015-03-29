From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 99 new messages
Date: Sun, 29 Mar 2015 17:48:36 +0200
Message-ID: <55181ED4.7020805@gmail.com>
References: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TjV7kMUXEEAagxG2eLVM3RhtBxdw21QW9"
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 17:48:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcFSC-0003me-An
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 17:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbbC2Psl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 11:48:41 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36962 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbC2Psl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 11:48:41 -0400
Received: by wiaa2 with SMTP id a2so93760142wia.0
        for <git@vger.kernel.org>; Sun, 29 Mar 2015 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=/nJ/4hk0gfsxH1A5IS3EKmmPFxwT/vmzvL97QC/NEyI=;
        b=ygGNykTfZKneMLTwdc6bJHEpAuhNjkIsw+PXwRnEYEgy6nmQSRm9Z5xDACicakz8nt
         5wfvlGFn5Rbf84jv8aP0q6nvDla3kpdUud1iuyUIjTSvlMkrY6VoByLclpliLN8uDDuo
         q3rXHsm7HJv4r9+7QXyPQnB2DcQUKRoorejv/hDm4Sp48g4nBToey0YPL9d1YlZ7K/4E
         G57G8XPUWtuunWvFgp9YznSB5Lu5fE/LG2e6nCtIOoAf8AE9O8qumjcN2fciLqf5Iruq
         i8Duu2llINqpJY7YO9B4EEgjo/naQCkBYOcg5nGJiOp1EuldCLB+iGQimKrVVmvRCiWI
         o+sA==
X-Received: by 10.180.212.40 with SMTP id nh8mr14407481wic.86.1427644119531;
        Sun, 29 Mar 2015 08:48:39 -0700 (PDT)
Received: from [192.168.178.21] (i577ABD35.versanet.de. [87.122.189.53])
        by mx.google.com with ESMTPSA id wo10sm11691861wjb.35.2015.03.29.08.48.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2015 08:48:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266439>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TjV7kMUXEEAagxG2eLVM3RhtBxdw21QW9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

>  #: builtin/apply.c:3238
> -#, fuzzy, c-format
> +#, c-format
>  msgid "reading from '%s' beyond a symbolic link"
> -msgstr "Pfadspezifikation '%s' ist hinter einem symbolischen Verweis"
> +msgstr "Lese von '%s' hinter einem symbolischen Verweis"

"Lese von '%s', welches sich hinter einem symbolischen Verweis verbirgt"

Maybe that's better?
Also I'm not so sure what this string should actually mean.

Phillip


--TjV7kMUXEEAagxG2eLVM3RhtBxdw21QW9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGB7UAAoJEJIt6Cqh4sVSzlIH/iCHPL7gNO6BGCYHH0kEEtp9
EHwrXiiX5b8+DJ35e2TNzujNUcwWTaDDWi9Ph1tI8VGVs4UqsAL/tVsP7SD1rW0i
QScQgwkDxY7uxHIOSGumYDD5muIeV6vq3+kG308egrYVYv2Me+Mpffh0oYk9Sf3J
9i8TIOOLCedu0VBoxnL+6fgFSqwM3bdkhkGrbIFdJog2gdI6Fw1QVRCktEM+IwgV
8GyvqtCTHe6V+9cvpXhZxfWi3UXLwwWQdkh7HzosMNIAHCvvf0zqJ30vG3keMcP9
A66kslg8bIX23LhFwyRqNqMpWR0WZKKKETspqRqBTVg16TZ2odVfqVALO3LXpFA=
=/EIm
-----END PGP SIGNATURE-----

--TjV7kMUXEEAagxG2eLVM3RhtBxdw21QW9--
