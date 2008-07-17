From: SungHyun Nam <goweol@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH
Date: Thu, 17 Jul 2008 09:38:56 +0900
Message-ID: <487E94A0.1040801@gmail.com>
References: <g5jj21$bsp$1@ger.gmane.org> <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com> <7vr69tu91e.fsf@gitster.siamese.dyndns.org> <487E932A.5080502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: namsh@posdata.co.kr, git@vger.kernel.org, sverre@rabbelier.nl,
	namsh@posdata.co.kr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 02:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJHXY-0001fc-La
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 02:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbYGQAjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 20:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbYGQAjO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 20:39:14 -0400
Received: from main.gmane.org ([80.91.229.2]:56425 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756681AbYGQAjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 20:39:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJHWU-0004Z8-48
	for git@vger.kernel.org; Thu, 17 Jul 2008 00:39:06 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 00:39:06 +0000
Received: from goweol by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 00:39:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487E932A.5080502@gmail.com>
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88793>

SungHyun Nam wrote:
> And I also need to run a script function below between 'make all'
> and 'make test/install'. I hope GIT does this. Of course, GIT's
> Makefile would use SHELL_PATH and PERL_PATH.

Oops! I'm sorry! Ignore this part. GIT alreay does it, just i didn't 
realize that.

Regards,
namsh
