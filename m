From: Jed Brown <jed@59A2.org>
Subject: Re: git grep: search whole tree by default?
Date: Wed, 23 Oct 2013 13:20:56 -0500
Message-ID: <87hac7hmrb.fsf@mcs.anl.gov>
References: <CAA01CsqgNKdDAc9OL9zdk=3tnK9GAG=6w+wP_XSoiefBOgfzRQ@mail.gmail.com> <vpqbo2guff7.fsf@anie.imag.fr> <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 23 20:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ33S-0008DI-0P
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 20:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab3JWSVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 14:21:07 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:48285 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab3JWSVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 14:21:04 -0400
Received: by mail-qa0-f48.google.com with SMTP id k4so750256qaq.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=idgnSFN7lsmyJBlc0fbazAADu0VMaGCfT9Wqjt0fadE=;
        b=pyaIDbMwNZnPttYdTJ36kA8xNeSAJdQT6Rpbbchf6e9VLxxh+mps1d5D6HTt6DJQtg
         bhuTymtCBSWpS+bSaGKqQ36zcKJ0Tk3K9MWCJrj8QQ5PMlStSvp3m77sYBg0TybmWejU
         th+3waCc1hWwdzqdeF+zKnd5xh71CeULGsGtdB4h4aU5szkvHY6Bb3nkGIs/fbDkbdCL
         sBxWvOwR88POCYCJoA3g89ieZqLVAQXHMkYKZ61pO+4aYZ0ojnDqO3hUyxIgNjfEc+nM
         oFOol5I1DDvufjfKcdjaGHdnZ0D4JWFuLeflY+Q3riUy+WbTHGkhtqxXPInOrZNKwgGH
         VzNw==
X-Received: by 10.224.14.79 with SMTP id f15mr3870667qaa.113.1382552462809;
        Wed, 23 Oct 2013 11:21:02 -0700 (PDT)
Received: from localhost (anlextwls003-063.wl.anl-external.org. [130.202.3.63])
        by mx.google.com with ESMTPSA id d7sm63927053qas.10.2013.10.23.11.21.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2013 11:21:02 -0700 (PDT)
In-Reply-To: <xmqqmwlzrjdh.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.16+100~g18ee1e2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236543>

--=-=-=
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:
> I suspect that it would be too late for 2.0 we want to do sometime
> early next year, though.

How would you manage transition from the current behavior?  Warning
people to explicitly use "." or ":/" during some interim period sounds
worse than just switching the default behavior.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaBOIAAoJEM+2iNHeMalN0eMP/jGYH/rhxBrpgJZL3Ch5Iuqp
yhMX8a6u68NIIyQfECMeYsgbXsv1edGfxhZbXVAio7Kr40Cdi66xyfPyIJ599Fli
kl9HOzJjGpKDDDJyvtTsUyPtxx9E2gVpoVIxoFacOi69fgBVXJvL6Vdk+ANDpcAG
9mwgDB6laZ5q0s2bo+nCxiRstGzsbidcj/LHdHL83imSsbxC/h1/05KGR0504GOd
CdBgkMOyyg/sTqH9owGGtJ3ePq0oH/dcxK3yDB4A6TnXM7WbNgvUidLzo5MkQf7V
STfyOasXyA0kxXOun3OzTt4RqV4sFdrKEaRR1i9Q489mebXC00MorJ7T8h9LgetH
mG7IxOMNziD0xblJCyivGIGdrY7q503cCujfh3OuZDJhUJXO0qIDcsz9L+++Hkxn
OY8CMaoEu3aS8Tjs5hQ7HSW82W5YQzJrNkDMytQcACyijUyVcFVovgix84lW5Twy
KCFUfpTbLxLqucj7EywVfemSS/jfM/qQPJfY95bCp3/CTtbm5InoXoRh2ct2UmBP
PBxopdW27yYNvLHIBWZstuE7f1Yh/QtNPs2hDxMEYFZ0nAnOKBBW67akWPQDnHNV
Dh4aC0KUmM6YNoQNMdlUrlu6LbRykY5S2Jk4OGjZIUMFl1kyVAtryOaFKMwhxmmy
s92mTkTkEWE6FeQHOUqi
=mruW
-----END PGP SIGNATURE-----
--=-=-=--
