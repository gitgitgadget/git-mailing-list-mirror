From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1 25/25] contrib: remove 'mw-to-git'
Date: Fri, 09 May 2014 12:46:55 +0200
Message-ID: <vpqr443i600.fsf@anie.imag.fr>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-26-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?C=E9lestin?= Matte <celestin.matte@ensimag.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 12:47:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiiKr-0003xH-9w
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 12:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbaEIKrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 06:47:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45679 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbaEIKrB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 06:47:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s49Aks7e032159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 May 2014 12:46:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s49AktRd021643;
	Fri, 9 May 2014 12:46:55 +0200
In-Reply-To: <1399597116-1851-26-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 8 May 2014 19:58:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 09 May 2014 12:46:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s49Aks7e032159
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400237215.33879@GhpURWSglNll5PykDnhczw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248548>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No chance of ever graduating.

I see no relationship between the chance of graduating and the removal
from contrib/.

If you want to remove mw-to-git from contrib, then a good starting point
would be to explain why you want to do so in the commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
