From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 19:15:33 +0100
Organization: At home
Message-ID: <epo1tn$9sl$1@sea.gmane.org>
References: <17855.35058.967318.546726@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 19:14:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBxVG-0004TU-NQ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 19:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbXA3SOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 13:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbXA3SOn
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 13:14:43 -0500
Received: from main.gmane.org ([80.91.229.2]:57578 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030187AbXA3SOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 13:14:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBxV5-0003EQ-I3
	for git@vger.kernel.org; Tue, 30 Jan 2007 19:14:35 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 19:14:35 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 19:14:35 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38180>

Bill Lear wrote:

> I don't understand why clone (version 1.4.4.1) is not checking out my
> files:

Unless you use git clone --bare, it should checkout HEAD branch...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
