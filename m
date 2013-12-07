From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Sat, 07 Dec 2013 19:49:56 +0100
Message-ID: <vpqzjocwl63.fsf@anie.imag.fr>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 19:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpMxY-0000vk-Sc
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 19:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab3LGSuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 13:50:25 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59085 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755666Ab3LGSuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 13:50:12 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rB7Inwxl021779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Dec 2013 19:49:58 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rB7InvEE004822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 7 Dec 2013 19:50:00 +0100
In-Reply-To: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Dec 2013 15:52:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 07 Dec 2013 19:49:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rB7Inwxl021779
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1387047003.6708@Bob03anuxua+MidNIXAOkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239013>

Junio C Hamano <gitster@pobox.com> writes:

> * mm/mv-file-to-no-such-dir-with-slash (2013-12-04) 1 commit
>  - mv: let 'git mv file no-such-dir/' error out

Why is it "stalled"? I think I took all remarks into account.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
