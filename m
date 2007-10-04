From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Question about "git commit -a"
Date: Thu, 04 Oct 2007 17:43:54 +0200
Message-ID: <vpqk5q2x4ud.fsf@bauges.imag.fr>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSsS-0003Ka-Ab
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbXJDPoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbXJDPoc
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:44:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:43266 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430AbXJDPob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:44:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l94FhugD012192
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Oct 2007 17:43:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IdSri-00071f-HZ; Thu, 04 Oct 2007 17:43:54 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IdSri-0006JD-Bm; Thu, 04 Oct 2007 17:43:54 +0200
In-Reply-To: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com> (Paolo Ciarrocchi's message of "Thu\, 4 Oct 2007 17\:38\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 04 Oct 2007 17:43:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59966>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> Hi all,
> I was just wondering why git commit doesn't default to "-a" (yes, it's
> another question that came up during a chat with a mercurial user) and
> I didn't find an answer to that.

http://git.or.cz/gitwiki/GitFaq#head-3aa45c7d75d40068e07231a5bf8a1a0db9a8b717

-- 
Matthieu
