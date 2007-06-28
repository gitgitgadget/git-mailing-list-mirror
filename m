From: Michal Rokos <michal.rokos@gmail.com>
Subject: Re: Build git on HP/UX
Date: Thu, 28 Jun 2007 14:23:56 +0200
Message-ID: <200706281423.56344.michal.rokos@gmail.com>
References: <20070628105952.GC8925@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 14:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3tZ2-0000U6-CO
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 14:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760818AbXF1M5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 08:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760240AbXF1M5e
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 08:57:34 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:38135 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581AbXF1M5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 08:57:34 -0400
X-Greylist: delayed 2008 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2007 08:57:33 EDT
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id B2524909; Thu, 28 Jun 2007 14:24:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 11465903;
	Thu, 28 Jun 2007 14:24:02 +0200 (CEST)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21816-06; Thu, 28 Jun 2007 14:24:01 +0200 (CEST)
Received: from 89-24-36-54.4ginternet.cz (89-24-36-54.4ginternet.cz [89.24.36.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 94BB9512;
	Thu, 28 Jun 2007 14:24:01 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070628105952.GC8925@cip.informatik.uni-erlangen.de>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51102>

Hi,

I'm using it every day...

On Thursday 28 June 2007 12:59:52 Thomas Glanzmann wrote:
> Hello,
> could someone here describe what he did to build git on HP/UX?
> Some of my questions is:
>
>         - What build chain did you use (gcc?)?
>         - Did you use binary packages provided by whom?

On Parics I'm using gcc.
On Itanium I'm using hp stock cc (so no need to build gcc-build-chain)

I'm git-pulling it very often - co I'm compiling it from the git sources.

Michal.

--
Michal Rokos
ICQ: 36118339
Jabber: michal.rokos@gmail.com
