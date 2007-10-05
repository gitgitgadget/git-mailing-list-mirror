From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 13:35:32 +0200
Message-ID: <vpqsl4piykb.fsf@bauges.imag.fr>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	<545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	<fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	<Pine.LNX.4.64.0710042209410.4174@racer.site>
	<4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	<4705FB52.3030208@op5.se>
	<4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>
	<47060BB3.3030208@op5.se> <vpqy7ehj2g8.fsf@bauges.imag.fr>
	<47060E98.2090601@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 13:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdlTf-0002tA-U3
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 13:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbXJELgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 07:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXJELgE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 07:36:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:64171 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbXJELgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 07:36:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l95BZWmm005458
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 13:35:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IdlSu-0001oQ-Eg; Fri, 05 Oct 2007 13:35:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IdlSu-0002Of-CJ; Fri, 05 Oct 2007 13:35:32 +0200
In-Reply-To: <47060E98.2090601@op5.se> (Andreas Ericsson's message of "Fri\, 05 Oct 2007 12\:14\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 05 Oct 2007 13:35:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60070>

Andreas Ericsson <ae@op5.se> writes:

>>> or check which merge- conflicts you've already resolved,
>>
>> At least bzr and baz have this kind of conflict management. It's just
>> a separate file, containing the list of unresolved conflicts.
>
> Can you check them against any revision you want? If so, I'm
> impressed :)

If you mean s/check/diff/, not in a simple way, no. Otherwise, I don't
understand what you mean by "check merge-conflicts you've already
resolved against any revision".

-- 
Matthieu
