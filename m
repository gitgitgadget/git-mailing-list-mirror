From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 01:03:26 -0700 (PDT)
Message-ID: <m3hcadul6j.fsf@localhost.localdomain>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 10:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMelV-0002hS-Ng
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 10:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYGZIDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 04:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbYGZIDc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 04:03:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:50205 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYGZIDa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 04:03:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1345008nfc.21
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=aaoeGeNWzr3AGc7FmqZypitAjDdQQueRWRWK/unMRg0=;
        b=ZXESh/+7Qo2sNMpS3tZHoiwwb4gWu7JaX9txpHIveVdlZcjXl3e4Y5ZCxPg/5xUtp7
         NVQnJB8UTS4iu3IytnrplxmXtQXf3CUtVgB6urPebYGAY9N6n2Ey+4dl/eVvM97vB4Dc
         eUm4+d3rvDIjKmXd+Vz1kwpK0cNVw5IJInI94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jvr6Qmb1El/qqdCtN3+BUy65t67mVfN8Ko8d2/FF1ZHSHWSOiXM+29LV29PlTUpAxm
         HctDZ9zSyggJP+wriKJ/gXmuX/GnR6XypTUQ8CwaLNhcKWPG4qoO7lu9AXPSxCGE6Ukr
         JPKDiIOC442oLg0qkeGyztAp8Ky6l+7Qi1EQU=
Received: by 10.210.34.2 with SMTP id h2mr3049324ebh.78.1217059407653;
        Sat, 26 Jul 2008 01:03:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.191])
        by mx.google.com with ESMTPS id y37sm16612636iky.8.2008.07.26.01.03.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 01:03:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6Q83LQP017875;
	Sat, 26 Jul 2008 10:03:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6Q83GM1017872;
	Sat, 26 Jul 2008 10:03:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90196>

"Scott Chacon" <schacon@gmail.com> writes:

> A followup on the post I did a few days ago about Git documentation.
> I forked Petr's git.or.cz site and put up a version that I think is a
> bit more accessible and newbie-friendly at git-scm.com.  I had meant
> to discuss this with Petr before posting it to you all, but I
> published a blog post that got a bit more attention than I expected,
> and I didn't want you all to think I didn't care about your opinion,
> as some have already accused me of.

On thing I am curious about: how do you plan to have current version
of Git in the download / last version section?  Petr Baudis uses
custom script, which search git mailing list for "[ANNOUNCE]" posts,
and automatically updates download / last version links.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
