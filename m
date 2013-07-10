From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Wed, 10 Jul 2013 10:10:16 +0200
Message-ID: <vpq7ggyal93.fsf@anie.imag.fr>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Benoit Person <Benoit.Person@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 10 10:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwpTy-00007t-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 10:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331Ab3GJIKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 04:10:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54690 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab3GJIKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 04:10:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6A8AFX9014205
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Jul 2013 10:10:15 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@imag.fr>)
	id 1UwpTc-0004Rm-N8; Wed, 10 Jul 2013 10:10:16 +0200
In-Reply-To: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 09 Jul 2013 16:09:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jul 2013 10:10:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6A8AFX9014205
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1374048619.35092@wmeUWR1YP5WEWtZ0sPLrdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230031>

Junio C Hamano <gitster@pobox.com> writes:

> * bp/mediawiki-preview (2013-07-08) 7 commits
>  - git-remote-mediawiki: add preview subcommand into git mw
>  - git-remote-mediawiki: add git-mw command
>  - git-remote-mediawiki: factoring code between git-remote-mediawiki and Git::Mediawiki
>  - git-remote-mediawiki: update tests to run with the new bin-wrapper
>  - git-remote-mediawiki: add a git bin-wrapper for developement
>  - wrap-for-bin: make bin-wrappers chainable
>  - git-remote-mediawiki: introduction of Git::Mediawiki.pm
>
>  Looks like this is in a fairly good shape?

Yes it is. I think all remarks have been taken into account.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
