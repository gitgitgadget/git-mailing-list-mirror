From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: --color-diff='.' considered useful
Date: Mon, 16 Nov 2015 15:34:54 +0100
Message-ID: <vpq1tbq812p.fsf@anie.imag.fr>
References: <5649E773.7040705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 15:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyKsG-0003tR-Nc
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 15:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbbKPOfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 09:35:06 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49174 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbbKPOfB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 09:35:01 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tAGEYriQ005558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 16 Nov 2015 15:34:53 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAGEYswl018268;
	Mon, 16 Nov 2015 15:34:54 +0100
In-Reply-To: <5649E773.7040705@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 16 Nov 2015 15:25:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Nov 2015 15:34:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAGEYriQ005558
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1448289294.50431@zaKM6Zkq/16VVYqLk5vpWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281345>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git tip of the day:
>
> git diff --color-words='.'
> git show --color-words='.'

Probably my main usage of --color-words indeed (except I omit the single
quotes ;-) ).

I think this deserves an explicit mention in the doc.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
