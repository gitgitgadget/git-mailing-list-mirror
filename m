From: Bill Priest <priestwilliaml@yahoo.com>
Subject: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Wed, 28 Nov 2007 07:48:27 -0800 (PST)
Message-ID: <820179.5481.qm@web55002.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 16:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxP9p-0002ce-8B
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbXK1Psa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbXK1Ps3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:48:29 -0500
Received: from web55002.mail.re4.yahoo.com ([206.190.58.136]:44947 "HELO
	web55002.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751213AbXK1Ps3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 10:48:29 -0500
Received: (qmail 5511 invoked by uid 60001); 28 Nov 2007 15:48:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ZN4oKhPvXzqfad8qky4MdwUd4DRubAE2r8xsPHr2h1MVmPI3HCszENrUYfRygYiUdMENlHo2DpvgN9UprLr02rAq0LDFUDkZD6EicV5XqN2tX4vSLA0kUNnh27gcf3oR1BzZSThmXJXQx75EaLnCTNki7njOnNGf24nRL3SoDo0=;
X-YMail-OSG: r7EmdfIVM1n4bZB.a48IPcmGmJj4mcDUJ_gwFMPvTX.LufVfPOxrU3wArICmFYjp.Q--
Received: from [12.44.137.148] by web55002.mail.re4.yahoo.com via HTTP; Wed, 28 Nov 2007 07:48:27 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66359>

All,
  I merged from one branch to another and had lots of
conflicts.  I've resolved a set of files from the
conflicts (in a directory) and did a git-add on this
set of files.  I wasn't able to commit these files. 
On IRC I was told that all files must be resolved
before I can commit any of them.  This seems pretty
limiting.  Why is a commit after a merge all or
nothing; I thought that git  figured out merges and
such by the differences between files??

Bill



      ____________________________________________________________________________________
Be a better sports nut!  Let your teams follow you 
with Yahoo Mobile. Try it now.  http://mobile.yahoo.com/sports;_ylt=At9_qDKvtAbMuh1G1SQtBI7ntAcJ
