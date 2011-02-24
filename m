From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 17:19:10 +0100
Message-ID: <1298564280-sup-4262@localhost.localdomain>
References: <20110224112246.3f811ac2@glyph>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:19:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsduT-00022X-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab1BXQTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:19:17 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:59500 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756200Ab1BXQTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:19:16 -0500
Received: (qmail invoked by alias); 24 Feb 2011 16:19:13 -0000
Received: from pD9E093B7.dip.t-dialin.net (EHLO mail.gmx.net) [217.224.147.183]
  by mail.gmx.net (mp065) with SMTP; 24 Feb 2011 17:19:13 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+pNz4PlO2pG/QZFSf/5TsfyBG3qEKSfg2A5r2eg2
	JvZoBEEU/tKpLa
Received: by mail.gmx.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 17:19:10 +0100
In-reply-to: <20110224112246.3f811ac2@glyph>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167834>

I'd not change behaviour of
git commit -a

introducing 

git commit -A behaving like git add -A && git commit would be fine.

Marc Weber
