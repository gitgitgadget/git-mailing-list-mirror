From: Kai Schlamp <schlamp@gmx.de>
Subject: Re: Change git gui language (+ some other suggestions)
Date: Fri, 17 Apr 2009 17:11:08 +0200
Message-ID: <gsa66j$25c$1@ger.gmane.org>
References: <49E89304.9060303@gmx.de> <237967ef0904170747l61adf4feq1a5df5f1b26debe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 17:13:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LupkZ-0005i9-CW
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757869AbZDQPLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbZDQPLb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:11:31 -0400
Received: from main.gmane.org ([80.91.229.2]:49483 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586AbZDQPLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:11:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lupiz-00011w-7U
	for git@vger.kernel.org; Fri, 17 Apr 2009 15:11:29 +0000
Received: from p54a8f090.dip.t-dialin.net ([84.168.240.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 15:11:29 +0000
Received: from schlamp by p54a8f090.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 15:11:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54a8f090.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <237967ef0904170747l61adf4feq1a5df5f1b26debe2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116744>

> I don't know much about language selection on windows (which you
> didn't say you're using, but I'm inferring it from the referenced
> thread), but you could try setting LC_MESSAGES=en and LANG=de_DE or
> whatever germany is, that should at least work in linux :). Maybe tk
> is nice enough to follow the same rules?
> 

Thanks Mikael. But it seems that it was more a problem with the Cygwin 
console. LANG=en works now too without changing the keyboard layout.
But your recommendation works also :-)

Cheers,
Kai
