From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 09:50:06 +0100
Organization: At home
Message-ID: <epho1l$iv7$1@sea.gmane.org>
References: <20070127062826.GE14205@fieldses.org> <20070128002246.GA10179@moooo.ath.cx> <Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org> <20070128013452.GA11244@moooo.ath.cx> <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 28 09:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB5iw-00056R-Ns
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 09:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXA1ItI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 28 Jan 2007 03:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbXA1ItI
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 03:49:08 -0500
Received: from main.gmane.org ([80.91.229.2]:41991 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbXA1ItH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 03:49:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HB5ic-0000tK-BY
	for git@vger.kernel.org; Sun, 28 Jan 2007 09:48:58 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Jan 2007 09:48:58 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Jan 2007 09:48:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38024>

Linus Torvalds wrote:

> What would also mean that we'd have the man-page with a simple
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0man git-config
>=20
> which makes tons of sense if it documents both the config file *and* =
the=20
> "git config" program.

Actually it should be git-config(5) for format and git-config(1) for
program ;-P
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
