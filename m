From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 7/7] Add tests for `git_config_get_string()`
Date: Wed, 23 Jul 2014 22:08:41 +0200
Message-ID: <vpqiomnu9bq.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-8-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 22:08:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2qP-0003BR-5C
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 22:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbaGWUIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 16:08:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50480 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbaGWUIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 16:08:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6NK8dbx003340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2014 22:08:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6NK8fh8026502;
	Wed, 23 Jul 2014 22:08:41 +0200
In-Reply-To: <1406140978-9472-8-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Jul 2014 22:08:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6NK8dbx003340
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406750922.14557@OgvwMr1mNq5NoL3k+WM1Mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254120>

Tanay Abhra <tanayabh@gmail.com> writes:

> Add tests for `git_config_get_string()`, check whether it
> dies printing the line number and the file name if an NULL

a NULL (no n).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
