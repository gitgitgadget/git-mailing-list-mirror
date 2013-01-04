From: Micheil Smith <micheil@brandedcode.com>
Subject: Re: Proposal for git stash rename
Date: Fri, 4 Jan 2013 18:25:07 +0000 (UTC)
Message-ID: <loom.20130104T192132-16@post.gmane.org>
References: <20100620093142.GF24805@occam.hewgill.net> <AANLkTimjEksHI4nlefqmNzdNiseVyMQcw312g2AHFQDZ@mail.gmail.com> <20100620111112.GH24805@occam.hewgill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 19:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrC26-0008P5-TL
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 19:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab3ADS34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jan 2013 13:29:56 -0500
Received: from plane.gmane.org ([80.91.229.3]:37125 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631Ab3ADS3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 13:29:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TrC1s-0008GG-3a
	for git@vger.kernel.org; Fri, 04 Jan 2013 19:30:04 +0100
Received: from 109-224-128-70.bb.adsl24.co.uk ([109-224-128-70.bb.adsl24.co.uk])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 19:30:04 +0100
Received: from micheil by 109-224-128-70.bb.adsl24.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 19:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.224.128.70 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.45 Safari/537.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212636>

Greg Hewgill <greg <at> hewgill.com> writes:

>=20
> On Sun, Jun 20, 2010 at 10:54:43AM +0000, ??var Arnfj??r?? Bjarmason =
wrote:
> > It's good to post a WIP PATCH even if it needs cleanup, just as a
> > point for further discussion.
>=20
> Thanks, point taken. WIP patch follows.
>=20
> This patch implements a "git stash rename" using a new
> "git reflog update" command that updates the message associated
> with a reflog entry.
> ---
> [--snip--]

Hi,=20

I note that this proposal is now two years old. A work in progress patc=
h was=20
requested, however, after one was given this thread ended. I'm also fin=
ding=20
a need for this feature;

Not to try and bump an old thread, but what's the best way to land this=
?

=E2=80=93 Micheil Smith
@miksago
