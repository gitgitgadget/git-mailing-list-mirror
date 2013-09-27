From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [ANNOUNCE] Git v1.8.4.1
Date: Fri, 27 Sep 2013 15:59:57 -0400
Message-ID: <5245E3BD.60703@xiplink.com>
References: <20130927185200.GL9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 27 22:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPeLl-0001CT-R0
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 22:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141Ab3I0UJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 16:09:14 -0400
Received: from smtp192.dfw.emailsrvr.com ([67.192.241.192]:58019 "EHLO
	smtp192.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3I0UJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 16:09:13 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2013 16:09:13 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp9.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id A911D3C0B71
	for <git@vger.kernel.org>; Fri, 27 Sep 2013 16:00:15 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp66.ord1c.emailsrvr.com (smtp66.ord1c.emailsrvr.com [108.166.43.66])
	by smtp9.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 8C9683C0B91
	for <git@vger.kernel.org>; Fri, 27 Sep 2013 16:00:15 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 2187414840C;
	Fri, 27 Sep 2013 15:59:04 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp1.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E6CD51481FB;
	Fri, 27 Sep 2013 15:59:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20130927185200.GL9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235474>

On 13-09-27 02:52 PM, Jonathan Nieder wrote:
> The latest maintenance release Git v1.8.4.1 is now available.
> 
> The release tarballs are found at:
> 
>     http://alioth.debian.org/~jrnieder-guest/git/
> 
> and their SHA-1 checksums are:
> 
> 49004a8dfcbb7c0848147737d9877fd7313a42ec  git-1.8.4.1.tar.gz
> 1f0e5c5934ec333b5630a8c93a0fb0b1895dfcb8  git-htmldocs-1.8.4.1.tar.gz
> dc0f9de1cacc8912f131b67dc5a19a96768ecc95  git-manpages-1.8.4.1.tar.gz
> 
> The following public repositories all have a copy of the v1.8.4.1
> tag and the maint branch that the tag points at:
> 
>   url = https://googlers.googlesource.com/jrn/git
>   url = git://repo.or.cz/git/jrn.git
>   url = git://gitorious.org/git/jrn.git
>   url = https://github.com/jrn/git

Are none of Junio's regular repos going to be updated while he's on vacation?

I don't think it's a big deal if they're not, though some mention of it in
this annoucement would've been appreciated -- I was about to email a
complaint that there's no v1.8.4.1 tag...

(My apologies if I missed mention of this elsewhere!)

		M.
