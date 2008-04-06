From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] merge, pull: introduce '--diffstat' option
Date: Sun, 06 Apr 2008 16:37:54 +0200
Organization: At home
Message-ID: <ftan87$5oq$1@ger.gmane.org>
References: <20080403103056.GD6673@coredump.intra.peff.net> <1207406935-22144-1-git-send-email-szeder@ira.uka.de> <200804051835.54097.tlikonen@iki.fi> <7vtzigw2wo.fsf@gitster.siamese.dyndns.org> <20080406135304.GA24269@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 16:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiW1I-0000bn-Hw
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 16:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbYDFOiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYDFOiL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 10:38:11 -0400
Received: from main.gmane.org ([80.91.229.2]:47096 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbYDFOiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 10:38:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JiW0T-0005ga-W9
	for git@vger.kernel.org; Sun, 06 Apr 2008 14:38:06 +0000
Received: from abvn127.neoplus.adsl.tpnet.pl ([83.8.211.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 14:38:05 +0000
Received: from jnareb by abvn127.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 14:38:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvn127.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78894>

Jeff King wrote:
> On Sat, Apr 05, 2008 at 11:51:51AM -0700, Junio C Hamano wrote:

>> =A0* perhaps a --log option to override the config default for each
>> =A0 =A0invocation.
[...]
>=20
> I'll add a belated "yes I agree" to this. This is what I was trying t=
o
> describe earlier in the thread, but for some reason couldn't think of
> the obvious name "log" to replace merge.summary. :)

It looks more like --shortlog, by the way...

(Stupid backwards compatibility...)
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
