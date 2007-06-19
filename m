From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] make dist: include configure script in tarball
Date: Tue, 19 Jun 2007 02:39:59 +0200
Organization: At home
Message-ID: <f578a4$6mm$1@sea.gmane.org>
References: <20070618213036.GA7222@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 02:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Rfx-0005hB-0B
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 02:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760535AbXFSAeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 20:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758774AbXFSAeX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 20:34:23 -0400
Received: from main.gmane.org ([80.91.229.2]:54511 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670AbXFSAeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 20:34:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I0Rfo-0004DW-Du
	for git@vger.kernel.org; Tue, 19 Jun 2007 02:34:20 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 02:34:20 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 02:34:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50430>

Matthias Lederhofer wrote:

> +dist: git.spec git-archive configure

Ack. This way you don't need autoconf to ./configure install.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
