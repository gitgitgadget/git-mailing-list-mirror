From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Sat, 26 Apr 2014 14:35:09 -0500
Message-ID: <535c0a6ddd4d1_5310a773082@nysa.notmuch>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
 <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
 <BLU0-SMTP3741FBD4980A29338AC8BA8D1450@phx.gbl>
 <535b4c5a3c91c_3d63109d2f00@nysa.notmuch>
 <27645ABF2E944872BB3F944B17E9490B@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Alex Davidson <descenterace@hotmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 21:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We8YN-0008TQ-F0
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 21:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbaDZTpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 15:45:42 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56418 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaDZTpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 15:45:41 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so5664293obb.19
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=GQDPidEgm21ecgrYufA3WNh0Kp9zYtCG5bRO7ZsBR9I=;
        b=xihs80fYz7VSjSzNXFlrPSwPgMkpBaVp5moCzQ+BMJttyvDvKJRqT5dRfVUSCXsd1P
         ViDgHE+r3p8wvLxbZhhz4dn1Mo98f2yMF0VVybfQYWNl/AKeujNtjElxBtYQ+qH6EHiz
         rPPSqzcw+KtwF6UpUbMld6fTJ8QyM4kvHJWkuKJ3wvFqJNrjHNONnhod76OEY/rE+YXI
         9P2ygmFlRYs97/6Nt+RRIn5z8rOYv9qtG4pGhSUrp7wTvKCXRWPu7CGs8qL7Zth7X74T
         xNkL6uHuhg3zlQoc4z8nzCf+/DEq+PGQj1E2LH2IQXSEiRfm2lOv7euPoc0dX6Wp4DQM
         dr+g==
X-Received: by 10.60.115.68 with SMTP id jm4mr3095306oeb.57.1398541540751;
        Sat, 26 Apr 2014 12:45:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id rt4sm24546911obb.12.2014.04.26.12.45.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Apr 2014 12:45:39 -0700 (PDT)
In-Reply-To: <27645ABF2E944872BB3F944B17E9490B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247179>

Philip Oakley wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> > are the bedstone of science.  You can make sensible decisions based on that
> > alone, and in fact that's how most good decisions are made.
> 
> At the moment we are missing the repeatable measurements,

Sure, that's part of science, but my point is that most decisions can be made
without those, simply on logic and evidence. If you really want to be certain
we can wait, but you know where my money is.

> I suspect your solution may become the lead candidate for @{p}, but as they
> say, "making predictions is hard, especially about the future".

Making predictions is not hard, it's making predictions that turn out to be
true :) And personally I don't find it that hard; you have to pick your battles
though, and this is an easy one.

-- 
Felipe Contreras
