From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: How to fork
Date: Tue, 12 Aug 2008 11:09:54 +0200
Message-ID: <vpqhc9q4n19.fsf@bauges.imag.fr>
References: <200808121030.21384.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue Aug 12 11:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSq07-0004Gl-8F
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 11:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYHLJQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYHLJQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 05:16:09 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:45791 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbYHLJQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 05:16:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7C9D6Ok019762;
	Tue, 12 Aug 2008 11:13:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KSpt4-0005gv-SR; Tue, 12 Aug 2008 11:09:54 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KSpt4-00060b-P1; Tue, 12 Aug 2008 11:09:54 +0200
In-Reply-To: <200808121030.21384.thomas@koch.ro> (Thomas Koch's message of "Tue\, 12 Aug 2008 10\:30\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 12 Aug 2008 11:13:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92085>

Thomas Koch <thomas@koch.ro> writes:

> I just wonder, that neither the official Git manual, nor the kernel
> hackers guide to git describe the best practice to fork a project.

Well, in Git, technically, any clone is a fork. The difference between
a contributor's repository and a forker's is social, not technical (I
usually define "fork" as a branch where one of the projects has no
intention of merging the other's changes).

So, just clone and publish (push) your changes, and you're done.

Or, ask a more precise question, I may have missed something ;-).

-- 
Matthieu
