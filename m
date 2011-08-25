From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Thu, 25 Aug 2011 23:50:35 +0200
Message-ID: <20110825215035.GB67523@book.hvoigt.net>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:50:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwhox-0000nP-KX
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab1HYVui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:50:38 -0400
Received: from darksea.de ([83.133.111.250]:48299 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755524Ab1HYVui (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:50:38 -0400
Received: (qmail 8808 invoked from network); 25 Aug 2011 23:50:35 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Aug 2011 23:50:35 +0200
Content-Disposition: inline
In-Reply-To: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180125>

Hi Junio,

On Wed, Aug 24, 2011 at 05:09:09PM -0700, Junio C Hamano wrote:
> * fg/submodule-ff-check-before-push (2011-08-20) 2 commits
>   (merged to 'next' on 2011-08-24 at 398e764)
>  + push: teach --recurse-submodules the on-demand option
>  + push: Don't push a repository with unpushed submodules
>  (this branch uses jc/combine-diff-callback.)
> 
> Will aim to merge to "master" by -rc1.

Have you seen my fixes to the tests of this here:

http://article.gmane.org/gmane.comp.version-control.git/179883

?

Cheers Heiko
