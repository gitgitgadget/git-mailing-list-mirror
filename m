From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: problem pushing repository
Date: Mon, 25 Jun 2007 03:01:47 +0200
Organization: At home
Message-ID: <f5n3qj$ibg$1@sea.gmane.org>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com> <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com> <20070622022426.GA2961@bowser.ruder> <1182496916.6207.11.camel@localhost> <Pine.LNX.4.64.0706221224310.4059@racer.site> <1182519484.6207.38.camel@localhost> <20070622224712.GI17393@spearce.org> <1182593536.5937.14.camel@localhost> <20070624234759.GO17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 02:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2csR-0005QM-Pr
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 02:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbXFYA4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Jun 2007 20:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbXFYA4W
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 20:56:22 -0400
Received: from main.gmane.org ([80.91.229.2]:49299 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbXFYA4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 20:56:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I2csC-0007hw-Uf
	for git@vger.kernel.org; Mon, 25 Jun 2007 02:56:08 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 02:56:08 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 02:56:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50853>

Shawn O. Pearce wrote:

> Heh, sure. =A0I wrote that "stock" bash completion package, but at
> this point I largely consider it to be "complete and stable" and
> therefore don't put a lot of effort into it anymore.

One thing that annoys me greatly (and I think I use newest completion)
is that sometimes _filename_ completion gets confused on the '.' separa=
ting
basename and extension, and instead of completing extension it adds ano=
ther
dot to make range operator '..' and triec to complete branch name, even=
 if
basename is _not_ any branch name.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
