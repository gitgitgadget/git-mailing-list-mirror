From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: Re: Verifying recent tags in git.git
Date: Sat, 12 Nov 2011 19:55:43 +0000 (UTC)
Message-ID: <loom.20111112T204519-725@post.gmane.org>
References: <4EBEA053.6040109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 20:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPJgH-00023d-MH
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 20:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1KLTz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 14:55:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:42578 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab1KLTz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 14:55:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RPJgB-00020Y-Jo
	for git@vger.kernel.org; Sat, 12 Nov 2011 20:55:55 +0100
Received: from dslc-082-083-251-204.pools.arcor-ip.net ([82.83.251.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 20:55:55 +0100
Received: from stefan.naewe by dslc-082-083-251-204.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 20:55:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.83.251.204 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.874.120 Safari/535.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185315>

Ramsay Jones <ramsay <at> ramsay1.demon.co.uk> writes:

> 
> Hi Junio,
> 
> I noticed that the v1.7.8-rc1 tag took about 24 hours to appear in the
> kernel.org (and repo.or.cz) repository after you announced it and actually
> pushed the branch out.
> 
> [...]
> Note the key ID 96AFE6CB.
> 
> Are you planning to create an junio-gpg-pub-v2 tag? (or are you making it
> available from a keyserver?)

What about this:

  http://pgp.mit.edu:11371/pks/lookup?search=0x96AFE6CB&op=index&fingerprint=on

Stefan
