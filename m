From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 2/8] config.c: fix accuracy of line number in errors
Date: Mon, 04 Aug 2014 15:41:42 +0200
Message-ID: <vpq38dcs76x.fsf@anie.imag.fr>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:42:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEIWz-0007iJ-7o
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 15:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbaHDNmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 09:42:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58640 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbaHDNmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 09:42:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s74DfgKW025431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 15:41:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74DfgMa002324;
	Mon, 4 Aug 2014 15:41:42 +0200
In-Reply-To: <1406912756-15517-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 1 Aug 2014 10:05:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Aug 2014 15:41:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74DfgKW025431
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407764509.02261@yfKD6nzFm5kz1P1aJLcfZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254737>

Tanay Abhra <tanayabh@gmail.com> writes:

> From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

I usually use my @imag.fr, not @grenoble-inp.fr address as Git author
(even though my mailer has @grenoble-inp.fr as From: field). Both
addresses are equivalent so it's no big deal.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
