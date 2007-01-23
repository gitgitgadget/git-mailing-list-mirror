From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] sha1_file.c: Avoid multiple calls to find_pack_entry().
Date: Tue, 23 Jan 2007 01:39:50 +0100
Organization: At home
Message-ID: <ep3lf6$a9t$1@sea.gmane.org>
References: <20070122202945.GA29297@bohr.gbar.dtu.dk> <45B524E1.5060205@fs.ei.tum.de> <Pine.LNX.4.64.0701221611210.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 23 01:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H99hM-00059g-2V
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 01:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbXAWAjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 19:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbXAWAjY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 19:39:24 -0500
Received: from main.gmane.org ([80.91.229.2]:56063 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932584AbXAWAjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 19:39:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H99gu-0002oj-DY
	for git@vger.kernel.org; Tue, 23 Jan 2007 01:39:12 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 01:39:12 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 01:39:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37472>

Linus Torvalds wrote:

> I assume there are three '$$$' characters missing in your banner 
> advertizing space. Maybe an Euro character? The joys of tab-damage just 
> expands in the modern world of new character sets..

I see three euro characters there. I don't know why unknown character
didn't got replaced by ? or something like that....
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
