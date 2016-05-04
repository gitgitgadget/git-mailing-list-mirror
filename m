From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Wed, 04 May 2016 13:27:22 +0200
Message-ID: <vpq1t5it65h.fsf@anie.imag.fr>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
	<1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
	<1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
	<xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
	<6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com>
	<xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
	<32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
	<CAP8UFD2XXE2Hh9NxMFS3dvaJk90LgwdbDcXmHvVir6MEKu2B3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 13:27:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axuyC-0005N8-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbcEDL1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:27:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51465 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbcEDL1w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:27:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u44BRKJ1026815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 4 May 2016 13:27:21 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u44BRMrV010740;
	Wed, 4 May 2016 13:27:22 +0200
In-Reply-To: <CAP8UFD2XXE2Hh9NxMFS3dvaJk90LgwdbDcXmHvVir6MEKu2B3Q@mail.gmail.com>
	(Christian Couder's message of "Wed, 4 May 2016 11:11:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 04 May 2016 13:27:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u44BRKJ1026815
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462966041.70169@eHHUokQmRrJ5dxCsDjwoBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293536>

Christian Couder <christian.couder@gmail.com> writes:

> You might also want to check:
>
> http://www.shellcheck.net/

Indeed, it's also an excellent tool to check for common mistakes in
shell scripts (there are many, and shellcheck is good at pointing them
out and explaining them).

http://www.shellcheck.net/

(Available online and as a command-line tool)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
