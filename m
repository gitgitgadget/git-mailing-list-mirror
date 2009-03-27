From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: sending patch sets (was: Re: [PATCH 01/10] refs: add "for_each_bisect_ref" function)
Date: Fri, 27 Mar 2009 08:22:00 +0100
Message-ID: <200903270822.01209.chriscool@tuxfamily.org>
References: <20090326055509.1bc16b28.chriscool@tuxfamily.org> <200903270141.57426.chriscool@tuxfamily.org> <alpine.LNX.2.00.0903270126210.25399@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Mar 27 08:24:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln6Qf-0007i8-1w
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 08:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbZC0HXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 03:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZC0HXH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 03:23:07 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:53464 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbZC0HXG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 03:23:06 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id E2F1C4B0093;
	Fri, 27 Mar 2009 08:22:53 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 036504B0085;
	Fri, 27 Mar 2009 08:22:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0903270126210.25399@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114866>

Le vendredi 27 mars 2009, Julian Phillips a =E9crit :
> On Fri, 27 Mar 2009, Christian Couder wrote:
> > If someone knows some other tools that can easily send a threaded p=
atch
> > series, I will try to see if I can use them...
>
> I long ago gave up on send-email, as it seemed to cumbersome for what=
 I
> wanted, and my perl had got so rusty I really couldn't face trying to
> improve it.
>
> So I wrote a replacement in Python (attached), which I have subsequen=
tly
> used for all patches I've sent.  It calls format-patch, passing throu=
gh
> arguments (and you can use -- to let it pass options too).
>
> (the only setting it reads from git config atm is mail-commit.to)
>
> I find it much easier to use than send-email, but as usual YMMV ...

Thanks I will try to have a look at it,
Christian.
