From: Jochen Roemling <jochen@roemling.net>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 23:50:40 +0200
Message-ID: <4262DA30.2030500@roemling.net>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 23:48:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHbx-0006qq-HA
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 23:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVDQVvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Apr 2005 17:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVDQVvB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 17:51:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:11754 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261497AbVDQVur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 17:50:47 -0400
Received: from pD9E68CCA.dip.t-dialin.net[217.230.140.202] (helo=[10.3.24.50])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML25U-1DNHf605SG-0003qq; Sun, 17 Apr 2005 23:50:40 +0200
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35bace2e8eeec41a1b9500b782c09cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:

>Ie we have two phases to the merge: first get the objects, with someth=
ing
>like
>
>	repo=3Dkernel.org:/pub/kernel/people/torvalds/linux-2.6.git
>	rsync --ignore-existing -acv $(repo)/ .git/
> =20
>
Could you place a tarball there for people like me who are no "real"=20
kernel hackers and don't have a kernel.org account? Or is there an=20
"anonymous" account that I'm just to ignorant to know of?

I'm just somebody who is very interested in the new things happening=20
here, but I guess there will be some month to go and a lot of things to=
=20
learn until you see the first kernel patch that is signed off by me. :-=
)

By the way: Does the git repository include all 60.000 changes of just=20
the latest version of the 17.000 file in the kernel?

Best regards
Jochen R=F6mling
