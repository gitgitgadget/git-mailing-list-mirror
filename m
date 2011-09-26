From: Thomas Koch <thomas@koch.ro>
Subject: emacs as mergetool
Date: Mon, 26 Sep 2011 18:21:27 +0200
Message-ID: <201109261821.28382.thomas@koch.ro>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 19:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8EeF-0008Ss-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab1IZRHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 13:07:13 -0400
Received: from koch.ro ([88.198.2.104]:39764 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab1IZRHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 13:07:12 -0400
X-Greylist: delayed 2606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Sep 2011 13:07:11 EDT
Received: from [195.65.248.188] (helo=t61.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <thomas@koch.ro>)
	id 1R8Dy2-0005Bh-Df
	for git@vger.kernel.org; Mon, 26 Sep 2011 18:23:44 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.0-1-amd64; KDE/4.6.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182135>

Hi,

would you be so kind and give an emacs newbie (and vim refugee) a hint about 
using emacs as mergetool?

- Which one? ediff vs. emerge (I don't bother learning, just give me the best)
- I'd like to have a setup, where I can run mergetool with different options 
to
  - connect to a running emacs server
  - run emacs in X
  - or in the terminal (default)
- Is it possible to resolve all conflicting files in one session instead of 
having emacs called again for every file?
- Do you know a tutorial on emacs as a mergetool?

Thank you,

Thomas Koch, http://www.koch.ro
