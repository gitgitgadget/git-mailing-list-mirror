From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 09 Nov 2010 21:19:27 +0100
Message-ID: <vpqd3qe5jxs.fsf@bauges.imag.fr>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 21:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFugx-0001Uy-3e
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 21:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab0KIUVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 15:21:06 -0500
Received: from mx2.imag.fr ([129.88.30.17]:42866 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab0KIUVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 15:21:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA9KCblh012150
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 9 Nov 2010 21:12:38 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PFuf9-0003GQ-Ds; Tue, 09 Nov 2010 21:19:27 +0100
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 09 Nov 2010 11\:53\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Nov 2010 21:12:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA9KCblh012150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289938362.00744@iThc6USdqHv4USuhr4RjkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161070>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/phrase-remote-tracking (2010-11-02) 10 commits
>  - git-branch.txt: mention --set-upstream as a way to change upstream configuration
>  - user-manual: remote-tracking can be checked out, with detached HEAD
>  - user-manual.txt: explain better the remote(-tracking) branch terms
>  - Change incorrect "remote branch" to "remote tracking branch" in C code
>  - Change incorrect uses of "remote branch" meaning "remote-tracking"
>  - Change "tracking branch" to "remote-tracking branch"
>  - everyday.txt: change "tracking branch" to "remote-tracking branch"
>  - Change remote tracking to remote-tracking in non-trivial places
>  - Replace "remote tracking" with "remote-tracking"
>  - Better "Changed but not updated" message in git-status
>
> Is everybody happy with this round?  I'd prefer to merge it to 'next' or
> even 'master' and have further polishing be done, if necessary,
> in-tree.

The version in pu is the right one (I have to admin I did not make the
task easy ;-), thanks. I didn't get comment for a while, so I guess
it's OK for next, or master if you want.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
