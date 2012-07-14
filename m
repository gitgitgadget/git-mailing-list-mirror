From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe@gmail.com>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sat, 14 Jul 2012 09:48:31 +0000 (UTC)
Message-ID: <loom.20120714T114718-783@post.gmane.org>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 11:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpyzS-0000cu-OX
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 11:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab2GNJuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 05:50:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:60925 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2GNJuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 05:50:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SpyzI-0000Lg-1t
	for git@vger.kernel.org; Sat, 14 Jul 2012 11:50:08 +0200
Received: from dslc-082-083-235-018.pools.arcor-ip.net ([82.83.235.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 11:50:08 +0200
Received: from stefan.naewe by dslc-082-083-235-018.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 11:50:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.235.18 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201437>

Zeeshan Ali (Khattak <zeeshanak <at> gnome.org> writes:

> 
> Hi,
>   Many times I want to refer to 'HEAD^', 'HEAD^^' and sometimes even
> further up the tree. It would be really nice if I didn't have to type
> 'HEAD^' but could only type '^'. Bash completion make things easier
> but it automatically inserts a space immediately after HEAD so you
> have to hit backspace. I think this change would be good in general
> anyway.

Or even '~1', '~3'.

Where's the '+1' button...?

Stefan
