From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Re: gitattributes don't work
Date: Tue, 4 Jan 2011 02:16:38 +0000 (UTC)
Message-ID: <iftvu6$m97$1@dough.gmane.org>
References: <ifr610$3kl$1@dough.gmane.org>
	<AANLkTikbGQkREQAx0p6Q+DrXPP2zWDU7doOO6yg+NGeC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 03:17:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZwSM-00063x-5y
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 03:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab1ADCQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jan 2011 21:16:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:47553 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab1ADCQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 21:16:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PZwSG-00062R-0T
	for git@vger.kernel.org; Tue, 04 Jan 2011 03:16:56 +0100
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 03:16:56 +0100
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 03:16:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.133 (House of Butterflies; GIT 3b0ee7d master)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164470>

On Mon, 03 Jan 2011 11:34:00 +0700, Nguyen Thai Ngoc Duy wrote:

> 2011/1/3 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
>>
>> According to gitattributes(5) it supports patterns from gitignore(5)=
=2E
>=20
> While gitattributes(5) says that, actually gitattributes and gitignor=
e
> [snip]
> Yeah, it looks like a bug to me. A better way to solve this once and =
for
> [snip]
> For the time being, anyone who changes gitignore should be reminded t=
o
> consider whether it's applicable to gitattributes and vice versa.

I think that for the time being at least the manual page must change to=
=20
reflect reality.
