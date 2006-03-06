From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-annotate(1) and git-blame(1)
Date: Mon, 06 Mar 2006 01:30:46 -0500
Message-ID: <440BD716.4010400@michonline.com>
References: <20060306052444.GC6487@diku.dk> <7v3bhwcezy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBBDD98B6D95D3179CB8F717F"
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 07:31:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG9FF-0000nL-I2
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 07:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWCFGa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 01:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWCFGa7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 01:30:59 -0500
Received: from mail.autoweb.net ([198.172.237.26]:63681 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751596AbWCFGa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 01:30:58 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FG9F8-0000mC-Vb; Mon, 06 Mar 2006 01:30:56 -0500
Received: from [10.254.251.12] (helo=mythryan.michonline.com)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG9F4-0005dE-3U; Mon, 06 Mar 2006 01:30:50 -0500
Received: from localhost ([127.0.0.1])
	by mythryan.michonline.com with esmtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FG9F3-0004Iq-PI; Mon, 06 Mar 2006 01:30:49 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bhwcezy.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17280>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBBDD98B6D95D3179CB8F717F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:

>Jonas Fonseca <fonseca@diku.dk> writes:
>
>  
>
>>Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>>    
>>
>
>Wonderful, but I was hoping the "deathmatch" would leave only
>one that needs to be documented and we could wait documenting
>until then ;-).
>  
>
heh.  If I'm not mistaken, blame is still lacking rename following (at
least, in master), and annotate is still misrepresenting things on
merges, so we've got a bit of a ways to go still.

-- 

Ryan Anderson
  sometimes Pug Majere


--------------enigBBDD98B6D95D3179CB8F717F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEC9cZfhVDhkBuUKURArxiAKDViX5q0vj603u7ozj72Er+i8JvHACg69Ne
cXH6+N8pvZIUMHNfL/bG0zM=
=LNIN
-----END PGP SIGNATURE-----

--------------enigBBDD98B6D95D3179CB8F717F--
