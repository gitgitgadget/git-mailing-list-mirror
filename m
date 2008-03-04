From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Tue, 04 Mar 2008 10:23:47 +0100
Message-ID: <vpqzltec064.fsf@bauges.imag.fr>
References: <20080304051149.GS8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:26:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWTPE-0003OB-7E
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 10:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYCDJZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 04:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbYCDJZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 04:25:09 -0500
Received: from imag.imag.fr ([129.88.30.1]:56445 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbYCDJZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 04:25:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m249Ntqc029954
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 4 Mar 2008 10:23:55 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JWTND-0001EF-My; Tue, 04 Mar 2008 10:23:47 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JWTND-0002xz-JR; Tue, 04 Mar 2008 10:23:47 +0100
In-Reply-To: <20080304051149.GS8410@spearce.org> (Shawn O. Pearce's message of "Tue\, 4 Mar 2008 00\:11\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 04 Mar 2008 10:23:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76056>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> OK, enough, onto the project list!
>
>   http://git.or.cz/gitwiki/SoC2008Ideas

Jakub posted an idea about git.el (Emacs support) a few days ago:

> * GNU Emacs git GUI
>
>   Make git mode for Emacs full featured git GUI, and not only commit
>   tool, following ideas of PCL-CVS... and its limitation. I guess that
>   DVC (http://download.gna.org/dvc) git mode is one thing to examine
>   searching for features to implement, but from what I have read in
>   documentation it is quite a but GNU Arch centric. Other git GUIs, like
>   git-gui, gitk, qgit, tig could also be inspiration for features.
>
>   Goal: Allow creating and switching branches, examining history,
>   merging, fetching etc. from withing Emacs. Should include modes for
>   git config file forma and format-patch patches.
>
>   Language: Emacs Lisp
>   Suggested mentors:
>     Alexandre Julliard
>     David Kagedal

Since I've been quite involved in DVC in the past, I'm willing to help
with this, but unfortunately, I'm swamped with work and I can't commit
for ~5-10h/week on that.

So, if someone else steps in, perhaps we could rephrase the subject in
a "merge git.el and DVC, and improve it" way, and I could co-mentor
this one.

All that said, I think most of the ideas already on the wiki should be
prioritized (I love Emacs, but I think more people need a good Windows
support/GUI for example).

-- 
Matthieu
