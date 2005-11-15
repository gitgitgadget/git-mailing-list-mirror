From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 11:27:42 -0500
Message-ID: <1132072062.25640.10.camel@dv>
References: <1132034390.22207.18.camel@dv>
	 <7vveyuqto5.fsf@assigned-by-dhcp.cox.net> <1132042427.3512.50.camel@dv>
	 <tnxek5i42y5.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 17:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec3g2-00081R-VZ
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVKOQ2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 11:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVKOQ2i
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:28:38 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:55699 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964868AbVKOQ2h
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 11:28:37 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Ec3fe-0000mO-A1
	for git@vger.kernel.org; Tue, 15 Nov 2005 11:28:35 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1Ec3eo-000709-Ej; Tue, 15 Nov 2005 11:27:42 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxek5i42y5.fsf@arm.com>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11916>

On Tue, 2005-11-15 at 10:31 +0000, Catalin Marinas wrote:
> Pavel Roskin <proski@gnu.org> wrote:
> > In particular, StGIT still needs fixing.
> 
> StGIT has been fixed for this in the latest snapshot (but not in the
> latest release). It now uses "git-symbolic-ref HEAD" to get the name
> of the current branch.

Indeed.  I misinterpreted an error message.

-- 
Regards,
Pavel Roskin
