From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 14:33:04 -0700
Message-ID: <7vwsvwo54f.fsf@gitster.siamese.dyndns.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perrin Meyer <perrinmeyer@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQUX-0007E2-LD
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741AbXHOVdT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755591AbXHOVdT
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:33:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbXHOVdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:33:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E0E67121F68;
	Wed, 15 Aug 2007 17:33:35 -0400 (EDT)
In-Reply-To: <600399.61066.qm@web52807.mail.re2.yahoo.com> (Perrin Meyer's
	message of "Wed, 15 Aug 2007 14:19:47 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55951>

Perrin Meyer <perrinmeyer@yahoo.com> writes:

> I was able to build and test git 1.5.2.4 fine, with no errors in the test suite. 
>
> I also just build 1.5.3-rc5 on a redhat box, with no errors in the testsuite. 
The above sounds as if you built 1.5.2.4 on your Mac in not so
recent past, and 1.5.3-rc5 on your Mac and RH recently.

Has anything changed on your Mac between the time you built
1.5.2.4 and failed to pass the test for 1.5.3-rc5?
