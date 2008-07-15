From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/6] archive: refactor and cleanup
Date: Tue, 15 Jul 2008 09:49:35 +0200
Message-ID: <487C568F.6030705@lsrfire.ath.cx>
References: <487BA74E.5070208@lsrfire.ath.cx> <487BE440.9010006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 09:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIfJ8-0005XK-Rh
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 09:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbYGOHti convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 03:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbYGOHti
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 03:49:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:42479 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbYGOHth (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 03:49:37 -0400
Received: from [10.0.1.200] (p57B7DD33.dip.t-dialin.net [87.183.221.51])
	by india601.server4you.de (Postfix) with ESMTPSA id 3DB342F8070;
	Tue, 15 Jul 2008 09:49:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487BE440.9010006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88534>

Lea Wiemann schrieb:
> Ren=C3=A9 Scharfe wrote:
>> This series is a collection of cleanups for git archive
>=20
> A few things:
>=20
> * The note quoted above probably shouldn't be in the commit message b=
ut
> after the "---".

Since it's in the zeroth message, it's not intended to be committed.

> * You patch messages seem to be In-Reply-To a message that wasn't pos=
ted
> on the list, not to PATCH 0/6.

Hmm, that's strange.  Won't happen next time, though.

> * Unless you have a specific reason, I suggest that you don't Cc Juni=
o
> on patches; he reads all messages on this list (more or less) and wil=
l
> usually simply apply your patches once they're reviewed.  (Watch for =
his
> periodical "What's cooking in git.git" messages to see if he got them=
=2E)

We're both wrong, quoth Documentation/SubmittingPatches:

    Note that your maintainer does not necessarily read everything
    on the git mailing list.  If your patch is for discussion first,
    send it "To:" the mailing list, and optionally "cc:" him.  If it
    is trivially correct or after the list reached a consensus, send
    it "To:" the maintainer and optionally "cc:" the list.

Obviously, my patches weren't trivially correct nor a consensus reached=
=2E

> * And most importantly, your Thunderbird introduced line-breaks, so i=
t's
> not possible to apply the patches.  May I suggest you use git-send-em=
ail
> instead?

Well, it is possible to send usable patches with Thunderbird, using the
extension Toggle Word Wrap.  Patches 1 and 3 are damaged because I
edited them again to correct a typo -- with word wrap accidentally on.

Trying git-send-email again is a good idea, though.

> Feel free to ping me on IRC (lea_w in #git) if you need help.

I've slacked long enough to become a complete noob again.  Oh, well.

Thanks,
Ren=C3=A9
