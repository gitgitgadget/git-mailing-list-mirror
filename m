From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] add documentation for writing config files
Date: Tue, 29 Jul 2014 09:46:01 +0200
Message-ID: <vpqha20ip52.fsf@anie.imag.fr>
References: <1406544146-19404-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 09:46:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC274-00030E-6p
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 09:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaG2HqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 03:46:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59361 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaG2HqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 03:46:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6T7k0F6007011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2014 09:46:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6T7k11c025818;
	Tue, 29 Jul 2014 09:46:01 +0200
In-Reply-To: <1406544146-19404-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 28 Jul 2014 03:42:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 29 Jul 2014 09:46:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6T7k0F6007011
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407224763.02169@m2Pd/sM+52sgsVtv27V7VQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254399>

Tanay Abhra <tanayabh@gmail.com> writes:

> Replace TODO introduced in commit 9c3c22 with documentation
> explaining Git config API functions for writing configuration
> files.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  Documentation/technical/api-config.txt | 31 ++++++++++++++++++++++++++++++-

Sounds good to me, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
