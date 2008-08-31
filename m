From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Document sendemail.envelopesender configuration
Date: Sun, 31 Aug 2008 23:01:11 +0200
Organization: At home
Message-ID: <g9f0qk$sp2$1@ger.gmane.org>
References: <1A4402DD-03B5-4951-B8CA-DB8A8E93D8C4@develooper.com> <1220214763-25790-1-git-send-email-ask@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 23:02:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZu41-0007Bt-D9
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 23:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751AbYHaVBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2008 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757749AbYHaVBU
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 17:01:20 -0400
Received: from main.gmane.org ([80.91.229.2]:54549 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbYHaVBT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 17:01:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KZu2t-0003D3-Gn
	for git@vger.kernel.org; Sun, 31 Aug 2008 21:01:15 +0000
Received: from abvq20.neoplus.adsl.tpnet.pl ([83.8.214.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 21:01:15 +0000
Received: from jnareb by abvq20.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Aug 2008 21:01:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq20.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94510>

Ask Bj?rn Hansen wrote:

> +=A0=A0=A0=A0=A0=A0=A0Default is the value of the 'sendemail.envelope=
sender' configuration
> + =A0=A0=A0=A0=A0=A0value; if that is unspecified, choosing the envel=
ope sender is left

s/configuration value/configuration variable/

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
