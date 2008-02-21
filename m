From: Mike Galbraith <efault@gmx.de>
Subject: bisect: "won't bisect on seeked tree"
Date: Thu, 21 Feb 2008 06:20:14 +0100
Message-ID: <1203571214.24456.6.camel@homer.simson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS3rj-0003ju-II
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbYBUFUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbYBUFUR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:20:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:33128 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751239AbYBUFUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:20:16 -0500
Received: (qmail invoked by alias); 21 Feb 2008 05:20:14 -0000
Received: from p54B5BA9E.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.158]
  by mail.gmx.net (mp051) with SMTP; 21 Feb 2008 06:20:14 +0100
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX1/kNxUWxYvkG7tBeN/ws4PsbflDebGrtXkLf+XglG
	jsjzOzuw1/iR1g
X-Mailer: Evolution 2.12.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74596>

Greetings,

I have no idea how tree became "seeked", but would love to know how to
"un-seek" it so I can proceed with a bisection.  Help?

	-Mike
