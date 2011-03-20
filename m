From: Kalle Launiala <kalle.launiala@gmail.com>
Subject: Industrywide breakthrough innovation - Git as a key role of distribution
Date: Sun, 20 Mar 2011 23:08:54 +0200
Message-ID: <AANLkTinkuSJBvftDCh8++UyV5Wc=sMRr1+vc8WbeFYMs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 22:09:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Prw-0000vB-L9
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab1CTVI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 17:08:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48801 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1CTVIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 17:08:55 -0400
Received: by iyb26 with SMTP id 26so5802682iyb.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=BRfk+m7+DVA+91OQlGLOVWjGDjrk6EJJerjnc7XGVto=;
        b=FpYgS/F5yg12alELyh+ZxA9fA90zhnyz8xF2SwBRjxF88WR81nJNNHOQL768U0D8KV
         0ohvsgoq1w45vhmEubLYaeGj3cJkkrxMdZGUN5PVO31HXEYFMDBrFArLwnMQBMVsljux
         d1Z2vqLEg8XqzqKV5VoGT73885PHlVBXgo6ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=wDEq7sj0pUEgwDPibswDUpnqoaQwTWn/8dyN20Me2I7ZKbx/pPr/u7cr5nX0z9NkUs
         LfLDLnhUNFC3OjdfKfvKpbAzlcij8C/8Tmn1yAcio5BC84+t1Zahh5xSxqR5mLpSOQLx
         o4GwxfNnyTscyO9g472q2SNvCe4DkLNIvPgJ4=
Received: by 10.231.150.205 with SMTP id z13mr3358539ibv.177.1300655334900;
 Sun, 20 Mar 2011 14:08:54 -0700 (PDT)
Received: by 10.231.142.16 with HTTP; Sun, 20 Mar 2011 14:08:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169526>

Respectful Git mailing list readers.

I was encouraged to "Ask the Git community directly" as is writtein
the www.git-scm.com site.


=3D=3D Disclaimer

This is not a trolling post or suggestion of something that is not
finished. The technology that I'm "lightly" referring as industry
breakthrough exists. I just happened to find out that Git (alongside
with social coding sites such as Gitorious and GitHub) already fills
up the repository and distribution technology that the "abstractions"
require.

Please do not let the current platform examples fool you; our
technology base was on Microsoft's stack, yet this technology is
totally platform agnostic. This however means that the material is
nonexistent on Linux technology demos (although there are solid
demonstrations available for Microsoft's stack).

I have tried to approach Linux community (through Linux Foundation,
LDN and finally www.linux.com, but I have failed to meet any
centralized point to help us figure out Linux development - we know
our technology, but we need help getting reference implementations on
Linux common languages to be able to abstract them).

=3D=3D=A0End of Disclaimer.


Now in brief; I claim that software development can be trivialized
(and its efficiency boosted) to absolute maximum. The technology is
ridiculously simple stack on top of existing technologies (it's
moreover a methodology).

It is by its very nature completely open and completely free, platform
agnostic. Usable by anyone; learning curve is really simple
(considering the learning includes understanding how to define the
architectural design and include reference implementation within it).

The thing that Git solves perfectly is described in this visualization:
http://abstraction.codeplex.com/wikipage?title=3DSubscribing%20to%20Ref=
erence%20Abstractions&referringTitle=3DDocumentation

The full technology case theory, key differentiators and examples
(although light with videos) can be found:
http://abstraction.codeplex.com/documentation

The absolutely trivialized software development is presented in the
documentation's first link's video followed by visualization of
multilevel abstraction stack - I know this does not open properly
without any hands-on experience on abstractions.


I am very willing and happy to discuss how this can be applied to
Linux (both applications and kernel) development, as it is applicable
to anything that needs documentation and structured implementation of
any size. This technology brings Linux in-par and way beyond of
Windows in end-developer experience; and allows huge advantage in
Linux because of its versatility (that no longer needs to be
sacrificied for solid-base for developer experience).


However in this post I am simply asking help to understand Git
properly, so that I can design the distribution mechanism (updating
both ways) and for example understand the way of making statistical
calculations (so that any individual abstraction-provider can be
ranked in terms of follow-up "repository forks").



Please apologize my newbieness in mailing lists and groups, as I have
just entered the world of open-source-development.


Happy spring from Helsinki, Finland,

Kalle Launiala
