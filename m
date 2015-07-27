From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Mon, 27 Jul 2015 14:01:37 +0200
Message-ID: <vpqa8uhbyhq.fsf@anie.imag.fr>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
	<CAOLa=ZQvMV8C6LV-+B3m74x209Fr1X7W=piaL-Eftu_PdRW64w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 14:02:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJh6T-0005Hq-J3
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 14:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbbG0MBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 08:01:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36217 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbbG0MBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 08:01:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6RC1a0e014902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 27 Jul 2015 14:01:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6RC1b3j010943;
	Mon, 27 Jul 2015 14:01:37 +0200
In-Reply-To: <CAOLa=ZQvMV8C6LV-+B3m74x209Fr1X7W=piaL-Eftu_PdRW64w@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 26 Jul 2015 10:06:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 Jul 2015 14:01:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6RC1a0e014902
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438603298.14295@QbnLL6PjVQcr2C5jh4LIZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274670>

Karthik Nayak <karthik.188@gmail.com> writes:

> I've been working on the same branch, and that's why I didn't really
> provide interdiff's,

You can keep working on the same branch and tag versions you send to the
list. "This state is what I sent to the list as vX" is something that does not
change in time hence a tag avoids mistakenly changing it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
