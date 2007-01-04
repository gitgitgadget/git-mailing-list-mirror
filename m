From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [0/2 PATCH] FastCGI and nginx support for gitweb
Date: Thu, 04 Jan 2007 09:56:09 +0100
Organization: At home
Message-ID: <enif9a$9ve$1@sea.gmane.org>
References: <11678969111362-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jan 04 09:53:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2OLj-0000kr-U8
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 09:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbXADIxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXADIxS
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 03:53:18 -0500
Received: from main.gmane.org ([80.91.229.2]:33779 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbXADIxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 03:53:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H2OLR-0006k0-BR
	for git@vger.kernel.org; Thu, 04 Jan 2007 09:53:05 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 09:53:05 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 09:53:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35924>

Eric Wong wrote:

> I was looking at nginx for another project and got sidetracked
> into writing instaweb support for it; so I ended up writing a
> simple FCGI wrapper for gitweb as well.

FCGI, not CGI::Fast?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
