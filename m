From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: missing object on git-gc
Date: Thu, 8 Nov 2007 06:03:40 +0100
Message-ID: <200711080603.41004.chriscool@tuxfamily.org>
References: <6C2C79E72C305246B504CBA17B5500C902535D9C@mtlexch01.mtl.com> <6C2C79E72C305246B504CBA17B5500C9029A3071@mtlexch01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Yossi Leybovich" <sleybo@mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Nov 08 05:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpzS2-0003sl-EF
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 05:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbXKHE4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 23:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbXKHE4u
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 23:56:50 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:55742 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbXKHE4t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 23:56:49 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C21301AB2B6;
	Thu,  8 Nov 2007 05:56:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 84A061AB2B2;
	Thu,  8 Nov 2007 05:56:47 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <6C2C79E72C305246B504CBA17B5500C9029A3071@mtlexch01.mtl.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63931>

There is an entry "How to fix a broken repository?" in the Git Faq on t=
he=20
wiki:

http://git.or.cz/gitwiki/GitFaq#head-ac11406480d09e2df98588e800e41b7256=
602074

Maybe it can help you.

The same topic has been discussed at least 3 times on the mailing list.
By the way, if you find these discussions on gmane, please tell us so t=
hat=20
we can add the links to the FAQ entry. (You can also add them yourself.=
)

Thanks,
Christian. =20

Le jeudi 8 novembre 2007, Yossi Leybovich a =E9crit :
> I am running the git-gc tool over my repository and get the following
> error:=20
>
> > git-gc
>
> ...
> deltifying 3308 objects...
> error: corrupt loose object '<sha1>'
> fatal: object <sha1> cannot be read .
> error: failed to run repack
> =A0
> when sha1 is 40 bytes number
> =A0
> Does any one know how I can solve thus issue?
> =A0
> Thanks
> YOssi
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
