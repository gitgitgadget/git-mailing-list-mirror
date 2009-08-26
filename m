From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 -- mark
Date: Wed, 26 Aug 2009 10:57:10 +0200
Organization: At home
Message-ID: <h72td7$cu6$1@ger.gmane.org>
References: <7v3a7g501e.fsf@alter.siamese.dyndns.org> <fc2ecb5cf28cabb7d183e2835ce46aa9afb2a322.1251215299.git.nicolas.s.dev@gmx.fr> <7vvdkbl4ul.fsf@alter.siamese.dyndns.org> <7veiqzjmy7.fsf@alter.siamese.dyndns.org> <20090826050224.GK3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 10:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgEKA-0001KO-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 10:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbZHZI5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 04:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbZHZI5e
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 04:57:34 -0400
Received: from lo.gmane.org ([80.91.229.12]:33862 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbZHZI5d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 04:57:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MgEJx-0001GM-O0
	for git@vger.kernel.org; Wed, 26 Aug 2009 10:57:33 +0200
Received: from abwl95.neoplus.adsl.tpnet.pl ([83.8.235.95])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 10:57:33 +0200
Received: from jnareb by abwl95.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 10:57:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwl95.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127071>

Nicolas Sebrecht wrote:

> For people who _really_ want to obey to scissors by default I'll add =
an
> option to git-config. Whithout more comments, I'll add
>=20
> =A0 scissors.obey

mailsplit.scissors

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
