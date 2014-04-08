From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log for only certain branches
Date: Tue, 08 Apr 2014 19:08:28 +0200
Message-ID: <vpqioqjlpf7.fsf@anie.imag.fr>
References: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:08:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXZVl-0003Kx-0f
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 19:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbaDHRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 13:08:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47534 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179AbaDHRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 13:08:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s38H8Q9x001126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Apr 2014 19:08:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s38H8Sp3012334;
	Tue, 8 Apr 2014 19:08:28 +0200
In-Reply-To: <CAHd499BSgxZ8EC1qKYRsF0hac6rQAegw9qTOoDjaiuh_UUVEng@mail.gmail.com>
	(Robert Dailey's message of "Tue, 8 Apr 2014 08:43:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 08 Apr 2014 19:08:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s38H8Q9x001126
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397581708.4924@lZE6bMd/UISyhZIbFpsOpQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245934>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> I have more details about my inquiry on StackOverflow:
> http://stackoverflow.com/questions/22823768/view-git-log-with-merges-for-only-certain-branches
>
> Basically I'd like to know if it is possible to show the graph for
> ONLY branches that I list.

Not sure it'll directly answer your question, but did you read the
"History Simplification" part of "git log --help"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
