From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSoC] Microproject :- Teaching git pull --rebase the --no-autostash flag
Date: Fri, 26 Feb 2016 14:16:34 +0100
Message-ID: <vpqy4a7y5l9.fsf@anie.imag.fr>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, me@ikke.info, pyokagan@gmail.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 14:19:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZIJF-0005L9-7p
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 14:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbcBZNTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 08:19:49 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48598 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbcBZNTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 08:19:48 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QDGWpK009540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 26 Feb 2016 14:16:32 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QDGY4t006324;
	Fri, 26 Feb 2016 14:16:34 +0100
In-Reply-To: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Fri, 26 Feb 2016 16:53:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Feb 2016 14:16:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1QDGWpK009540
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457097393.92023@8K+JfaFqLYTWiSPHGWPLKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287576>

Hi,

Some minor nits in addition to Paul's comments:

> Subject: Re: [GSoC] Microproject :- Teaching git pull --rebase the --no-autostash flag

The ":-" is typically Indian. Just use ":" here (without a space
before).

Mehul Jain <mehul.jain2029@gmail.com> writes:

> With this patch, git pull --rebase will understand --no-autostash command line flag.
> This flag will override "rebase.autostash" configuration(if set)

Here and elsewhere: space before "(".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
