From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/14] t3905-stash-include-untracked.sh: use the $( ... ) construct for command substitution
Date: Wed, 30 Apr 2014 18:42:41 +0200
Message-ID: <vpq4n1alqf2.fsf@anie.imag.fr>
References: <1398874987-14873-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfXas-0003V0-F1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 18:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbaD3Qmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 12:42:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43309 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964913AbaD3Qmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 12:42:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3UGgd4r001057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Apr 2014 18:42:39 +0200
Received: from anie.imag.fr (ensi-vpn-228.imag.fr [129.88.57.228])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3UGgfNY011676;
	Wed, 30 Apr 2014 18:42:41 +0200
In-Reply-To: <1398874987-14873-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 30 Apr 2014 09:22:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 Apr 2014 18:42:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3UGgd4r001057
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399480960.9159@I6gyzTNn1ZMrCgcFG1ZtuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247741>

Patches 1/14 are

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

On a side note, reviewing patches by batches of 14 patches actually
turns out to be much less convenient for me than reviewing larger
batches.

If I'm counting correctly, there should be around 100 patches remaining.
I'd suggest that the next batch contain them all (probably publishing
the branch somewhere and posting a merge request here would be better to
avoid sending 100 mails).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
