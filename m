From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb - caching
Date: Sun, 31 Dec 2006 21:52:11 +0100
Organization: At home
Message-ID: <en97tp$kc1$1@sea.gmane.org>
References: <45979136.3070901@eaglescrag.net> <20061231174123.GI6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Dec 31 21:52:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H17fU-00061q-Ho
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 21:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218AbWLaUw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 15:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933219AbWLaUw2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 15:52:28 -0500
Received: from main.gmane.org ([80.91.229.2]:58739 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933218AbWLaUw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 15:52:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H17fI-0003IS-Eo
	for git@vger.kernel.org; Sun, 31 Dec 2006 21:52:20 +0100
Received: from host-81-190-24-56.torun.mm.pl ([81.190.24.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Dec 2006 21:52:20 +0100
Received: from jnareb by host-81-190-24-56.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 31 Dec 2006 21:52:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-56.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35709>

Robert Fitzsimons wrote:

> * An infinite expiry date isn't valid for all pages.

An infinite expiry date is not valid at all. IIRC HTTP defines that
"infinite" expiry is one year.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
