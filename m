From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 17:09:26 +0200
Message-ID: <20050521150926.GA96606@dspnet.fr.eu.org>
References: <4870.10.10.10.24.1116646732.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 17:09:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZVad-0005ZK-K2
	for gcvg-git@gmane.org; Sat, 21 May 2005 17:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVEUPJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 11:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEUPJa
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 11:09:30 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:56837 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261637AbVEUPJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 11:09:27 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 3347634D19; Sat, 21 May 2005 17:09:26 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <4870.10.10.10.24.1116646732.squirrel@linux1>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2005 at 11:38:52PM -0400, Sean wrote:
>  -?, --help             Give this help list

Could you make that '-h' please ?


>  -V, --version          Print program version

And that '-v'.  -V traditionally means verbose, -v version.  Yes, I
know there are counter-examples, but statistically...

  OG.
