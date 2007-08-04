From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: core.gitproxy and non-git protocols
Date: Sat, 04 Aug 2007 02:34:41 +0200
Organization: At home
Message-ID: <f90his$3tg$2@sea.gmane.org>
References: <ee77f5c20708012221j4d75ff0dl8fbf16cdaf1401bd@mail.gmail.com> <20070802053151.GH20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 02:35:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7br-0006Wt-OM
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763288AbXHDAfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763798AbXHDAfI
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:35:08 -0400
Received: from main.gmane.org ([80.91.229.2]:57179 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763091AbXHDAfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:35:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IH7bi-0008FT-QL
	for git@vger.kernel.org; Sat, 04 Aug 2007 02:35:02 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 02:35:02 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 02:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54780>

Shawn O. Pearce wrote:

> David Symonds <dsymonds@gmail.com> wrote:

>> It'd be great if (a) the documentation could be fixed, or (b) the
>> proxy-picking code could be at least extended to ssh:// protocols, and
>> preferrably extended to defining custom protocols.
> 
> Did you try setting GIT_SSH envvar to point to a script that does
> what you need?  I do this in one particular case...

GIT_SSH environmental variable is *not described* anywhere in the
documentation. Would you be so kind?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
