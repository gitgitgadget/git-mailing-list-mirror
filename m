From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sun, 14 Dec 2008 11:33:38 +0100
Message-ID: <vpq7i63nj0d.fsf@bauges.imag.fr>
References: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 11:38:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoMK-0002sD-2Q
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbYLNKgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYLNKgh
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:36:37 -0500
Received: from imag.imag.fr ([129.88.30.1]:58741 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438AbYLNKgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:36:37 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mBEAXdPa023122
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 14 Dec 2008 11:33:39 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LBoI6-0003E0-SF; Sun, 14 Dec 2008 11:33:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LBoI6-0003OS-Pq; Sun, 14 Dec 2008 11:33:38 +0100
In-Reply-To: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> (David Howells's message of "Fri\, 12 Dec 2008 18\:28\:27 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 14 Dec 2008 11:33:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103057>

David Howells <dhowells@redhat.com> writes:

> +So, you want to do some Linux kernel development?  And you hear there's this
> +piece of software called 'GIT' that you probably ought to be using when dealing
> +with the kernel community?

I'm afraid too many people read this as "Git is only about kernel
hacking, if you're not a kernel hacker, find something else".

(and I think far too many people already think that indeed)

-- 
Matthieu
