From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to move with history?
Date: Wed, 20 Jun 2007 00:59:15 +0200
Organization: At home
Message-ID: <f59n44$7hg$1@sea.gmane.org>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home> <20070618202918.GM3037@cs-wsok.swansea.ac.uk> <20070618210743.GA16397@steel.home> <20070619192834.GS3037@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 00:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0mfm-00014X-VQ
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 00:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258AbXFSW7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 19 Jun 2007 18:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755684AbXFSW7l
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 18:59:41 -0400
Received: from main.gmane.org ([80.91.229.2]:59285 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbXFSW7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 18:59:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0mfe-0003rV-F5
	for git@vger.kernel.org; Wed, 20 Jun 2007 00:59:34 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 00:59:34 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 00:59:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50519>

Oliver Kullmann wrote:

> =A0(b) More convenient, the upcoming "git-filter-branch" apparently
> =A0 =A0 =A0makes filtering out easier.
> =A0(c) Or, apparently more powerful, with "cg-admin-rewritehis"
> =A0 =A0 =A0(part of the cogito-tool) we have quite a powerful tool
> =A0 =A0 =A0for creating a branch with a (re-created and modified)
> =A0 =A0 =A0history (the documentation explicitely mentions how to
> =A0 =A0 =A0remove a file from history --- that is, in the new branch)=
=2E

git-filter-branch _is_ cg-admin-rewritehist (or at least should be).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
