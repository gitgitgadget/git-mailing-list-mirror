From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Perl version support (was Re: [PATCH] git-mv is not able to handle
 big directories)
Date: Sun, 27 Nov 2005 20:46:29 -0500
Message-ID: <438A6175.2020705@michonline.com>
References: <200511231141.57683.lan@ac-sw.com>	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>	<867jazre78.fsf@blue.stonehenge.com>	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>	<20051123135604.GB16995@mythryan2.michonline.com> <86mzjvphhj.fsf_-_@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDC30F41C65B935997DAD7559"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 02:47:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgY6J-0005nI-VX
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 02:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVK1Bqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 20:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVK1Bqg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 20:46:36 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:57771
	"EHLO h4x0r5.com") by vger.kernel.org with ESMTP id S1751211AbVK1Bqg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 20:46:36 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.54)
	id 1EgY6D-0001TP-Aw; Sun, 27 Nov 2005 20:46:33 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EgY6D-0001DT-0H; Sun, 27 Nov 2005 20:46:33 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86mzjvphhj.fsf_-_@blue.stonehenge.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12844>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC30F41C65B935997DAD7559
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Randal L. Schwartz wrote:
>>>>>>"Ryan" == Ryan Anderson <ryan@michonline.com> writes:
> Ryan> For the kernel, requiring 5.8 shouldn't be a big issue. I suspect it's
> Ryan> really only the commercial Unixes where requiring 5.8 would be annoying.
> 
> Ryan> Randal, is my guess even remotely accurate?
> 
> I'd say that 50% of the Perl-using population is at 5.6, with 25% each
> at 5.5 and 5.8.  Those on 5.5 are generally unable to upgrade Perl
> for corporate reasons.
> 
> Targetting Perl 5.6 would assist broad acceptance of git for the
> typical commercial end user.  Targetting 5.5 where possible would
> ensure practical success for everyone.
> 
> However, I have not seen the "target market" of git discussed yet
> (I came late to the party), so if support for 5.6 (or 5.5) is not chosen,
> it merely limits the market.

Well, I think the general target market[1] for Linux probably applies
here, as well.  On the other hand, the users limited to Perl 5.5 for
corporate reasons are probably also prevented from installing new tools
for general use, so the difference may not matter very much.

[1] - "World domination", of course.

-- 

Ryan Anderson
  sometimes Pug Majere

--------------enigDC30F41C65B935997DAD7559
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDimF4fhVDhkBuUKURAi2tAJoCvUyUF8zmLmzl0adIqezlAHDCkgCfaqnh
xm+WzoebKdcfbaFLa/ll4jc=
=Jaf5
-----END PGP SIGNATURE-----

--------------enigDC30F41C65B935997DAD7559--
