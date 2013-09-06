From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 6/6] status: add missing blank line after list of "other" files
Date: Fri, 06 Sep 2013 20:45:29 +0200
Message-ID: <vpqmwnprdpy.fsf@anie.imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
	<1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
	<1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbo45yfm5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI12N-0007u1-2E
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3IFSpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:45:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55502 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab3IFSpi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:45:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86IjRne027260
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 20:45:27 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VI12A-0000xf-0u; Fri, 06 Sep 2013 20:45:30 +0200
In-Reply-To: <xmqqbo45yfm5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Sep 2013 11:22:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 20:45:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86IjRne027260
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379097929.44587@67JIApnP7NwGYIkUR/c94g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234084>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> List of files in other sections ("Changes to be committed", ...) end with
>> a blank line.
>
> It is not like we want to add a blank line at the end of each
> element; it is rather that we want to have a blank line between each
> element, so that they can have a bit of breathing room between them.

Well, "between each element, and at the end of the output" sounds a lot
like "after each element" ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
