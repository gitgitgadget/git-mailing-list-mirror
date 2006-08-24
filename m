From: Jakub Narebski <jnareb@gmail.com>
Subject: Running gitweb under mod_perl
Date: Thu, 24 Aug 2006 14:43:06 +0200
Organization: At home
Message-ID: <eck6sq$agn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 24 14:43:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGEYa-00040S-De
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 14:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWHXMnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 08:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWHXMnd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 08:43:33 -0400
Received: from main.gmane.org ([80.91.229.2]:2988 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751208AbWHXMnc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 08:43:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGEYL-0003x6-D4
	for git@vger.kernel.org; Thu, 24 Aug 2006 14:43:21 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 14:43:21 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 14:43:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25957>

Could you tell me what should I do to run gitweb under mod_perl,
and not as CGI script? What should I put in Apache configuration
(Apache 2.0.54 if this matters, mod_perl 2.0.1)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
