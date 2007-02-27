From: Bill Lear <rael@zopyra.com>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 14:18:48 -0600
Message-ID: <17892.37416.358405.211524@lisa.zopyra.com>
References: <17892.28995.328911.23188@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17892.36336.249022.904854@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:18:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8mm-0006kK-Mu
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbXB0USx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbXB0USx
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:18:53 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61246 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbXB0USx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:18:53 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1RKIo508224;
	Tue, 27 Feb 2007 14:18:50 -0600
In-Reply-To: <Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40783>

On Tuesday, February 27, 2007 at 21:14:07 (+0100) Johannes Schindelin writes:
>> 
>> Welll... it's not really a matter of capacity, though I do agree that
>> lifting that limit will help.  We are more concerned with time to
>> clone the repos over the (often very slow) corporate network, for
>> example.  With future ratios of about 1% code to 99% test data, we
>> hither and yon with little care, and a monster data repo that is
>> (somehow) sanely managed with git as well.  I was just curious if
>> others had run into the management problems that I mentioned with
>> separating test data from code and what they may have done to surmount
>> them.
>
>Okay I misunderstood, then.
>
>Do shallow clones help you?

Hmm, can't answer now, since I don't know what these are.  I shall
investigate and see if they do.


Bill
