From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Use rev-list pattern search options.
Date: Sat, 23 Dec 2006 09:21:10 +0100
Organization: At home
Message-ID: <emiooi$f4m$2@sea.gmane.org>
References: <11668449162618-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Dec 23 09:20:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy276-0006ll-A3
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 09:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLWIUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 03:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbWLWIUM
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 03:20:12 -0500
Received: from main.gmane.org ([80.91.229.2]:33811 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbWLWIUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 03:20:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gy26s-0002XI-GO
	for git@vger.kernel.org; Sat, 23 Dec 2006 09:20:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 09:20:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 09:20:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35300>

Robert Fitzsimons wrote:

> Use rev-list pattern search options instead of hand coded perl.

Very nice. Ack (FWIW).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
