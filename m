From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/resend] add--interactive: allow diff colors without interactive colors
Date: Sat, 05 Jan 2008 12:37:07 +0100
Organization: At home
Message-ID: <flnq4s$ujt$1@ger.gmane.org>
References: <20080104083521.GB3354@coredump.intra.peff.net> <7v3atdi0na.fsf@gitster.siamese.dyndns.org> <1199530684.6209.6.camel@futex>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 12:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB7LW-00024b-Kv
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 12:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbYAELhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2008 06:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbYAELhS
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 06:37:18 -0500
Received: from main.gmane.org ([80.91.229.2]:57925 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbYAELhR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 06:37:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JB7Kx-0007yz-6T
	for git@vger.kernel.org; Sat, 05 Jan 2008 11:37:11 +0000
Received: from abwq50.neoplus.adsl.tpnet.pl ([83.8.240.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 11:37:11 +0000
Received: from jnareb by abwq50.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 11:37:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwq50.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69667>

Matthias Kestenholz wrote:

> +color.git::
> +=A0=A0=A0=A0=A0=A0=A0When set to `always`, always use colors in all =
git commands which
> +=A0=A0=A0=A0=A0=A0=A0are capable of colored output. When false (or `=
never`), never. When
> +=A0=A0=A0=A0=A0=A0=A0set to `true` or `auto`, use colors only when t=
he output is to the
> +=A0=A0=A0=A0=A0=A0=A0terminal. Defaults to false.
> +

Not "color.ui"?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
