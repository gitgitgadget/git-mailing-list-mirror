From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Re: GIT on Windows
Date: Wed, 9 May 2007 12:42:29 +0000 (UTC)
Message-ID: <loom.20070509T143929-778@post.gmane.org>
References: <loom.20070509T142518-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 14:45:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HllXP-0003HV-HG
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbXEIMoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757884AbXEIMoE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:44:04 -0400
Received: from main.gmane.org ([80.91.229.2]:33225 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757772AbXEIMoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:44:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HllW4-00007k-Ml
	for git@vger.kernel.org; Wed, 09 May 2007 14:43:38 +0200
Received: from edm-005.edm.uhasselt.be ([193.190.10.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:43:36 +0200
Received: from takis.issaris by edm-005.edm.uhasselt.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:43:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.190.10.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; nl; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46706>

Panagiotis Issaris <takis.issaris <at> uhasselt.be> writes:
[...]
> pissaris <at> pissaris ~/src/ffmpeg-pi
> $ git --version
> git version 1.5.1.3
> 
> I'll see if 1.5.1.4 solves this crash, and will most likely 
> have a go at getting the MinGW version compiled too.

Please ignore this bugreport as GIT 1.5.1.4 indeed seems to solve 
this crash! :-) (That or the CygWin binary GIT 1.5.1.3 package 
might be broken).


With friendly regards,
Takis
 
 
