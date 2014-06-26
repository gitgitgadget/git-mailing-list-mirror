From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH V2] alias.c: replace git_config with git_config_get_string
Date: Thu, 26 Jun 2014 18:39:12 +0200
Message-ID: <vpqoaxfmxqn.fsf@anie.imag.fr>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:39:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Ci8-0004RS-1S
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbaFZQjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 12:39:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52151 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404AbaFZQje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:39:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGdAuB013990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2014 18:39:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGdCoG014755;
	Thu, 26 Jun 2014 18:39:12 +0200
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 23 Jun 2014 03:41:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Jun 2014 18:39:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5QGdAuB013990
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404405553.2006@1oWKV1LgP4sCZWVE20Nogw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252506>

Tanay Abhra <tanayabh@gmail.com> writes:

> the config hash-table api which provides a cleaner control flow.

api -> API

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
