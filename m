From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5] upload-pack.c: use parse-options API
Date: Tue, 31 May 2016 13:27:56 +0200
Message-ID: <vpqbn3mxy9v.fsf@anie.imag.fr>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
	<xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, peff@peff.net,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 13:28:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7hqK-0004iV-G4
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 13:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbcEaL2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 07:28:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39193 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbcEaL2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 07:28:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4VBRuLl017629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 May 2016 13:27:56 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4VBRvmX027071;
	Tue, 31 May 2016 13:27:57 +0200
In-Reply-To: <xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 30 May 2016 12:26:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 31 May 2016 13:27:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4VBRuLl017629
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465298877.88502@GP8TekFKVwsa/5S85U1FHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295969>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:
>
>> From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
>> Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
>
> Don't you want to be known to the project as the email that matches
> your Signed-off-by: line?

Actually, that's even: don't you want to use a valid email address in
your Signed-off-by: ? ;-)

@ensimag.grenoble-inp.fr => student's current adress
@grenoble-inp.org => students lifelong address. If not already done,
                     students can already set it up to redirect to their
                     current address.
@grenoble-inp.fr => only for staff (i.e. me but not students).

I have a preference for the @grenoble-inp.org in the From and
Signed-off-by as the Git history will remain after the current adress
become invalid.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
