From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 00/19]  convert test -a/-o to && and || patch series
Date: Tue, 20 May 2014 16:09:35 +0200
Message-ID: <vpq8upw4k4g.fsf@anie.imag.fr>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 16:09:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmkjf-00036Y-RC
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbaETOJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:09:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48412 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbaETOJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 10:09:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s4KE9YYE023130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 May 2014 16:09:34 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4KE9ZIC009025;
	Tue, 20 May 2014 16:09:35 +0200
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Tue, 20 May 2014 06:50:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 20 May 2014 16:09:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4KE9YYE023130
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1401199774.56894@96CJzsoeJxn5JkIRa7NLKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249683>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Elia Pinto (19):

I went through the series (not very thoroughly) and it sounds good to
me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
