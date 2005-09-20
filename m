From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: that was supposed to be a [PATCH:COGITO] ...
Date: Tue, 20 Sep 2005 18:08:06 +0200
Message-ID: <20050920160754.GL14206@kiste.smurf.noris.de>
References: <112722842995-git-send-email-smurf@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 20 18:09:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHkfu-0006Ea-Oq
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVITQIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVITQIw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:08:52 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:28080 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S965053AbVITQIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 12:08:51 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EHkf8-0002KY-DP
	for git@vger.kernel.org; Tue, 20 Sep 2005 18:08:29 +0200
Received: (nullmailer pid 26020 invoked by uid 501);
	Tue, 20 Sep 2005 16:08:06 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <112722842995-git-send-email-smurf@smurf.noris.de>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9003>

Hi,

Matthias Urlichs:
> Cc: Subject:  [PATCH:  Matthias Urlichs <smurf@smurf.noris.de>
> Subject:

OK, that was the result of using this file:

>Subject: [PATCH:COGITO] Updated .gitignore to exclude generated debian/ files.
>
>Building a Debian package generates a few files, which we should ignore.
>[...]

with this command line:

$ git-send-email 0001-Updated-.gitignore-to-exclude-generated-debian-files.txt
Who should the emails appear to be from? Matthias Urlichs <smurf@smurf.noris.de>
Emails will be sent from: Matthias Urlichs <smurf@smurf.noris.de>
Who should the emails be sent to? git@vger.kernel.org
Message-ID to be used as In-Reply-To for the first email?
0001-Updated-.gitignore-to-exclude-generated-debian-files.txt
(non-mbox) Adding cc: Subject: [PATCH:COGITO] Updated .gitignore to exclude generated debian/ files. from line 'Subject: [PATCH:COGITO] Updated .gitignore to exclude generated debian/ files.'
(sob) Adding cc: Matthias Urlichs <smurf@smurf.noris.de> from line 'Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>'

... which didn't work out too well ...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You can pick your friends, and you can pick your nose, but you can't pick your
friend's nose.
