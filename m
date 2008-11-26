From: Johan Herland <johan@herland.net>
Subject: Re: French git user
Date: Wed, 26 Nov 2008 09:55:57 +0100
Message-ID: <200811260955.57421.johan@herland.net>
References: <492B9985.10103@morey-chaisemartin.com>
 <492C2F2E.2050200@morey-chaisemartin.com>
 <492D0295.6060808@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jean-Francois Veillette <jean_francois_veillette@yahoo.ca>
To: git@vger.kernel.org, devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Wed Nov 26 09:58:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5GE1-00025Q-1M
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 09:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYKZI5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 03:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYKZI5D
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 03:57:03 -0500
Received: from smtp.getmail.no ([84.208.20.33]:50640 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYKZI5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 03:57:01 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KAX00C15NIY0B00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 26 Nov 2008 09:56:58 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KAX00ER7NH99W60@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 26 Nov 2008 09:55:57 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KAX0043ENH9RZ00@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 26 Nov 2008 09:55:57 +0100 (CET)
In-reply-to: <492D0295.6060808@morey-chaisemartin.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101713>

On Wednesday 26 November 2008, Nicolas Morey-Chaisemartin wrote:
> I've been allowed to share my presentation:
> http://nicolas.morey-chaisemartin.com/git_tuto.pdf
>
> Please send me any feedback, I'm always glad to imrpove my work.

I have no knowledge of French, but on page 15 the command
"git-commit --append" is mentioned. There is no "--append"
option. I'm guessing the "--amend" option is meant instead.

Also, the very next command is "git-revert COMIT_ID".
"COMIT_ID" should probably have an extra "M".

Finally, on page 11, you say something about "git foo" vs.
"git-foo" (hopefully that the "git-foo" form is deprecated),
but in the rest of the presentation you use a mix of "git foo"
and "git-foo" (mostly "git-foo"). This seems inconsistent.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
