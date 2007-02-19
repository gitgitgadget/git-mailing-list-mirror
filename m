From: Xavier Maillard <zedek@gnu.org>
Subject: Re: git-blame.el won't run
Date: Mon, 19 Feb 2007 22:32:15 +0100
Message-ID: <24475.1171920735@localhost>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 01:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIpo-0006Cb-Uj
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbXBTAV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbXBTAU7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:20:59 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:35183 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbXBTAUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:20:48 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B1A4351FD8
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 22:34:58 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1JLWF6h024476
	for <git@vger.kernel.org>; Mon, 19 Feb 2007 22:32:15 +0100
In-reply-to: <87mz393mlo.fsf@morpheus.local> 
Comments: In-reply-to =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
   message dated "Mon, 19 Feb 2007 21:42:59 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40171>

Hi,

> Can you please set debug-on-error to t and show me the backtrace you get?

Nothing happens. I have to C-g after having waited for a few
seconds.
 
> And does M-! git-blame work in your emacs?

No it is not. It shows a help message (usage message).

Xavier
