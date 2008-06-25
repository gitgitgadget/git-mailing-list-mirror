From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 22:52:47 +0200
Organization: At home
Message-ID: <g3ub6v$7cu$1@ger.gmane.org>
References: <20080625133458.GE20361@mit.edu> <willow-jeske-01l6@3PlFEDjCVAh-01l6OB5yFEDjCYe3> <43260.7826347978$1214426654@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 22:53:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbzz-0001uD-5e
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYFYUwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 16:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYFYUwz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:52:55 -0400
Received: from main.gmane.org ([80.91.229.2]:50430 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbYFYUwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:52:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBbz4-00076Z-42
	for git@vger.kernel.org; Wed, 25 Jun 2008 20:52:54 +0000
Received: from abvw164.neoplus.adsl.tpnet.pl ([83.8.220.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 20:52:54 +0000
Received: from jnareb by abvw164.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 20:52:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw164.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86347>

<opublikowany i wys=B3any>

David Jeske wrote:

> Question: when I say "baseof:current branch", I mean "the common-ance=
stor
> between my local-repo tracking branch and the remote-repo branch it's
> tracking". How do I find that out?

git-merge-base

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
