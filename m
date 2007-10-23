From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: UI and git-completion.sh
Date: Wed, 24 Oct 2007 01:54:38 +0200
Message-ID: <vpqir4xgzep.fsf@bauges.imag.fr>
References: <20071023234617.45a4fc64@paolo-desktop>
	<471E6EF0.2060403@midwinter.com> <86ve8x9z1f.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Oct 24 01:55:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkTat-0002aU-EN
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 01:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbXJWXzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 19:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbXJWXzT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 19:55:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:61218 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbXJWXzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 19:55:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9NNscZ9020371
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2007 01:54:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IkTa2-00034R-5W; Wed, 24 Oct 2007 01:54:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IkTa2-0004lI-3F; Wed, 24 Oct 2007 01:54:38 +0200
In-Reply-To: <86ve8x9z1f.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Tue\, 23 Oct 2007 16\:44\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 24 Oct 2007 01:54:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62172>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Steven" == Steven Grimm <koreth@midwinter.com> writes:
>
> Steven> Also might be worth mentioning the zsh completion support. (I know it's there,
> Steven> but haven't used it -- maybe its author would care to describe it a bit?)
>
> Where is it?  I'm a zsh user, and would love to have git support.

In zsh itself.

Completion/Unix/Command/_git

-- 
Matthieu
