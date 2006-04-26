From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] Make die() and error() prefix line with binary name if set
Date: Wed, 26 Apr 2006 12:43:26 +0200
Organization: Berlin University of Technology
Message-ID: <20060426104326.GL5482@bolero.cs.tu-berlin.de>
References: <20060425101207.GC5482@bolero.cs.tu-berlin.de> <7vejzkrb2y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Wed Apr 26 12:44:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYhUr-0006Pq-Sq
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 12:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWDZKna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 06:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWDZKna
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 06:43:30 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:39321 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S932318AbWDZKn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 06:43:29 -0400
Received: from mailhost.cs.tu-berlin.de (postfix@mail.cs.tu-berlin.de [130.149.17.13])
	by mail.cs.tu-berlin.de (8.9.3p2/8.9.3) with ESMTP id MAA23152
	for <git@vger.kernel.org>; Wed, 26 Apr 2006 12:43:27 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTP id 98C2EF259
	for <git@vger.kernel.org>; Wed, 26 Apr 2006 12:43:27 +0200 (MEST)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
 by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 10224)
 with ESMTP id 20241-16 for <git@vger.kernel.org>;
 Wed, 26 Apr 2006 12:43:27 +0200 (MEST) 15002
Received: from bolero.cs.tu-berlin.de (bolero.cs.tu-berlin.de [130.149.19.1])
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Wed, 26 Apr 2006 12:43:27 +0200 (MEST)
Received: (from pdmef@localhost)
	by bolero.cs.tu-berlin.de (8.13.6+Sun/8.12.8/Submit) id k3QAhQ73011469
	for git@vger.kernel.org; Wed, 26 Apr 2006 12:43:26 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejzkrb2y.fsf@assigned-by-dhcp.cox.net>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-System: bolero.cs.tu-berlin.de (SunOS 5.9 sun4u)
User-Agent: mutt-ng/devel-r802 (SunOS)
X-Virus-Scanned: by amavisd-new at cs.tu-berlin.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19196>

* Junio C Hamano <junkio@cox.net>:

>... what's wrong with your mailer?

I don't know. I recall to have seen this earlier.

And while I'll look at it (I bet this an f=f issue), the patch is at:

   <http://user.cs.tu-berlin.de/~pdmef/0001-Make-die-and-error-prefix-line-with-binary-name-if-set.txt>

   bye, Rocco
-- 
:wq!
