From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Document ls-files -t as semi-obsolete.
Date: Tue, 27 Jul 2010 23:02:25 +0200
Message-ID: <vpqaapcy6xq.fsf@bauges.imag.fr>
References: <1280162391-18701-1-git-send-email-Matthieu.Moy@imag.fr>
	<201007272107.50204.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrIO-0002xQ-9a
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab0G0VCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:02:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54004 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040Ab0G0VCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:02:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6RKqHk8000624
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Jul 2010 22:52:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OdrI9-0001sP-UG; Tue, 27 Jul 2010 23:02:26 +0200
In-Reply-To: <201007272107.50204.barra_cuda@katamail.com> (Michele Ballabio's message of "Tue\, 27 Jul 2010 21\:07\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Jul 2010 22:52:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6RKqHk8000624
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280868740.73645@PLVUOejTfOSaizNz+KHeGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151986>

Michele Ballabio <barra_cuda@katamail.com> writes:

> I think this breaks formatting. Shouldn't it be more like the following?
> (I.e. with a single '+' before "Identify...").

Your version wraps the list and makes it unreadable. A newline between
the paragraph and the list seems to fix this.

> And maybe rephrase the line
> "Identify the file status with the following tags (followed by
> a space) at the start of each line"
> into
> "This option identifies..."
> just to set apart "semi-deprecation" and "explanation" of the
> option.

I buy this.

New version comming soon.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
