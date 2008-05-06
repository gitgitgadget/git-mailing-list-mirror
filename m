From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Documentation status
Date: Tue, 6 May 2008 05:11:15 +0200
Message-ID: <200805060511.15293.chriscool@tuxfamily.org>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org> <200805050548.58905.chriscool@tuxfamily.org> <7vy76pnzo9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Manoj Srivastava" <srivasta@ieee.org>,
	"Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 05:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtDWM-0002FN-8E
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 05:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYEFDGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 23:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYEFDGZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 23:06:25 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:35851 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792AbYEFDGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 23:06:24 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6937F1AB2BA;
	Tue,  6 May 2008 05:06:22 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E29101AB2B9;
	Tue,  6 May 2008 05:06:21 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy76pnzo9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81324>

Le lundi 5 mai 2008, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Le samedi 3 mai 2008, Junio C Hamano a =C3=A9crit :
> >>
> >> My preference is to move git(7) to git(1) because it is describing=
 a
> >> command at the end-user level (distros are much better than us to =
come
> >> up with a way to deal with conflict resolution between us and the
> >> other git), keep file format description in section 5 (that's wher=
e
> >> they belong to).
> >
> > Ok, I will do that.
> > Then what about tutorials (that I put in section 7) ?
>
> Please step back a bit.  What's the reason why you need to make
> everything into manpages?

Some people prefer to use man pages and they like it when all the=20
documentation is available as man pages.

Regards,
Christian.
