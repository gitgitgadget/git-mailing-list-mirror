From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Thu, 23 Dec 2010 16:52:18 +0100
Message-ID: <20101223155217.GA2496@sandbox>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 16:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVnSr-0007MF-L3
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 16:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab0LWPwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 10:52:20 -0500
Received: from darksea.de ([83.133.111.250]:53099 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752119Ab0LWPwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 10:52:20 -0500
Received: (qmail 18438 invoked from network); 23 Dec 2010 16:52:18 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Dec 2010 16:52:18 +0100
Content-Disposition: inline
In-Reply-To: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164125>

Hi,

On Tue, Dec 21, 2010 at 05:59:54PM -0800, Junio C Hamano wrote:
> * hv/mingw-fs-funnies (2010-12-14) 5 commits
>  - mingw_rmdir: set errno=ENOTEMPTY when appropriate
>  - mingw: add fallback for rmdir in case directory is in use
>  - mingw: make failures to unlink or move raise a question
>  - mingw: work around irregular failures of unlink on windows
>  - mingw: move unlink wrapper to mingw.c
> 
> Can somebody remind me what the status of this series is?

Still dicussing and preparing a new series. I hope I will get to answer
and send the new series soon.

Cheers Heiko
