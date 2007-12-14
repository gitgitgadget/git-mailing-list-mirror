From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [BUG] Failed to make install-info
Date: Fri, 14 Dec 2007 06:35:39 +0100
Message-ID: <200712140635.39311.chriscool@tuxfamily.org>
References: <E1J2q92-0001YT-BZ@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:29:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J337K-0007Wl-NY
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbXLNF3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 00:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXLNF3Y
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:29:24 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58526 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbXLNF3X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 00:29:23 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 402991AB2C3;
	Fri, 14 Dec 2007 06:29:21 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 217FC1AB2BE;
	Fri, 14 Dec 2007 06:29:18 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <E1J2q92-0001YT-BZ@jdl.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68226>

Le jeudi 13 d=E9cembre 2007, Jon Loeliger a =E9crit :
> Guys,
> I managed to fail to install info files during:
>
>     /usr/src/git# make prefix=3D/usr install-info

I am also struggling with "make install-info" to make it install in=20
~/share/info/dir=20

=46irst it barfed because "~/share/info/dir" did not exist.

Then it doesn't find "install-info" because it's in "/usr/sbin" on my d=
ebian=20
machine.

I well tell if I get the same error as you. But right now I cannot=20
invastigate more.

Thanks,
Christian.
