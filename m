From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Wed, 29 Jul 2015 18:04:43 +0200
Message-ID: <vpqio93eyqs.fsf@anie.imag.fr>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
	<vpqwpxk215y.fsf@anie.imag.fr>
	<CAOLa=ZS=bMnVDjGL0vb08t2XCTqH7tG9+QuPyz3D9wb7hCbpaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTqf-0003NW-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 18:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbbG2QEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 12:04:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42513 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbbG2QEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 12:04:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TG4fUa013212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 18:04:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TG4hvN021193;
	Wed, 29 Jul 2015 18:04:43 +0200
In-Reply-To: <CAOLa=ZS=bMnVDjGL0vb08t2XCTqH7tG9+QuPyz3D9wb7hCbpaA@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 29 Jul 2015 21:26:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Jul 2015 18:04:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TG4fUa013212
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438790682.63385@JriFDtmNUfmWt/hcLoGgLg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274914>

Karthik Nayak <karthik.188@gmail.com> writes:

> Ah, I hate making grammatical errors, Even though I check it always gets away.
> Anyways waiting for Junio and others to reply on this version. Could do a resend
> for this series if needed.

If you took all my remarks into account, I think it's worth a resend as
it should make it easier for new reviewers.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
