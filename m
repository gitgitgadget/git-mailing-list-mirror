From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 11/11] for-each-ref: add '--contains' option
Date: Wed, 17 Jun 2015 10:40:51 +0200
Message-ID: <vpqk2v2zq0c.fsf@anie.imag.fr>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
	<1434464457-10749-1-git-send-email-karthik.188@gmail.com>
	<1434464457-10749-11-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 10:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58uE-0002Cf-Kf
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbFQIlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 04:41:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52508 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbbFQIk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:40:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8eogH006383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 10:40:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8eptL031049;
	Wed, 17 Jun 2015 10:40:51 +0200
In-Reply-To: <1434464457-10749-11-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jun 2015 19:50:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Jun 2015 10:40:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5H8eogH006383
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435135255.15988@DzkkX501lgRrV5YlB3G2SA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271821>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add the '--contains' option provided by 'ref-filter'. The '--contains'
> option lists only refs which are contain the mentioned commit (HEAD if

s/are //

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
