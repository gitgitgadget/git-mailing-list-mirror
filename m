From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 19 Oct 2015 10:12:46 +0200
Message-ID: <vpqy4ezjmyp.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
	<xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
	<xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
	<vpq7fms9cjs.fsf@grenoble-inp.fr>
	<xmqq37xfncak.fsf@gitster.mtv.corp.google.com>
	<vpq612bzz0o.fsf@grenoble-inp.fr>
	<CAOLa=ZQ5dCx4XheMvaFo1u-fR=uaR-LU-n7KHR3xNJ7TuF-zww@mail.gmail.com>
	<xmqqzizfa2n7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo5Yz-00043V-5R
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 10:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbbJSIMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 04:12:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33962 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbbJSIMw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 04:12:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9J8CjAi026401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 19 Oct 2015 10:12:45 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9J8CkW6016956;
	Mon, 19 Oct 2015 10:12:46 +0200
In-Reply-To: <xmqqzizfa2n7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 18 Oct 2015 21:44:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 19 Oct 2015 10:12:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9J8CjAi026401
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445847166.59025@107ey2e3mOLllL0GhzeyCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279867>

Junio C Hamano <gitster@pobox.com> writes:

> I personally would suggest whichever order you feel more comfortable
> and less error-prone.

This is a good summary, and I fully agree with it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
