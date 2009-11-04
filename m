From: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
Subject: Re: Common setting for interoperability repo across windows and unix?
Date: Wed, 4 Nov 2009 21:45:24 +0000
Message-ID: <S0ax5AE0Xf8KFwjv@thewolery.demon.co.uk>
References: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
 <32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com>
Reply-To: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;charset=us-ascii;format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 23:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5oW2-0005o7-Du
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 23:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbZKDWjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 17:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932784AbZKDWje
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 17:39:34 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:38912 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932935AbZKDWje (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 17:39:34 -0500
Received: from dyn-62-56-59-246.dslaccess.co.uk ([62.56.59.246] helo=thewolery.demon.co.uk)
	by anchor-post-3.mail.demon.net with esmtpa (AUTH thewolery)
	(Exim 4.69)
	id 1N5oVv-0005nq-mi
	for git@vger.kernel.org; Wed, 04 Nov 2009 22:39:39 +0000
In-Reply-To: <32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com>
User-Agent: Turnpike/6.07-M (<AIY6Th0IPTCbh2mvECa+2uv4RK>)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132163>

In message 
<32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com>, Avery 
Pennarun <apenwarr@gmail.com> writes
>You can pull from a Windows box by running git-daemon on that box from
>the command line.  (It's easier than it sounds.)

That presumes you're running Cygwin ...

git-daemon doesn't (currently) work on msysgit. Currently I run 
git-daemon on my linpus netbook and pull/push from windows.

Cheers,
Wol
-- 
Anthony W. Youngman - anthony@thewolery.demon.co.uk
