From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 0/8] Rewrite `git_config()` using config-set API
Date: Mon, 04 Aug 2014 15:43:01 +0200
Message-ID: <vpqtx5sqska.fsf@anie.imag.fr>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEIY3-0000ge-Du
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 15:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbaHDNna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 09:43:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58656 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbaHDNn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 09:43:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s74Dh0dN025715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 15:43:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74Dh12L002334;
	Mon, 4 Aug 2014 15:43:01 +0200
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 1 Aug 2014 10:05:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Aug 2014 15:43:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74Dh0dN025715
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407764584.21454@3PSrUjujtQRfU5R5vlkRmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254738>

Tanay Abhra <tanayabh@gmail.com> writes:

> [Patch v7]: style nit corrected. (1/8) is Matthieu's translation patch.
> 	git_die_config_linenr() helper function added. Diff between v6
> 	and v7 appended for review.

This series is now

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
