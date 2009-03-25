From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v4 2/2] git-gui: minor spelling fix and string factorisation.
Date: Wed, 25 Mar 2009 16:28:28 +0100
Message-ID: <86d4c54o6b.fsf@lola.quinscape.zz>
References: <20090324230238.GQ23521@spearce.org>
	<20090324231900.GB14967@zoy.org>
	<fabb9a1e0903250604t2909e9bbg66c6dab82dcf3333@mail.gmail.com>
	<20090325152338.GD30959@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 16:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmV48-0000Fh-Fb
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 16:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763002AbZCYP2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 11:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763045AbZCYP2p
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 11:28:45 -0400
Received: from main.gmane.org ([80.91.229.2]:42616 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763031AbZCYP2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 11:28:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LmV21-0003I1-AJ
	for git@vger.kernel.org; Wed, 25 Mar 2009 15:28:41 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 15:28:41 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 15:28:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:f1/U8AIVbuRvvOrP3pmWaQIu/nc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114607>

Sam Hocevar <sam@zoy.org> writes:

> On Wed, Mar 25, 2009, Sverre Rabbelier wrote:
>> Heya,
>>=20
>> On Wed, Mar 25, 2009 at 00:19, Sam Hocevar <sam@zoy.org> wrote:
>> > ---
>> >  =E2=96=81=E2=96=82=E2=96=83=E2=96=84=E2=96=85=E2=96=86=E2=96=87=E2=
=96=88
>>=20
>> I'm curious, where'd this come from?
>
>    Just a few characters from the "Block Elements" Unicode block.
> For some reason, even though my locale is en_GB.UTF-8, Mutt insists
> on converting my messages to iso8859-1 when doing so does not lose
> information, resulting in corrupted patches, hence my addition of the
> above characters.
>
>    By the way, your own mailer seems to be mangling those Unicode
> characters when answering.

No, he just chose to encode them using GB2312 rather than utf-8.  But
that is not prohibited.

--=20
David Kastrup
