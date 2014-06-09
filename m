From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 00/20] avoid "test <cond> -a/-o <cond>"
Date: Mon, 09 Jun 2014 15:31:50 +0200
Message-ID: <vpq1tuyw6nt.fsf@anie.imag.fr>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 15:32:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtzg8-0006Y9-QT
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 15:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933542AbaFINb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 09:31:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43767 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222AbaFINb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 09:31:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s59DVn9S009686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jun 2014 15:31:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s59DVogc013503;
	Mon, 9 Jun 2014 15:31:50 +0200
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Fri, 6 Jun 2014 07:55:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Jun 2014 15:31:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s59DVn9S009686
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402925510.77978@vjmEgIvSUwWp2Wi8pvDp0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251077>

Elia Pinto <gitter.spiros@gmail.com> writes:

> These patch series  convert test -a/-o to && and ||.

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
