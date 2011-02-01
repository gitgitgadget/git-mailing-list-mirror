From: Marc Weber <marco-oweber@gmx.de>
Subject: git ls-files --with is very hard if not impossible to find when reading man page
Date: Wed, 02 Feb 2011 00:33:04 +0100
Message-ID: <1296603039-sup-9451@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 00:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPil-0001vz-JS
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 00:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab1BAXdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 18:33:10 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:40691 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751576Ab1BAXdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 18:33:09 -0500
Received: (qmail invoked by alias); 01 Feb 2011 23:33:06 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp071) with SMTP; 02 Feb 2011 00:33:06 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+GU0dvOXuG6wZtmAoB3lScF3S9rytHg9Sk3bYoud
	uG7N8BSryqyTGE
Received: by mail.gmx.net (sSMTP sendmail emulation); Wed, 02 Feb 2011 00:33:04 +0100
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165880>

Hi

I knew about git-ls. But searching the man page for both: commit and
hash or such didn't tell me about hte --with flag (which cirwin told me
on irc).

Is it worth adding to the man page?

Or is the option that common that most users just know about it?

Marc Weber
