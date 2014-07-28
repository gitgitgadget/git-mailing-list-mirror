From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/6] Rewrite `git_config()` using config-set API
Date: Mon, 28 Jul 2014 13:24:05 +0200
Message-ID: <vpqha21u3oq.fsf@anie.imag.fr>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBj2l-0003Vm-41
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbaG1LYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:24:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60908 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbaG1LYb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:24:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBO4AL012123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2014 13:24:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6SBO5Xs015640;
	Mon, 28 Jul 2014 13:24:05 +0200
In-Reply-To: <1406543635-19281-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 28 Jul 2014 03:33:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jul 2014 13:24:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6SBO4AL012123
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407151446.74748@mTBGpKUhU5EziJHJSVBeng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254310>

Tanay Abhra <tanayabh@gmail.com> writes:

> [PATCH V3]:All the suggestions in [3] applied. Built on top of [1].

Except for the minor style fix in PATCH 5, the series looks OK to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
