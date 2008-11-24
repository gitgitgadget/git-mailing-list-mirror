From: "Tim Visher" <tim.visher@gmail.com>
Subject: Hello All and Seeking Information
Date: Mon, 24 Nov 2008 11:28:22 -0500
Message-ID: <c115fd3c0811240828y61e7bfecka1cacdd37865a4e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 17:29:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4eJg-000487-Tk
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 17:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbYKXQ2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 11:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYKXQ2Y
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 11:28:24 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:58116 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbYKXQ2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 11:28:23 -0500
Received: by yw-out-2324.google.com with SMTP id 9so859559ywe.1
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=hcNedEEnrQSMuFXnL6TKh64pMYLR5fVgy81vBd5bJeY=;
        b=HdBJjxZJkKIE8hS4E+3e2nDjS+ytyLHaC3idet68nDnnGxK+8YDg6PphuCKSWc3Bhh
         7fILNDdgWo9JHOdqqP7BBD03bNAQim8+XW8iAfX7eMFxvHi9LdZxY/XEwblicpv/0t+W
         wv0KhpSMAdl+gvwA1v2B+bgHl0AH4uJ6sFEQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=tyHewYnKpPnK/+tZiWOMS3pGyEtXsu+ewuxiWm18bwU5NnPKsrFdYrf22aldYDPFVd
         AEGJmAALYytlDBZvWDu28P6s2+ohZfk1xf2fdT6DqoEoAqa4ev+7kHxCEWo4QIUdorrH
         fnYGWgAU9KHP9UYtADLUPZpeLKvrsjlYxpVwo=
Received: by 10.101.68.19 with SMTP id v19mr1604431ank.62.1227544102258;
        Mon, 24 Nov 2008 08:28:22 -0800 (PST)
Received: by 10.100.232.8 with HTTP; Mon, 24 Nov 2008 08:28:22 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101613>

Hello Everyone,

I'm new to the list so I figured I'd introduce myself instead of just
wall-flowering... "Hello"... :)

Anyway, I really like a lot of the concepts found in Git and the
reported power and flexibility of it are very intriguing.  However,
there are some issues that I can't wrap my head around, such as how
you can guarantee that all developers are working on the same
code-base without a central repo.  I would classify a lot of my issues
as paradigm rather than technically related. I understand a lot of
Git's underpinnings and the basic usage of it, I just can't wrap my
head around the higher-order parts of it.

I've done some Googling and I can't find a good 'Introduction to
Distributed SCM Concepts for Centralized SCM Developers' article yet.
Ideally, this would be an article all about the high-level thought
processes that go into utilizing Distributed SCM in a team environment
where having a single canonical representation of your project that
all developers are working off of is important.

Anyway, looking forward to participating.

P.S. Anyone want to tell me why the Git Mailing List was set-up
monolithically rather than the typical git-dev, git-user, git-admin,
git-x etc.?  I don't plan on hacking on Git so having the Dev mail in
the list is just noise for me.  I'm sure other people think that too.
Just wondering.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
