From: Angus Hammond <angusgh@gmail.com>
Subject: Re: [PATCH 2/2] Remove diagnostics section from commit-tree and var
 man pages New error messages shouldn't need explaining like the old ones did
 so just delete the diagnostics section of the man pages. Signed-off-by: Angus
 Hammond <angusgh@gmail.com>
Date: Thu, 10 May 2012 20:21:01 +0100
Message-ID: <CAOBOgRb3d+oLLLYk6yU5-JUYXKth+UKguJ7gc-SX6wUcb5z1Fw@mail.gmail.com>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
	<1336676770-17965-2-git-send-email-angusgh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Angus Hammond <angusgh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 21:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYvd-0001fh-12
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761149Ab2EJTVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 15:21:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40340 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760998Ab2EJTVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:21:02 -0400
Received: by lbbgm6 with SMTP id gm6so1348140lbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zw8IZz/Oej81ONBI2lys0r5AY+mFb71dGqZTpkNEdg4=;
        b=rgdJtxLF6y9YsaZQUQehZCJ9jDfRsBfc04eT43myYtAFEOuOMPj7uTt0D91d6hqUZ6
         JOgeOC5rDqD1Amjy2qqB95LeuN6fftnMC/Pj5Vy1i/DRsv2fjyQ0+8qho3P/qli1xYhz
         fhZLBddl1at1CfmM+x2LS2Ad2glFimBEsqtZnzJzrmI79uE1QjT4hbVKPiM4HZ9mLa4B
         LJdTd1xAqTNFHf8XvKPvMY0KZ1s2VvLwepN9y0zD2wvRL6NpreUNw6ONq928gBrcZNUI
         jsjOpYKhJsM80lDUI9cgPCxElLC5jIlmP4MoN0QHVmlU0DzZPr/NcGs4FbVJaHWG98H9
         By4w==
Received: by 10.112.48.195 with SMTP id o3mr2322264lbn.88.1336677661353; Thu,
 10 May 2012 12:21:01 -0700 (PDT)
Received: by 10.114.5.169 with HTTP; Thu, 10 May 2012 12:21:01 -0700 (PDT)
In-Reply-To: <1336676770-17965-2-git-send-email-angusgh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197619>

I have no idea how I managed to send this to myself and see it as one,
properly formatted email despite it being 2 formatted diabolically with
entire commits messages in the subjects. Sorry about that.
These were meant to offer an alternative solution to the current issue over
unusual error messages from commit-tree by bypassing the whole unix humour
issue. They look it'll still be possible to apply them even if they are
badly sent. If not and people think they're worth while I'd be happy (try
and) send them again without this mess.
Thanks
Angus
