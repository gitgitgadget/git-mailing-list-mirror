From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/11] git_config callers rewritten with the new config-set API
Date: Thu, 07 Aug 2014 20:36:53 +0200
Message-ID: <vpqsil8no3e.fsf@anie.imag.fr>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:37:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFSYo-0005D3-G7
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 20:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbaHGShD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 14:37:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40637 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755022AbaHGShA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 14:37:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s77Iapb8030715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 20:36:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77IarW2004441;
	Thu, 7 Aug 2014 20:36:53 +0200
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 7 Aug 2014 09:21:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Aug 2014 20:36:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77Iapb8030715
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408041415.24412@/e1x3FbGolZ006YJM1xBdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254985>

Tanay Abhra <tanayabh@gmail.com> writes:

> [v2]: git_die_config() messages changed. Diff between v1 and v2 is at the bottom.

I went through the series once more, and all the changes look good.

v3 for PATCH 11/11 addresses my comment about the commit message in v2.

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
