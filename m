From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: Kernel.org Downtime Notice - Please read *very* important
Date: Tue, 01 Apr 2008 10:11:29 +0800 (CST)
Message-ID: <20080401.101129.90822580.xiyou.wangcong@gmail.com>
References: <47F1895D.7090509@kernel.org>
	<47F19460.7010206@davidnewall.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: warthog9@kernel.org, users@kernel.org,
	linux-kernel@vger.kernel.org, ftpadmin@kernel.org,
	mirror-list-d@redhat.com, suse-mirror@suse.de,
	centos-mirror@centos.org, mirror-list@redhat.com, hands@isc.org,
	support@osuosl.org, git@vger.kernel.org
To: davidn@davidnewall.com
X-From: git-owner@vger.kernel.org Tue Apr 01 04:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgW1a-0007DF-53
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 04:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYDACOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 22:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYDACOO
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 22:14:14 -0400
Received: from qb-out-0506.google.com ([72.14.204.239]:20355 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYDACON (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 22:14:13 -0400
Received: by qb-out-0506.google.com with SMTP id e11so363369qbe.15
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:message-id:to:cc:subject:from:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=yrh6vNhVsTP/i/dSdaCPeUXybpdIycM1RY/rc5aSpH0=;
        b=ALUKKcRjNY6QqVq5LzyJBHnUOIXA8fgaVu3aiqGYZRQ9uXShDkkAOxSZ5nTerXuDKilRfoDWuiq2ek3dSHfkrYpCpe8cG7iQfVhh/npkIJh+b9H1u9uK4NkYfeE0x6d0xzQP6WiZHedMTZaOoWE1lBiUWpepu5Qw4WqyRsFVmL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:message-id:to:cc:subject:from:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WNbCiuLgC7k78L3ar38E34xd74MuBudjfyGuak+Gv3qGPUAmPDIyPlMbe0FEhPlC4ocO/c2LuD0XIk0AxZmIDfdyLyCT3I4HtEEoPjXOO1+aFdr2nqyx50Q5AXwYg1dcGIKL72JEq8dR/HlYb+lIPxtp/N1bFV0s5o8pXDdX1+E=
Received: by 10.140.88.11 with SMTP id l11mr3919375rvb.156.1207016049617;
        Mon, 31 Mar 2008 19:14:09 -0700 (PDT)
Received: from localhost ( [123.128.37.121])
        by mx.google.com with ESMTPS id g1sm12458811rvb.0.2008.03.31.19.14.05
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Mar 2008 19:14:09 -0700 (PDT)
In-Reply-To: <47F19460.7010206@davidnewall.com>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78617>

From: David Newall <davidn@davidnewall.com>
Date: Tue, 01 Apr 2008 12:18:16 +1030

> J.H. wrote:
> > we are upgrading the kernel.org machines from Fedora Core 5 to FreeBSD
> > 7.0.
> 
> Highly commendable.  You should take this opportunity to also upgrade
> network facilities to meet the requirements as laid out in RFC1149 (CPIP).

What about RFC1606? Maybe kernel should include a net/ipv9 branch.
;-)
