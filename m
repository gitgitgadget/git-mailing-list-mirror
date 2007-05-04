From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Rename "bury" back to "sink".
Date: Sat, 05 May 2007 01:22:54 +0200
Organization: At home
Message-ID: <f1gf8i$p52$1@sea.gmane.org>
References: <20070504224639.26133.6157.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 01:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk77b-0006LV-Gs
	for gcvg-git@gmane.org; Sat, 05 May 2007 01:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161580AbXEDXXO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 19:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161544AbXEDXXN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 19:23:13 -0400
Received: from main.gmane.org ([80.91.229.2]:36245 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161560AbXEDXXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 19:23:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hk77B-00076P-Nx
	for git@vger.kernel.org; Sat, 05 May 2007 01:23:05 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2007 01:23:05 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2007 01:23:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46228>

Yann Dirson wrote:

> Well, it looks like the voices we heard on this naming issue were
> quite equally cast towards each of the 2 name.
>=20
> Let my vote be to get back to "sink", so the user can easily pair the
> command with "float". =A0I expect that any previously-silent majoity
> prefering "bury" will talk now, before Catalin decides if he wants
> this patch in the next release :)

I'm rather partial to "bury" rather than "sink", as "bury" has the
notation of going deeper (like "float" has notation of guing up, to
the surface), while "sink" does not need to. Additionally "sink" is
a noun as well as a verb.

> Oh, this patch reminds me we still have to activate rename
> detection...

True.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
