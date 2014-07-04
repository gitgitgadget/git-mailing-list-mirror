From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Fri, 04 Jul 2014 11:17:43 +0200
Message-ID: <vpq1tu1xz2g.fsf@anie.imag.fr>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
	<vpqoax8m8bh.fsf@anie.imag.fr> <53B63461.2040300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:17:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2zcw-0004fn-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 11:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbaGDJRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 05:17:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55318 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbaGDJRu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 05:17:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s649HgNp013603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Jul 2014 11:17:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s649HhgC028813;
	Fri, 4 Jul 2014 11:17:43 +0200
In-Reply-To: <53B63461.2040300@gmail.com> (Tanay Abhra's message of "Fri, 04
	Jul 2014 10:28:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 04 Jul 2014 11:17:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s649HgNp013603
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405070265.36415@SqZg5WR9E49fpq1u57JEqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252891>

Tanay Abhra <tanayabh@gmail.com> writes:

> Hi,
>
> I have cooked up a single hashmap implementation. What are your
> thoughts about it?

I had a quick look, and it looks good to me. I'll make a more detailed
review when you send the next series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
