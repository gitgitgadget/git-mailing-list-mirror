From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 02:46:23 +0100
Organization: At home
Message-ID: <fifstd$ilj$1@ger.gmane.org>
References: <200711252248.27904.jnareb@gmail.com> <fiet88$68n$1@ger.gmane.org> <e5bfff550711261125i92fb057i85d7217b18cd495d@mail.gmail.com> <20071127012013.GG14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 02:47:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwpXR-0005nC-OL
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 02:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbXK0Bql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 20:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXK0Bql
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 20:46:41 -0500
Received: from main.gmane.org ([80.91.229.2]:35478 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbXK0Bqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 20:46:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IwpWv-0005hl-TP
	for git@vger.kernel.org; Tue, 27 Nov 2007 01:46:30 +0000
Received: from abvx183.neoplus.adsl.tpnet.pl ([83.8.221.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 01:46:29 +0000
Received: from jnareb by abvx183.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 01:46:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx183.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66154>

Shawn O. Pearce wrote:

[git-gui in XUL]

> But XUL doesn't support launching a process and connecting pipes
> to its stdin and stdout. =A0I started to try and create an XPCOM
> extension to provide that functionality from NSPR and started to
> run into major problems compiling the XPCOM plugin, getting the
> necessary interfaces implemented, etc.

What about Ajax / Comet support in XUL, Can this be used for that?
(Just an [perhaps stupid] idea).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
