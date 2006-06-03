From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk on Windows: layout problem
Date: Sat, 3 Jun 2006 19:43:38 +1000
Message-ID: <17537.22986.653849.367731@cargo.ozlabs.ibm.com>
References: <20060530185441.GA10985@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 11:45:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmSh9-0006lq-5y
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 11:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWFCJpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 05:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWFCJpU
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 05:45:20 -0400
Received: from ozlabs.org ([203.10.76.45]:16555 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932598AbWFCJpT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 05:45:19 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A947367A63; Sat,  3 Jun 2006 19:45:18 +1000 (EST)
To: git@wingding.demon.nl
In-Reply-To: <20060530185441.GA10985@nospam.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21191>

Rutger Nijlunsing writes:

> Is this a known problem? gitk-du-jour on Windows starts up with an
> unusable layout. Screenshot attached.

Is that using Tk with the cygwin X server, or the native Windows Tk
port?

Paul.
