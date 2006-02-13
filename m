From: Ian Molton <spyro@f2s.com>
Subject: Re: Handling large files with GIT
Date: Mon, 13 Feb 2006 23:17:57 +0000
Organization: The Dragon Roost
Message-ID: <43F113A5.2080506@f2s.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>  <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com> <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk> <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org> <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ben Clifford <benc@hawaga.org.uk>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 00:20:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8mzN-0001Qt-E6
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 00:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWBMXUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBMXUI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 18:20:08 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:45219 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S964875AbWBMXUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 18:20:07 -0500
Received: from [192.168.1.2] (i-83-67-116-184.freedom2surf.net [83.67.116.184])
	by outmail.freedom2surf.net (8.12.10/8.12.10) with ESMTP id k1DNEnVT020789;
	Mon, 13 Feb 2006 23:14:49 GMT
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16087>

Linus Torvalds wrote:

> Taking advantage of those kinds of things is what makes git good at 
> handling software projects. But it wouldn't necessarily be how you lay out 
> a mail directory, for example. An automated file store might want to 
> spread out the changes on purpose.

Indeed...

Im curious as to why anyone would want to use a SCM tool on a mail dir 
anyway - surely no-one edits their pasnt mails and needs to keep logs?

surely incremental backups would be a better way to manage something 
like this ?
