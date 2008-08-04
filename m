From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: email address handling
Date: Mon, 4 Aug 2008 22:14:50 +0200
Message-ID: <20080804201450.GA15751@diana.vm.bytemark.co.uk>
References: <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org> <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011531290.6819@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808011543500.6819@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 21:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ68v-0006c8-Jv
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 21:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbYHDTxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 15:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbYHDTxg
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 15:53:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4195 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbYHDTxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 15:53:35 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ6SA-00056z-00; Mon, 04 Aug 2008 21:14:50 +0100
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808011543500.6819@nehalem.linux-foundation.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91387>

On 2008-08-01 15:49:43 -0700, Linus Torvalds wrote:

> Try to guess what something like
>
>      =3D?ISO-8859-15?Q?Linus_T=3DF6rnqvist?=3D <torvalds@linux-founda=
tion.org>
>
> is supposed to be.

Very readable to me. Because every so often some piece of software
reminds me that the =F6 in my name is 0xf6 in latin1/9 ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
