From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: simplify file filtering
Date: Mon, 13 May 2013 10:58:49 +0200
Message-ID: <1l2t1t0.12u9785epsqikM%lists@haller-berlin.de>
References: <20130513003602.GA8046@iris.ozlabs.ibm.com>
Cc: git@vger.kernel.org
To: paulus@samba.org (Paul Mackerras),
	gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Mon May 13 10:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uboav-0004Jg-84
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab3EMI6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:58:52 -0400
Received: from server90.greatnet.de ([83.133.96.186]:52097 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3EMI6u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 04:58:50 -0400
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id A61223B0025;
	Mon, 13 May 2013 10:58:48 +0200 (CEST)
In-Reply-To: <20130513003602.GA8046@iris.ozlabs.ibm.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.8.3 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224115>

Paul Mackerras <paulus@samba.org> wrote:

> On Sun, May 12, 2013 at 03:54:14PM -0700, Junio C Hamano wrote:
>
> > Thanks; is this the last one for this cycle and is your usual branch
> > ready to be pulled?
> 
> I'm still deciding whether to put in Martin Langhoff's patch with a
> modified label ("changing lines matching" rather than "with changes
> matching regex").  I'm leaning towards it but was waiting a little to
> see if anyone had comments on the wording.  I'll decide by the end of
> today and send you a pull request either way.

Would you also consider Tair Sabirgaliev's v2 patch for not launching
gitk in the background on Mac? This fixes a very serious usability
problem.

  <http://permalink.gmane.org/gmane.comp.version-control.git/222243>

Thanks,
   Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
