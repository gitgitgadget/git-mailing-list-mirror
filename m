From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 1/6] gitk: Add Return and Escape bindings to dialogs.
Date: Fri, 7 Nov 2008 22:41:26 +1100
Message-ID: <18708.10598.47674.777758@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-2-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:53:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyPuJ-0003HL-3z
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYKGLwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbYKGLwI
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:52:08 -0500
Received: from ozlabs.org ([203.10.76.45]:52042 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbYKGLwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:52:05 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id BF4EDDDDF0; Fri,  7 Nov 2008 22:52:03 +1100 (EST)
In-Reply-To: <1225652389-22082-2-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100305>

Alexander Gavrilov writes:

> It is often more convenient to dismiss or accept a
> dialog using the keyboard, than by clicking buttons
> on the screen. This commit adds key binding to make
> it possible with gitk's dialogs.

Thanks, applied.

Paul.
