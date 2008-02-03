From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 06:32:31 +0100
Message-ID: <200802030632.31169.chriscool@tuxfamily.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802030321150.7372@racer.site> <871w7uitnt.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sun Feb 03 06:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLXNl-0007Rw-CE
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 06:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYBCF0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 00:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbYBCF0b
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 00:26:31 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:36507 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbYBCF0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 00:26:31 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4B4AD1AB2AD;
	Sun,  3 Feb 2008 06:26:30 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 277011AB2A8;
	Sun,  3 Feb 2008 06:26:29 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <871w7uitnt.dancerj%dancer@netfort.gr.jp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72328>

Hi,

Le dimanche 3 f=E9vrier 2008, Junichi Uekawa a =E9crit :
> There are two parts to the problem
>
> 1. Custom scripts installed in PATH
>    -> this is not a problem
>
> 2. Custom scripts calling git tools with dash notation. (git-xxx).
>    -> they need to be modified and fixed.
>
> I was initially worried about (1), but I realize now that it's a
> no-op.  Now, I am worried about (2), and I realize I have quite a few
> scripts to fix.

If you have some general purpose scripts that you can put under the GPL=
,=20
then we can perhaps integrate and fix them for you and everyone else.

Thanks in advance,
Christian.
