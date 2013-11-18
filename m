From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Command-line git Vs IDE+plugin?
Date: Mon, 18 Nov 2013 18:11:54 +0100
Message-ID: <vpqiovpfxd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSNm-0004ph-90
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab3KRRMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:12:47 -0500
Received: from mx1.imag.fr ([129.88.30.5]:44964 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab3KRRMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:12:02 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rAIHBrV2002559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Nov 2013 18:11:53 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rAIHBst6014484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 18 Nov 2013 18:11:54 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 18 Nov 2013 18:11:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rAIHBrV2002559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1385399517.75689@HGHsfgtEroh9PjBAFGU2zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237992>

Hi,

I'm normally an Emacs+command-line user, but I also use Eclipse or
Netbeans on some projects. I tried using EGit and the Netbeans plugin
for Git, but found the GUI both more comlex and less powerful than the
command-line. I end-up using command-line git in a terminal, outside the
IDE (and do a refresh in the IDE after commands that modify the
worktree). Obviously, being a long-time command-line user, I'm rather
heavily biaised ;-).

I was wondering whether others had similar (or not) experience. In
particular, as a teacher, I'm wondering whether I should push my
students towards the GUI in the IDE, or advise them to keep using the
command-line (we teach them git with the command-line first anyway, but
after a year of practice, we may want to show them the GUI equivalent).

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
