From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Gaahh!!! We've been throough this before
Date: Thu, 06 Dec 2007 17:47:40 -0500
Message-ID: <47587C0C.30908@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 23:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0PVp-0005AA-NE
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 23:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbXLFWrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 17:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbXLFWrs
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 17:47:48 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:45371 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbXLFWrr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 17:47:47 -0500
Received: by rv-out-0910.google.com with SMTP id k20so449968rvb
        for <git@vger.kernel.org>; Thu, 06 Dec 2007 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=jafn7eCuBEmzg2MU1r3dHdCIPwcQFiMksvzFOgF/XHk=;
        b=pw18aPCKhuZKfHkGeTSH41z6XtQtQyw4anEAsgvwGJnljPqmxXgTF6//S21fWVA1BRgA9CGVxmitFcKNWiWxQLxVLPZK1/KrEQJEODP23zI34CtxV+XKGhZW3OeCdtakACEP2yILpEq2DgG/xrpl2a5jOJEeAnyewrMH3ER9+Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=psMxvJiZO/db2lmGyxNnC2mLIWzUMZHvGMXFOV/quw1iaihn6Vp2UqICa9XVk0UjYd25AwLA1n122vPrbxHLy8r7fsksqbGv6KXYnVB5iDO4Tz3Z9DSbnSKsOfOlF9AZ2GJyauCrNhWrdWFYiPd0rV4bgFC2kKG8eUdO0t1cQ88=
Received: by 10.141.2.19 with SMTP id e19mr2323747rvi.1196981266653;
        Thu, 06 Dec 2007 14:47:46 -0800 (PST)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id a68sm3407917rnc.2007.12.06.14.47.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 Dec 2007 14:47:42 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67352>

Git does not NEED a name or email address to checkout something. So how 
are "Big Scary Warnings"(tm) about things that are not required 
considered anything but user hostile?

Oh, and "email.com" actually belongs to someone so should not be used as 
an example domain name.

"Big Scary Warning"(tm) follows:
git> git-checkout master

*** Your name cannot be determined from your system services (gecos).

Run

   git config --global user.email "you@email.com"
   git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident  <unknown@localhost> not allowed
git>
