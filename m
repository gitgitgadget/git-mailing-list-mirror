From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Modified the default git help message to be grouped by topic
Date: Wed, 03 Dec 2008 01:47:56 +0100
Organization: At home
Message-ID: <gh4kub$rh3$1@ger.gmane.org>
References: <20081201173037.GA41967@agadorsparticus> <20081201183258.GB24443@coredump.intra.peff.net> <7v7i6jqriv.fsf@gitster.siamese.dyndns.org> <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com> <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com> <alpine.DEB.1.00.0812022353410.27091@racer> <20081202233004.GA22379@coredump.intra.peff.net> <7vfxl6m84g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 01:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7fuu-00025e-JP
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 01:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbYLCArT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2008 19:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYLCArT
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 19:47:19 -0500
Received: from main.gmane.org ([80.91.229.2]:54063 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbYLCArS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 19:47:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L7ftb-0005Oo-V1
	for git@vger.kernel.org; Wed, 03 Dec 2008 00:47:15 +0000
Received: from abvk204.neoplus.adsl.tpnet.pl ([83.8.208.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 00:47:15 +0000
Received: from jnareb by abvk204.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 00:47:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvk204.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102194>

Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
>> On Tue, Dec 02, 2008 at 11:55:03PM +0100, Johannes Schindelin wrote:
>>
>>> If the whole thing gets longer than 24 lines, we have to leave some=
 things=20
>>> out. =A0Personally, I consider rm and mv unimportant enough that th=
ey could=20
>>> be shown in an extended list, but be left out of the summary page.
>>
>> For the record, the current output is 26 lines, plus you probably wa=
nt
>> to account for 1 line of the user's next shell prompt. So we are 3 l=
ines
>> over already.
>>
>> Scott's proposal is about grouping the commands more sensibly. Many =
of
>> the complaints are about the length of the output. Maybe we should s=
crap
>> having a list of commands altogether and just point at section-speci=
fic
>> documentation, each of which could discuss basic commands related to=
 it.
>>
>> I think there has been mention of task-oriented documentation pointe=
rs
>> before, and I think this is a place where we would want it.
>=20
> It might not be a bad idea to make this "top page help" into an
> interactive hierarchical help topic browser.

Isn't that info?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
