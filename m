From: David Fang <fang@csl.cornell.edu>
Subject: Re: sparse-checkout test failures [powerpc-darwin8]
Date: Wed, 4 Apr 2012 17:41:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.1204041736170.16407@hal-00.csl.cornell.edu>
References: <Pine.LNX.4.64.1204041616001.16407@hal-00.csl.cornell.edu>
 <7v1uo389l8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFY04-0007Ca-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab2DDVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 17:44:15 -0400
Received: from csl.cornell.edu ([128.84.224.10]:3485 "EHLO csl.cornell.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab2DDVoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 17:44:14 -0400
Received: from hal-00.csl.cornell.edu (hal-00.csl.cornell.edu [128.84.224.105])
	by csl.cornell.edu (8.13.4/8.13.4) with ESMTP id q34LfnTW070123;
	Wed, 4 Apr 2012 17:41:54 -0400 (EDT)
In-Reply-To: <7v1uo389l8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194748>

> David Fang <fang@csl.cornell.edu> writes:
>> 	With git 1.7.9.4, I'm seeing test failures with
>> t1011-read-tree-sparse-checkout.sh.
>
> Hrm.  Do you mean 1.7.9 worked and 1.7.9.4 doesn't, or you just happened
> to try 1.7.9.4 and do not know if this is a regression?
> I do not have any Darwin or PowerPC boxes, but the answer to the above may
> help others who do to help diagnosing the issue further.

Unfortunately, I didn't try any of the earlier 1.7.9.x releases, the 
previous one I tested was 1.7.8.4, which passed all tests (except for 
known breakages, and a few other disabled tests).

-- 
David Fang
http://www.csl.cornell.edu/~fang/
