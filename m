From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git Gui: initial french translation: fr.po
Date: Wed, 16 Jan 2008 08:11:27 +0100
Message-ID: <200801160811.27539.chriscool@tuxfamily.org>
References: <20080115062426.8fd03852.chriscool@tuxfamily.org> <20080116055920.GK24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 08:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF2LP-0006mZ-8t
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 08:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYAPHFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 02:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752829AbYAPHFS
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 02:05:18 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:43800 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbYAPHFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 02:05:17 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A2BFC1AB2D3;
	Wed, 16 Jan 2008 08:05:14 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 509EF1AB2BA;
	Wed, 16 Jan 2008 08:05:14 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080116055920.GK24004@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70643>

Le mercredi 16 janvier 2008, Shawn O. Pearce a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> wrote:
> > Here are some of the choices made to translate Git Gui to french:
>
> Thanks, this will be in git-gui 0.9.2.  GNU msgfmt caught a minor
> bug in the translation.  The translation on line 466 needed to have
> an LF, as the original text ended with an LF.  I inserted it when
> I applied the patch.

Thanks.

> > I just attached the file instead of sending the patch because I fea=
r
> > some encoding breakages.
>
> Next time could you please use a proper Git patch (git-format-patch)
> but attach the .patch file to your email.  Its far easier for me
> to apply.
>
> I don't mind applying translation patches sent as attachments
> (as it does help avoid mangling) but I know many folks on the list
> would still rather see them inline whenever possible.

I pushed them to the mob branch of git-gui-i18n.git a few hours ago too=
 as=20
Miklos suggested.
I will send them inline next time too.

Thanks,
Christian.=20
