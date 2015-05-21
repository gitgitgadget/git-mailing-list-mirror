From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Thu, 21 May 2015 15:04:30 +0200
Message-ID: <20150521130429.GB22553@book.hvoigt.net>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	pasky@suse.cz
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 21 15:04:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQ9Q-00056g-DN
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbbEUNEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 09:04:36 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:57680 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbbEUNEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:04:35 -0400
Received: from [80.135.94.69] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YvQ8l-0002bp-Ci; Thu, 21 May 2015 15:03:59 +0200
Content-Disposition: inline
In-Reply-To: <1432163517-22785-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269583>

On Wed, May 20, 2015 at 04:11:57PM -0700, Stefan Beller wrote:
> It's better to start the man page with a description of what submodules
> actually are instead of saying what they are not.
> 
> Reorder the paragraphs such that
> the first short paragraph introduces the submodule concept,
> the second paragraph highlights the usage of the submodule command,
> the third paragraph giving background information,
> and finally the fourth paragraph discusing alternatives such
> as subtrees and remotes, which we don't want to be confused with.
> 
> This ordering deepens the knowledge on submodules with each paragraph.
> First the basic questions like "How/what" will be answered, while the
> underlying concepts will be taught at a later time.
> 
> Making sure it is not confused with subtrees and remotes is not really
> enhancing knowledge of submodules itself, but rather painting the big
> picture of git concepts, so you could also argue to have it as the second
> paragraph. Personally I think this may confuse readers, specially newcomers
> though.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

Looks good to me.

Cheers Heiko
