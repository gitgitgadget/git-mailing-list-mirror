From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 0/12] Create ref-filter from for-each-ref
Date: Thu, 11 Jun 2015 19:03:14 +0200
Message-ID: <vpqtwuew52l.fsf@anie.imag.fr>
References: <5579B253.4020804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:03:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z35sx-0004Qb-Hf
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbbFKRDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:03:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50408 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbbFKRDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:03:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5BH3CpH027629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Jun 2015 19:03:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5BH3EXT016364;
	Thu, 11 Jun 2015 19:03:14 +0200
In-Reply-To: <5579B253.4020804@gmail.com> (Karthik Nayak's message of "Thu, 11
	Jun 2015 21:37:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 11 Jun 2015 19:03:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5BH3CpH027629
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434646994.03662@EWUXBwqI3AT45rGO3fpEvQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271439>

Karthik Nayak <karthik.188@gmail.com> writes:

> The previous version of this patch can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/270922
>
> Changes found in this version:
> *    Various changes to the 'filter_refs()' function.
> *    Split 'for-each-ref: clean up code' into two commits.
> *    Other small changes.

My previous comments are all taken into account. The whole series looks
good to me now.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
