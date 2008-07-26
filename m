From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Move launch_editor() from builtin-tag.c to
 editor.c
Date: Sat, 26 Jul 2008 05:00:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260456360.26810@eeepc-johanness>
References: <alpine.DEB.1.00.0807251636140.11976@eeepc-johanness> <1217003322-10291-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 05:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMa1U-0006PY-8R
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 05:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbYGZC7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYGZC7o
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:59:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:38010 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751768AbYGZC7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:59:43 -0400
Received: (qmail invoked by alias); 26 Jul 2008 02:59:41 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp046) with SMTP; 26 Jul 2008 04:59:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wLh4UYHcwCrfq8LPaXwvoOZQO2PKkFcD9LvE67t
	PjZiXHJ60pq9eR
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217003322-10291-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90160>

Hi,

On Fri, 25 Jul 2008, Stephan Beyer wrote:

> To be kind to the maintainer, I've also run the test suite again, all 
> tests passed except t4116*.sh, but this is not my fault. It's the fault 
> of 9a885fac.

You do understand that you cost everybody, who actually cared to take a 
look for herself, a few minutes?

Just to see that the change you referenced (but did not describe at all) 
is "tar -> $TAR".

And now, everybody who cared will be just puzzled.  In the best case, he 
will reply to you that your hint left to be wished for.  I do not have to 
describe the worst case, do I?

Ciao,
Dscho "who thinks that so many mails would be better if the posters would 
read the mails themselves and try to imagine how readers would perceive 
them"
