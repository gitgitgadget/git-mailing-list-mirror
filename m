From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t5704: problem with OS X sed
Date: Tue, 6 Mar 2012 16:18:07 -0500
Message-ID: <9980BCE6-7933-40A5-BA96-5B93B553E666@silverinsanity.com>
References: <E40E6E02-8960-4A10-9E71-28F9CDB120F8@silverinsanity.com> <m362ehtpgp.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	BJ Hargrave <bj@bjhargrave.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 22:18:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51lx-0001UR-IG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031102Ab2CFVSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:18:13 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:33355 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592Ab2CFVSM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 16:18:12 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A6D501FFC008; Tue,  6 Mar 2012 21:18:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.89] (unknown [64.134.102.20])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C3FEE1FFC006;
	Tue,  6 Mar 2012 21:18:02 +0000 (UTC)
In-Reply-To: <m362ehtpgp.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192395>


On Mar 6, 2012, at 4:01 PM, Jakub Narebski wrote:

> Thomas Rast proposed a patch to fix this issue, as reported by
> BJ Hargrave, in
> 
>  Re: [ANNOUNCE] Git 1.7.9.3
>  Message-ID: <87y5rd4wci.fsf@thomas.inf.ethz.ch>
>  http://thread.gmane.org/gmane.linux.kernel/1262318/focus=192355
> 
> as
> 
>  [PATCH] t5704: fix nonportable sed/grep usages

Ah, reported and fixed in an announce e-mail while I was working on it myself.

Unsurprisingly, the patch also works for me.

Thanks Thomas and Jakub,
~~ Brian G
