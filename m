From: Eric Raible <raible@nextest.com>
Subject: Re: sparse checkout using exclusions
Date: Mon, 31 Oct 2011 13:16:13 -0700
Message-ID: <4EAF020D.9090305@nextest.com>
References: <4EAB4632.5080101@nextest.com> <CALkWK0=X4O9jBbx_ZDXbtnDCmTb9fHbm13Z-pqTNBooA0Z=c0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyHL-0003zX-MI
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab1JaUQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:16:15 -0400
Received: from mail.nextest.com ([12.96.234.114]:45590 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752190Ab1JaUQO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 16:16:14 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Mon, 31 Oct 2011 13:16:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CALkWK0=X4O9jBbx_ZDXbtnDCmTb9fHbm13Z-pqTNBooA0Z=c0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184518>

On 10/28/2011 10:46 PM, Ramkumar Ramachandra wrote:
> 
> This issue was fixed in 5e821231 (git-read-tree.txt: update sparse
> checkout examples, 2011-09-26).
> 
> Cheers.
> 
> -- Ram

git tag -l --contains => v1.7.8-rc0

I'm running 1.7.7.1.msysgit.0, so I don't have it yet.
And neither do any of the online man pages I could find.

But I'm happy that it's fixed.  And the commit message is
better than what I would have come up with.

Thanks - Eric
