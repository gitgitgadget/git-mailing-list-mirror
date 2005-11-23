From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: Wed, 23 Nov 2005 14:54:26 -0500
Message-ID: <4384C8F2.2070909@michonline.com>
References: <200511231141.57683.lan@ac-sw.com>	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>	<867jazre78.fsf@blue.stonehenge.com>	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>	<20051123135604.GB16995@mythryan2.michonline.com> <7vpsor5h7o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE4391D5BEB6BE01C1A7E13D8"
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 20:56:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef0hR-0006iV-JB
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 20:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVKWTye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 14:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKWTye
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 14:54:34 -0500
Received: from mail.autoweb.net ([198.172.237.26]:53149 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932269AbVKWTyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 14:54:33 -0500
Received: from 10-37-1-130.reverse.internal.autoweb.net ([10.37.1.130])
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Ef0hL-0003Hz-Di; Wed, 23 Nov 2005 14:54:32 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsor5h7o.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12648>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4391D5BEB6BE01C1A7E13D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> 
>>On Wed, Nov 23, 2005 at 12:37:59AM -0800, Junio C Hamano wrote:
>>
>>>merlyn@stonehenge.com (Randal L. Schwartz) writes:
>>>
>>>
>>>>>>>>>"Junio" == Junio C Hamano <junkio@cox.net> writes:
>>>>
>>>>Junio>             open my $oh, qw(|- git-update-index -z --stdin)
>>>>
>>
>>...
>>No, you're not using the list form for pipes.  I use that in
>>git-graft-ripple:
>>
>>	open(P,"-|","git-rev-list","--parents","--merge-order",$range)
> 
> 
> Oh, I didn't?

Sorry, I read after waking up and totally didn't see the "qw" in there.
   You did, my bad.




--------------enigE4391D5BEB6BE01C1A7E13D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhMj2fhVDhkBuUKURAo3JAJ94yfHvoZRa+uNxEk/jwWESwYOjdwCfWePo
i1QB73U/5YqvNr9av9RD5ZU=
=ZOiH
-----END PGP SIGNATURE-----

--------------enigE4391D5BEB6BE01C1A7E13D8--
