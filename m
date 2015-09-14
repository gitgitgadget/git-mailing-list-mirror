From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Mon, 14 Sep 2015 16:54:58 +0200
Message-ID: <vpqsi6hjbjx.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<vpqa8sqv7p1.fsf@anie.imag.fr>
	<CAPig+cTzEQ=+FKa2j2RbfHv_NP35_vPDq1NZCeek8LX9fJF3aQ@mail.gmail.com>
	<CAPig+cR42jzxeeqpVh2sMojSCVD7Xg4RF6TDfTeg0y10o-2TLQ@mail.gmail.com>
	<CAOLa=ZQR8dJH_tAJX1wFwgTgsA178C9Ok8CvKUixywTbsUK_Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 16:55:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbVA5-0004DT-2H
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 16:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbbINOzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 10:55:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47604 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbbINOzI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 10:55:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8EEsuv3010453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 14 Sep 2015 16:54:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8EEsw6p026762;
	Mon, 14 Sep 2015 16:54:58 +0200
In-Reply-To: <CAOLa=ZQR8dJH_tAJX1wFwgTgsA178C9Ok8CvKUixywTbsUK_Eg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 14 Sep 2015 20:18:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 14 Sep 2015 16:54:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8EEsuv3010453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442847299.09456@AZpo0mUn+R7hzVuFdbOUNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277832>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Sep 14, 2015 at 12:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Specifically, I think you're referring to [1] (?).
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/276363/focus=276676
>
> No not that, that is handled in the previous patch series.
>
> I can't find the reference either, but the comment was along the lines of what
> Matthieu just mentioned above,

I had another message in mind too. Never mind, the comment is addressed,
we don't need to know if it was a real message or a collective
hallucination ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
