From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: ANNOUNCE: git-imerge -- Incremental merge and rebase for git
Date: Mon, 15 Jul 2013 10:56:07 +0200
Message-ID: <vpq61wcgq1k.fsf@anie.imag.fr>
References: <51E23827.6010601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 15 10:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyeZt-0000wv-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 10:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab3GOI4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 04:56:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:32853 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754539Ab3GOI4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 04:56:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6F8u7bA009576
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 10:56:07 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UyeZk-00062G-6X; Mon, 15 Jul 2013 10:56:08 +0200
In-Reply-To: <51E23827.6010601@alum.mit.edu> (Michael Haggerty's message of
	"Sun, 14 Jul 2013 07:33:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 10:56:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6F8u7bA009576
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374483368.43522@LKzZgKugFIpIvLNKx50JEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230440>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I've alluded to this little project of mine on the mailing list before,
> but I've never really announced it properly.  So here we go...
>
> git-imerge [1] is an open-source tool that helps you perform difficult
> Git merges and rebases by allowing conflicts to be resolved
> incrementally.

Seems cool! :-)

Added to:

  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#imerge

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
