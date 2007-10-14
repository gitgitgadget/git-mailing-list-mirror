From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Sun, 14 Oct 2007 17:09:51 +0200
Message-ID: <200710141709.51579.chriscool@tuxfamily.org>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com> <854pgtonp5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 17:03:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih4zr-0006Df-L8
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 17:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbXJNPCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 11:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756707AbXJNPCv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 11:02:51 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40619 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756207AbXJNPCt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 11:02:49 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 74B9E1AB2B2;
	Sun, 14 Oct 2007 17:02:47 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1AB1A1AB2B6;
	Sun, 14 Oct 2007 17:02:46 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <854pgtonp5.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60854>

Le dimanche 14 octobre 2007, David Kastrup a =E9crit :
> Wincent Colaiuta <win@wincent.com> writes:
> > El 14/10/2007, a las 14:28, Christian Couder escribi=F3:
> >> Here is my bisect dunno patch series again.
> >
> > Good work on the series, Christian, but don't you think that
> > "unknown" would sound a little bit better than "dunno"? For people
> > who don't speak English as a second language "dunno" might not be
> > immediately clear.
>
> "undecided"?

I choosed "dunno" because that was what Dscho suggested in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/53584/focus=3D53=
595

It seems to me short and understandable at the same time.

More meaningfull would be "untestable" or "cannottest" or "canttest" bu=
t=20
it's much longer, while "good" and "bad" are short.

Christian.
