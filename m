From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git-help: add new options -w (for web) and -i (for info)
Date: Sat, 24 Nov 2007 09:52:04 +0100
Organization: At home
Message-ID: <fi8onk$4ga$1@ger.gmane.org>
References: <20071124051650.07fd275f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 09:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivqkk-0001yM-AD
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 09:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbXKXIwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 03:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbXKXIwY
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 03:52:24 -0500
Received: from main.gmane.org ([80.91.229.2]:34179 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbXKXIwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 03:52:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IvqkL-0001Rq-AJ
	for git@vger.kernel.org; Sat, 24 Nov 2007 08:52:17 +0000
Received: from abvy15.neoplus.adsl.tpnet.pl ([83.8.222.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Nov 2007 08:52:17 +0000
Received: from jnareb by abvy15.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 24 Nov 2007 08:52:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvy15.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65939>

[Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org]

Christian Couder wrote:

> This currently works only if the HTML versions of the man page
> have been installed in "PREFIX/share/doc/git-doc", so new target
> to do that is added to "Documentation/Makefile".

git-core RPM (th git one) installs HTML version of manpages to
/usr/share/doc/git-core-$version/

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
