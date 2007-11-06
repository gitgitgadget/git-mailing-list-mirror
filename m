From: "Patrick Aljord" <patcito@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Tue, 6 Nov 2007 19:39:44 +0100
Message-ID: <6b6419750711061039l26290561wd2abe07035a8679c@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
	 <Pine.LNX.4.64.0711060903070.8577@ds9.cixit.se>
	 <8c5c35580711060044i7a3d0134p42e9437cbe2a258b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 19:40:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpTLI-0002MW-AE
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 19:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942AbXKFSju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 13:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbXKFSju
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 13:39:50 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:37278 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbXKFSjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 13:39:49 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2008638mue
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 10:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZQTuIOr3T5cwFuvji6S7etdw+23G79P6bFxxUiAv9/E=;
        b=CVsnvQxCu2u/Nah07KytjmsdJp++KjYG0mTiRu9cDaeIG0Fp/ylKpcS5isPop8ag6ynjf0XDhB+aZxeP5fvX/SMwnSFtwhyxoUydm46/eDMq5EH4OBsQ96Z40w3JmN2O742s1DKUoPyTGLJ3QDsa0zJZyDLN12k4kN6ea8kk8B4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p+hZk2NU3yy6M/6xVel1l2Yy1MeA9a1pMZUifzzwT6/PZeTgXklNBKBX6lf/lXcEGsCKAl4KuG3xhSaN9fq8FvUXN7h+TB/n/XH/i1wSAJdy815fEbqWdIgpdpqy+UgoQAJkE0blxlN0MvWGBvjgRtXsFGQp0h54uNvN1OcAQKU=
Received: by 10.82.177.3 with SMTP id z3mr13124914bue.1194374384708;
        Tue, 06 Nov 2007 10:39:44 -0800 (PST)
Received: by 10.82.184.13 with HTTP; Tue, 6 Nov 2007 10:39:44 -0800 (PST)
In-Reply-To: <8c5c35580711060044i7a3d0134p42e9437cbe2a258b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63700>

Looks great, thanks for the new release.

It would be great if when a commit message contains something such as
#1234 it would automatically link to the bug tracker page of that bug
(like Trac does) by preconfiguring the bugtracker URL.

Such as "bug #238 test for root-window that XFree86 fixed in their"
would link the "#238"  part to
http://bugs.freedesktop.org/show_bug.cgi?id=238
