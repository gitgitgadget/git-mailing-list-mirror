From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/2] Add in-place editing support to git interpret-trailers
Date: Wed, 13 Jan 2016 13:44:53 +0100
Message-ID: <vpqmvs9mywq.fsf@anie.imag.fr>
References: <1452688989-13746-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 13 13:51:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJKta-0004Fv-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 13:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbcAMMvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 07:51:21 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36878 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbcAMMvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 07:51:20 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u0DCiq50025072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 13 Jan 2016 13:44:52 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0DCirx9014262;
	Wed, 13 Jan 2016 13:44:53 +0100
In-Reply-To: <1452688989-13746-1-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Wed, 13 Jan 2016 13:43:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Jan 2016 13:44:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0DCiq50025072
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1453293892.82265@VcxjhoN68nMiaMV5dP8GBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283912>

Tobias Klauser <tklauser@distanz.ch> writes:

> This patch series adds support for in-place editing to git interpret-trailers
> akin to sed -i, perl -i.
>
> v2->v3:
>  - Rephrase two error messages according to the suggestions by Matthieu Moy.

Perfect, thanks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
