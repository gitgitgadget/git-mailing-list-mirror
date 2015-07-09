From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Thu, 09 Jul 2015 14:48:21 +0200
Message-ID: <vpqa8v58pka.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<559E5333.7080901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDBFp-0007hQ-OR
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 14:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbbGIMsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 08:48:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52430 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591AbbGIMs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 08:48:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t69CmKtX023256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jul 2015 14:48:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t69CmLxY017421;
	Thu, 9 Jul 2015 14:48:21 +0200
In-Reply-To: <559E5333.7080901@gmail.com> (Karthik Nayak's message of "Thu, 9
	Jul 2015 16:25:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 09 Jul 2015 14:48:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t69CmKtX023256
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437050904.95149@daJjM3L2o9tnvoTr/RsDrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273745>

Karthik Nayak <karthik.188@gmail.com> writes:

>  Documentation/git-tag.txt |  16 ++-
>  builtin/tag.c             | 343
> ++++++----------------------------------------
>  t/t7004-tag.sh            |   8 +-

This patch was sent with Thunderbird unlike the others in the series. It
has some line wrapping which make it unapplicable.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
