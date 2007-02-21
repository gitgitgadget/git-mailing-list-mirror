From: Xavier Maillard <zedek@gnu.org>
Subject: Re: git-blame.el won't run
Date: Wed, 21 Feb 2007 18:21:20 +0100
Message-ID: <1272.1172078480@localhost>
References: <13283.1171492535@localhost> <87mz393mlo.fsf@morpheus.local> <24475.1171920735@localhost> <87abz92rp9.fsf@morpheus.local> <4157.1171992534@localhost> <87fy9020ne.fsf@morpheus.local> <13478.1172059706@localhost> <87vehvsjho.fsf@morpheus.local>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 18:24:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJvCJ-0004vL-Gs
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 18:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbXBURYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 12:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbXBURYD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 12:24:03 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:46926 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422644AbXBURYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 12:24:01 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id A11E635AF5
	for <git@vger.kernel.org>; Wed, 21 Feb 2007 18:23:59 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1LHLKiq001273
	for <git@vger.kernel.org>; Wed, 21 Feb 2007 18:21:20 +0100
In-reply-to: <87vehvsjho.fsf@morpheus.local> 
Comments: In-reply-to =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
   message dated "Wed, 21 Feb 2007 14:55:31 +0100."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40309>

Hi,

> If you switch to the buffer called " git blame for <filename>" (notice
> the leading space, you will probably see a usage/error message from
> git.

Seen it.
 
> Maybe your git blame doesn't like the --incremental flag or the
> --contents flag.  But the problem is that I'm not sure how to make
> emacs not hang.

Ok. I fixed this by upgrading to latest stable release of Git
(according to website it is 1.5.0).

It now works as expected !

Thank you very much for your time and patience.

Xavier
