From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Sep 2011, #03; Sun, 11)
Date: Mon, 12 Sep 2011 09:32:38 +0200
Message-ID: <vpqehzm6wrt.fsf@bauges.imag.fr>
References: <7vwrde9t6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 09:32:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R310i-0003Gy-UU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 09:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab1ILHcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 03:32:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48195 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab1ILHcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 03:32:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8C7VJY0027890
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Sep 2011 09:31:19 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R310Q-0001VT-Iz; Mon, 12 Sep 2011 09:32:38 +0200
In-Reply-To: <7vwrde9t6h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 11 Sep 2011 23:21:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 12 Sep 2011 09:31:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8C7VJY0027890
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316417485.67787@pz6mWMULyWUIH556Dhgk/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181211>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/remote-helpers-doc (2011-09-01) 3 commits
>  - (short) documentation for the testgit remote helper
>  - Documentation/git-remote-helpers: explain how import works with multiple refs
>  - Documentation/remote-helpers: explain capabilities first
>
> Not urgent.

I agree it's not urgent, but this serie doesn't touch the code itself,
so it should be pretty harmless. It fixes some relatively important
documentation issues, and a nice side effect of putting them in a
release soon would be to update the doc available at
http://www.kernel.org/pub/software/scm/git/docs/git-remote-helpers.html
(when kernel.org is not down).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
