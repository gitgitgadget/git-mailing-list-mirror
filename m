From: Xavier Maillard <zedek@gnu.org>
Subject: Re: [PATCH] git-blame.el: pick a set of random colors for each git-blame turn
Date: Thu, 29 Mar 2007 11:59:26 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703290959.l2T9xQr2020320@localhost.localdomain>
References: <874po54tle.fsf@morpheus.local>
	<200703281031.l2SAVhj7004802@localhost.localdomain>
	<871wj94lua.fsf@morpheus.local>
	<200703281644.l2SGiYeB008256@localhost.localdomain> <87r6r8764r.fsf@morpheus.local>
Reply-To: Xavier Maillard <zedek@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Mar 29 13:02:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWsOw-0004BN-3N
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 13:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbXC2LCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 29 Mar 2007 07:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbXC2LCY
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 07:02:24 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:36195 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030224AbXC2LCX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 07:02:23 -0400
Received: from localhost.localdomain (cha51-2-82-244-211-40.fbx.proxad.net [82.244.211.40])
	by smtp2-g19.free.fr (Postfix) with ESMTP id ED46A8DDCD;
	Thu, 29 Mar 2007 13:02:21 +0200 (CEST)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2T9xRol020323;
	Thu, 29 Mar 2007 11:59:27 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2T9xQr2020320;
	Thu, 29 Mar 2007 11:59:26 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-reply-to: <87r6r8764r.fsf@morpheus.local> (davidk@lysator.liu.se)
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43427>


   > I thought it would be cool to have different set of colors for eac=
h
   > git-blame-mode. Function `git-blame-new-commit' does this for us
   > picking when possible, a random colors based on the set we build o=
n
   > startup. When it fails, `git-blame-ancient-color' will be used. We
   > also take care not to use the same color more than once (thank you
   > David K=C3=A5gedal, really).

   Excellent.  This version looks good.

Phew ! :) Thank you for your help and support.

Xavier
