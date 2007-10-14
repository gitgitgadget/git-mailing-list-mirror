From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Sun, 14 Oct 2007 18:25:31 +0200
Message-ID: <85y7e5ll38.fsf@lola.goethe.zz>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	<F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com>
	<854pgtonp5.fsf@lola.goethe.zz>
	<200710141709.51579.chriscool@tuxfamily.org>
	<4712400C.2080900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Wincent Colaiuta <win@wincent.com>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih6Gs-0001Ip-SL
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 18:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485AbXJNQYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 12:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756630AbXJNQYl
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 12:24:41 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:39119 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756464AbXJNQYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 12:24:40 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Ih6Gc-0008RN-Pq; Sun, 14 Oct 2007 12:24:38 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 877FE1C4CE11; Sun, 14 Oct 2007 18:25:31 +0200 (CEST)
In-Reply-To: <4712400C.2080900@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of "Sun\, 14 Oct 2007 18\:13\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60862>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Christian Couder schrieb:
>>=20
>> I choosed "dunno" because that was what Dscho suggested in this thre=
ad:
>>=20
>> http://thread.gmane.org/gmane.comp.version-control.git/53584/focus=3D=
53595
>>=20
>> It seems to me short and understandable at the same time.
>>=20
>> More meaningfull would be "untestable" or "cannottest" or
>> "canttest" but it's much longer, while "good" and "bad" are short.
>
> Ugly?  Neutral?

"Ugly" has a certain charm to it but would probably not translate
well.  "Limbo" would be another such candidate, probably with better
translatability.  But while some of those have some geeky appeal, I
really think something reasonably plain like "undecided" would be
better in the long run.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
