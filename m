From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: [PATCH] urls.txt: document optional port specification in git
	URLS
Date: Thu, 5 Feb 2009 09:36:04 +0100
Message-ID: <20090205083604.GC27983@ultras>
References: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com> <20090205080913.GB27983@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 09:38:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzl6-0001XF-OA
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756761AbZBEIh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbZBEIhZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:37:25 -0500
Received: from out2.laposte.net ([193.251.214.119]:60803 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755791AbZBEIhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:37:25 -0500
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8218.laposte.net (SMTP Server) with ESMTP id 39B00E000085
	for <git@vger.kernel.org>; Thu,  5 Feb 2009 09:37:17 +0100 (CET)
Received: from ? (91-164-139-170.rev.libertysurf.net [91.164.139.170])
	by mwinf8218.laposte.net (SMTP Server) with ESMTP id 00C9BE000083
	for <git@vger.kernel.org>; Thu,  5 Feb 2009 09:37:16 +0100 (CET)
X-ME-UUID: 20090205083717331.00C9BE000083@mwinf8218.laposte.net
Content-Disposition: inline
In-Reply-To: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrvdektddrjeelucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecuucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108537>


On Wed, Feb 04, 2009 at 12:51:35PM +0100, Stefan Naewe wrote:

>  Documentation/urls.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

[...]

> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> +- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/

I did not understood. To what does '{startsb}' and '{endsb}' refer ?

-- 
Nicolas Sebrecht
