From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Thu, 28 Feb 2008 04:53:11 +0100
Message-ID: <200802280453.11446.chriscool@tuxfamily.org>
References: <20080226070648.5d799056.chriscool@tuxfamily.org> <200802280200.m1S207i0006525@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net, pascal@obry.net
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:48:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZkZ-0000S2-N5
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbYB1Dr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 22:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755089AbYB1Dr1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:47:27 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56805 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbYB1Dr1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 22:47:27 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5F7781AB2C6;
	Thu, 28 Feb 2008 04:47:26 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 456171AB2C0;
	Thu, 28 Feb 2008 04:47:26 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200802280200.m1S207i0006525@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75349>

Le jeudi 28 f=E9vrier 2008, Xavier Maillard a =E9crit :
>    Note that "emacsclient" is used with option "-e" to launch "woman"
>    on emacs and this works only on versions >=3D 22.
>
> Although reading the code, I find it nicely done, it wouldn't
> apply on my current git repository without modifications.
>
> Did you rebase your work before your patch submission ?

Yes, it was rebased on the 'next' branch.

I will send an updated patch based on 'next' soon.

Thanks,
Christian.
