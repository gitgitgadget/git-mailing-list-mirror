From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 17:59:25 +0100
Message-ID: <vpqbop6tyj6.fsf@bauges.imag.fr>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
	<20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 18:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvtqr-00060V-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab2BJRBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 12:01:33 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44447 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab2BJRBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 12:01:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1AGuJdh023663
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 10 Feb 2012 17:56:19 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rvtoj-000301-IM; Fri, 10 Feb 2012 17:59:25 +0100
In-Reply-To: <7vmx8rtu3e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 09 Feb 2012 16:23:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 10 Feb 2012 17:56:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1AGuJdh023663
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329497781.7283@9gzSUwb8Z+Z627o2h+aYlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190421>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
>
>> Please restore access to the following files when possible. Some sites
>> are referencing those, including kernel.org itself:
>>
>>  http://www.kernel.org/pub/software/scm/git/docs/git.html
>
> The pages reachable from this used to be living documents in that every
> time the 'master' branch was updated at k.org, automatically a server side
> hook script generated a new set of HTML pages and updated them.

Is it possible to have the static HTML uploaded from another machine,
not necessarily for each push, but e.g. for every release?

I don't think anyone cares about having the very latest documentation
there, but it would still be great to have an official place to point to
when writing documentation on the web about such or such command.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
