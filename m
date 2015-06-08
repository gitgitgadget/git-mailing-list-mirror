From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Mon, 08 Jun 2015 19:35:44 +0200
Message-ID: <vpqlhfurtlb.fsf@anie.imag.fr>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:35:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20xj-0007R0-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbbFHRfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:35:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40605 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbbFHRfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:35:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58HZgtq013341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 19:35:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HZixG009925;
	Mon, 8 Jun 2015 19:35:44 +0200
In-Reply-To: <1433621052-5588-3-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 19:35:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58HZgtq013341
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434389743.46022@1yNAa0Om0xy3ELBZPq8zRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271092>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add the '--points-at' option provided by 'ref-filter'. The
> option lets the user to pick only refs which point to a particular
> commit.
>
> Add Documentation for the same.

... but no test?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
