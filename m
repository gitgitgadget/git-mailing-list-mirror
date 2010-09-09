From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [RFC/PATCH] rebase: Allow to turn of ignore-if-in-upstream
Date: Thu, 09 Sep 2010 12:05:59 +0400
Message-ID: <1284019559.12549.2.camel@n900.home.ru>
References: <4C3C1FE9.40605@drmicha.warpmail.net>
	 <645d8a9bf671937c1a6962b49cf1c512e0af0d82.1279008702.git.git@drmicha.warpmail.net>
	 <AANLkTikjTgc2OVuyFTHdnHNDq9II-lGSvmin-4EWELPg@mail.gmail.com>
	  <4C825FBA.8070605@drmicha.warpmail.net>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>, kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 09 11:07:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otd6X-0006lH-T3
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 11:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0IIJHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 05:07:33 -0400
Received: from static.247.67.47.78.clients.your-server.de ([78.47.67.247]:57675
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab0IIJHc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 05:07:32 -0400
X-Greylist: delayed 1825 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2010 05:07:32 EDT
Received: from [83.149.9.158] (helo=[10.205.130.188])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <marat@slonopotamus.org>)
	id 1Otccx-0005ne-9t; Thu, 09 Sep 2010 12:37:04 +0400
X-Mailer: Modest 3.2
In-Reply-To: <4C825FBA.8070605@drmicha.warpmail.net>
Content-ID: <1284019558.12549.1.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155853>

> Pinging this one. Is there any interest? Erik is right, off course ;)

There definitely is. Since [1] rebasing became much faster (minutes instead of tens of minutes), though still it takes more than I'd like it to.

[1]: http://repo.or.cz/w/git.git/commit/34597c1f5a77c710dae33092cb8a7cb01c6b21c1
