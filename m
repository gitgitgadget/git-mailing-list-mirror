From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] ls-files: Add eol diagnostics
Date: Sun, 01 Nov 2015 19:41:26 +0100
Message-ID: <vpqio5lzhnt.fsf@anie.imag.fr>
References: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
	<vpqbnbfpc6p.fsf@anie.imag.fr>
	<xmqqtwp5h95i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxZP-0006v9-JC
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbKASlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:41:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37384 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbbKASlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:41:31 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tA1IfN0J000519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 1 Nov 2015 19:41:24 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tA1IfQ83011102;
	Sun, 1 Nov 2015 19:41:26 +0100
In-Reply-To: <xmqqtwp5h95i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 01 Nov 2015 10:22:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 01 Nov 2015 19:41:24 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tA1IfN0J000519
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447008084.34431@t6nSomE3q+/AAzSuI3pGjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280652>

Junio C Hamano <gitster@pobox.com> writes:

> i/ and w/ have been used to denote the "i"ndex and "w"orktree
> versions for the past 7 years with diff.mnemonicprefix option,
> which you may want to match.

Indeed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
