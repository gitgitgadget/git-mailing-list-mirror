From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Collecting cvsps patches
Date: Fri, 16 Jun 2006 23:31:46 +0200
Organization: At home
Message-ID: <e6v7vr$ila$1@sea.gmane.org>
References: <20060611122746.GB7766@nowhere.earth> <46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com> <20060611224205.GF1297@nowhere.earth> <e6jj39$6ua$1@sea.gmane.org> <20060616212334.GN7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 16 23:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrLvQ-0000a1-GW
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 23:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWFPVcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 17:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWFPVcP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 17:32:15 -0400
Received: from main.gmane.org ([80.91.229.2]:47009 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751462AbWFPVcO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 17:32:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrLv3-0000U1-1q
	for git@vger.kernel.org; Fri, 16 Jun 2006 23:31:57 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 23:31:57 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 23:31:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21973>

Yann Dirson wrote:

> On Mon, Jun 12, 2006 at 11:27:37AM +0000, Anand Kumria wrote:
>> On Mon, 12 Jun 2006 00:42:05 +0200, Yann Dirson wrote:
>> 
>> > http://ydirson.free.fr/soft/git/cvsps.git
>> 
>> I think you need to chmod +x hooks/post-update
>> 
>> and then run 'git-update-server-info'.
> 
> Unfortunately, I only have FTP access to push to this site, so I have
> to run git-update-server-info myself, and occasionally forget.  I'll
> have to bring up-to-date my old cg-ftppush script some day :)

Or extend git to allow push/pull also via ftp?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
