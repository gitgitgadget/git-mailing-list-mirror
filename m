From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Mar 2014, #07; Fri, 28)
Date: Sat, 29 Mar 2014 16:44:38 +0100
Message-ID: <E47EEF0E-7F4D-4ACB-A957-68588A8D05C5@quendi.de>
References: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_3794EBA1-95B7-4E74-ABA3-CD66DD4AF8D9"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 16:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTvR5-0005Gk-GO
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 16:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbaC2Poj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 11:44:39 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:49102 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614AbaC2Poi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Mar 2014 11:44:38 -0400
Received: from ip-84-118-176-11.unity-media.net ([84.118.176.11] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WTvQx-0001RS-VG; Sat, 29 Mar 2014 16:44:35 +0100
In-Reply-To: <xmqqtxai7ym6.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1396107878;d9993d1e;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245436>


--Apple-Mail=_3794EBA1-95B7-4E74-ABA3-CD66DD4AF8D9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


On 28.03.2014, at 23:21, Junio C Hamano <gitster@pobox.com> wrote:

[...]

> * ap/remote-hg-skip-null-bookmarks (2014-03-25) 1 commit
>  (merged to 'next' on 2014-03-25 at a8cd922)
> + remote-hg: do not fail on invalid bookmarks
> 
> Will merge to 'master'.


Just got back and had a chance to look at the patch you queued.
It looks good to me. Considering it is already scheduled to go
into master, I'll assume no further work from me on this is needed.
If I am wrong on that, please let me know.

Max

--Apple-Mail=_3794EBA1-95B7-4E74-ABA3-CD66DD4AF8D9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlM26moACgkQIpJVslrhe1kYdwD+MfQdqfTziIFsByWraX7AVu3v
+Mr+CG7Rjk+whWABHAMBAJxJokc5GGpAB/ZYr9w1+r/X+GRCtQ7P4L+5ySRxXRBF
=dDQU
-----END PGP SIGNATURE-----

--Apple-Mail=_3794EBA1-95B7-4E74-ABA3-CD66DD4AF8D9--
