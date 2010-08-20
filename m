From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [PATCH] tests: fix syntax error in "Use advise() for hints" test
Date: Fri, 20 Aug 2010 15:43:24 +0530
Message-ID: <87aaohwq0r.fsf@hariville.hurrynot.org>
References: <20100811083100.GA16495@burratino>
	<1282142204-14720-1-git-send-email-avarab@gmail.com>
	<20100819043036.GD25649@burratino>
	<AANLkTikDq4eJfm2RnbGDuJMHCR8_4cn6NfJpoYWHbWWN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 13:27:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmPkZ-0000S1-H2
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 13:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab0HTL1B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 07:27:01 -0400
Received: from lo.gmane.org ([80.91.229.12]:52820 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0HTL1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 07:27:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OmPkN-0000NO-K8
	for git@vger.kernel.org; Fri, 20 Aug 2010 13:26:55 +0200
Received: from 117.192.158.24 ([117.192.158.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 13:26:55 +0200
Received: from harinath by 117.192.158.24 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 13:26:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.158.24
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:dkgBb7SiwbsMjCq/3oyIyvATYTc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154015>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Aug 19, 2010 at 04:30, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
[snip]
>> Although the style you chose is arguably the least ugly, nested shel=
l
>> interpolation can be hard to follow. =C2=A0How about this?
>
> I think '\'' is harder to follow than \" and \$, but each to his own
> :)

There's also the slightly longer but somewhat prettier '"'"'.

- Hari
