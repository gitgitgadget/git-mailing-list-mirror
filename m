From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Advice on edits to git-rebase man page
Date: Thu, 05 Feb 2015 22:20:55 +0100
Message-ID: <vpq1tm412dk.fsf@anie.imag.fr>
References: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
	<vpqa90s4oz2.fsf@anie.imag.fr>
	<xmqqa90smbhu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthew Brett <matthew.brett@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Reuben Thomas <rrt@sc3d.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:21:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJTrR-0004CJ-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 22:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbbBEVVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 16:21:13 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58686 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbbBEVVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 16:21:12 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t15LKrwJ006169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Feb 2015 22:20:53 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t15LKtAw018781;
	Thu, 5 Feb 2015 22:20:55 +0100
In-Reply-To: <xmqqa90smbhu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 Feb 2015 10:58:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Feb 2015 22:20:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t15LKrwJ006169
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1423776055.7383@A64g5PH+klefrI5RO/HlWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263407>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps something like this instead?
>
>     git-rebase - Rebuild a branch on top of a different commit

I would say "Replay history on top of a different commit" instead.
"Rebuild" may be misleading (it's not "build" as in "compile & link"),
and the rebased history does not technically have to be a branch.

But both are far better than what we have IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
