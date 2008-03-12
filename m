From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 11/16] config: add --literal-match option
Date: Wed, 12 Mar 2008 22:46:43 +0100
Organization: At home
Message-ID: <fr9ivq$eh0$1@ger.gmane.org>
References: <cover.1205356737.git.peff@peff.net> <20080312214019.GL26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:47:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYnS-0004p3-PQ
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYCLVqv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2008 17:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYCLVqv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:46:51 -0400
Received: from main.gmane.org ([80.91.229.2]:50273 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbYCLVqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:46:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZYmZ-0000Dh-28
	for git@vger.kernel.org; Wed, 12 Mar 2008 21:46:43 +0000
Received: from abww110.neoplus.adsl.tpnet.pl ([83.8.246.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 21:46:43 +0000
Received: from jnareb by abww110.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 21:46:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abww110.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77008>

Jeff King wrote:

> +--literal-match::
> +
> +=A0=A0=A0=A0=A0=A0=A0Some invocations of git-config will limit their=
 actions based on
> +=A0=A0=A0=A0=A0=A0=A0matching a config value to a regular expression=
=2E If this option
> +=A0=A0=A0=A0=A0=A0=A0is used, then any such matches are done as a st=
ring comparison
> +=A0=A0=A0=A0=A0=A0=A0rather than as a regular expression match.
> +

Why this option is not named --fixed-strings, as everywhere else, then?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
