From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] stgit: fix clone
Date: Fri, 13 Jan 2006 00:24:33 -0500
Message-ID: <1137129873.20073.72.camel@dv>
References: <1137017966.10975.8.camel@dv> <43C58916.6030409@citi.umich.edu>
	 <43C58AF3.10606@citi.umich.edu>
	 <b0943d9e0601120354u73489c74j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: cel@citi.umich.edu, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 13 06:24:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExHQj-0000V6-2l
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 06:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWAMFYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 00:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWAMFYp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 00:24:45 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:62353 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751192AbWAMFYp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 00:24:45 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ExHOD-0001ub-5x
	for git@vger.kernel.org; Fri, 13 Jan 2006 00:22:17 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1ExHQP-0007gd-RG; Fri, 13 Jan 2006 00:24:33 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0601120354u73489c74j@mail.gmail.com>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14615>

On Thu, 2006-01-12 at 11:54 +0000, Catalin Marinas wrote:

> See the attached patch for a different fix and let me know if there
> are any issues with it. I should probably release 0.8.1 with the fixed
> bugs.

I see you have applied the fix already.  Current StGIT is working fine
when it comes to cloning.  Thank you!

-- 
Regards,
Pavel Roskin
