From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 5/5] git-remote-mediawiki: Add preview subcommand into git mw.
Date: Wed, 26 Jun 2013 22:18:55 +0200
Message-ID: <vpq8v1w39sg.fsf@anie.imag.fr>
References: <1372273970-9084-1-git-send-email-benoit.person@ensimag.fr>
	<1372273970-9084-6-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Wed Jun 26 22:19:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrwBK-0004Uo-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 22:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab3FZUTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 16:19:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49093 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360Ab3FZUTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 16:19:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5QKIrOi009987
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 26 Jun 2013 22:18:53 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UrwB5-0002hH-Rh; Wed, 26 Jun 2013 22:18:55 +0200
In-Reply-To: <1372273970-9084-6-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Wed, 26 Jun 2013 21:12:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Jun 2013 22:18:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229059>

benoit.person@ensimag.fr writes:

> +do you want ? Use the -r option to specify the remote.

Not that it really matters, but there should be no space before ? in
English (although there is in French).

(Shouldn't prevent merging)

Other than that, the series looks good to me. Good work splitting
patches 1 to 4, the history looks much nicer now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
