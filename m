From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC] just an (stupid) idea when creating a new branch
Date: Sat, 08 Jul 2006 23:27:20 -0400
Message-ID: <1152415640.2103.10.camel@dv>
References: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 05:27:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzPx9-0000xX-B0
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 05:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWGID1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 23:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWGID1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 23:27:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:9156 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964923AbWGID1Y
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 23:27:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FzPx4-0002NT-UL
	for git@vger.kernel.org; Sat, 08 Jul 2006 23:27:23 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FzPx2-0000jv-Nf; Sat, 08 Jul 2006 23:27:20 -0400
To: moreau francis <francis_moreau2000@yahoo.fr>
In-Reply-To: <20060708155547.73054.qmail@web25814.mail.ukl.yahoo.com>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23520>

Hello!

On Sat, 2006-07-08 at 15:55 +0000, moreau francis wrote:
> Hi GIT folks.
> 
> I'm a complete newbie on git development so excuse me if
> this idea is completely stupid.
> 
> Would it be possible to let the user stick a short explanation
> on  what a branch is supposed to implement during its creation.

Just for your information, this is already implemented by StGIT.  For
instance, .git/patches/master/description contains the description of
the "master" branch.

If you run "stg branch --list", the branch descriptions will be listed.
I'm not aware of any commands to change the description.

-- 
Regards,
Pavel Roskin
