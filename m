From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Add a menu option to start Git Gui.
Date: Tue, 18 Nov 2008 20:33:22 +1100
Message-ID: <18722.35810.362792.501694@cargo.ozlabs.ibm.com>
References: <200811132312.42150.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 10:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Mzj-0006GE-Ru
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 10:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYKRJeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 04:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYKRJeU
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 04:34:20 -0500
Received: from ozlabs.org ([203.10.76.45]:60918 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbYKRJeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 04:34:19 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 11D68DDDF0; Tue, 18 Nov 2008 20:34:17 +1100 (EST)
In-Reply-To: <200811132312.42150.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101266>

Alexander Gavrilov writes:

> Git Gui already has menu commands to start gitk,
> and this makes the relation symmetric. Since gitk and
> git-gui complement each other, I think that it is
> beneficial to integrate them where it makes sense.

I think it makes more sense to have this as an item on the context
menu for the fake commit(s) for local changes.

Paul.
