From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 16:43:22 +0100
Message-ID: <87ps9d7j6t.fsf@morpheus.local>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 16:44:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Cx8-0005L9-PL
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbXAQPnw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbXAQPnw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 10:43:52 -0500
Received: from main.gmane.org ([80.91.229.2]:45354 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932500AbXAQPnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 10:43:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H7Cwt-00015R-Ml
	for git@vger.kernel.org; Wed, 17 Jan 2007 16:43:39 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 16:43:39 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 16:43:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:X6Z1mNLKHFmvWE1A4JSVblkrRjQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37011>

"Josh Boyer" <jwboyer@gmail.com> writes:

> Hi All,
>
> I use git quite a bit to track my changes and then use
> git-format-patch to generate patches to send on to others.  For the
> most part, it works great but I find myself constantly doing:
>
> mv xxxx-foo.txt xxxx-foo.patch

Seconded. I would even prefer .patch to be default, but I guess a
config parameter would help me there.

--=20
David K=C3=A5gedal
