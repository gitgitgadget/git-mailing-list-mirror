From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4: problem with commit 97a21ca50ef8
Date: Thu, 3 Nov 2011 11:04:06 +0000
Message-ID: <CAOpHH-W1JO9PLsyp2hQxfr6eyKRr+=pMkaDikV5NcFwF98Miow@mail.gmail.com>
References: <CAOk9v+-==GwDQaZ=4BW1QfEF7+5SfhNF409Xom0bHdT_qKaiFA@mail.gmail.com>
 <20111101020841.GA8116@arf.padd.com> <CAOk9v+_xXRGAGWg2L5u=r9qBS=H+ZmdF=TwumSyq7WKf-15okw@mail.gmail.com>
 <loom.20111102T153631-769@post.gmane.org> <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 12:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLv6C-0004w5-JC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 12:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab1KCLEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 07:04:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab1KCLEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 07:04:38 -0400
Received: by faao14 with SMTP id o14so1370940faa.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6F1R/ctaC4AVhPeA9uuRYVy3BfrII6SYeIdJ02hnoEA=;
        b=p0SAq87WPFZUKuD30c5fLXhODKdQE6cnffuoO4AAq6eXgzNUd9ocxI1gvZDs6ewDnx
         YnyrNLMNvqkbVhkvgUJ3z8SRMZAjnT8wrtCl1dngf3nrqYmtHVioxSjS17Xz5qunz4y8
         hvb6UqyzguONG9a5/4CECrhglO8LN6tYjX6zk=
Received: by 10.223.94.143 with SMTP id z15mr11475619fam.32.1320318277329;
 Thu, 03 Nov 2011 04:04:37 -0700 (PDT)
Received: by 10.152.37.101 with HTTP; Thu, 3 Nov 2011 04:04:06 -0700 (PDT)
In-Reply-To: <CAOk9v+_xaS_Y1m17TROOSjgiscT+QEJWbpZbAZFmh8_tAviF6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184713>

Hi Michael,

On Wed, Nov 2, 2011 at 10:42 PM, Michael Wookey <michaelwookey@gmail.com> wrote:
> I tried your suggested version of git-p4 (at rev 630fb678c46c) and
> unfortunately, the perforce repository fails to import. Firstly, there
> was a problem with importing UTF-16 encoded files, secondly the
> "apple" filetype files are still skipped.

I had no intention of directing you to try that version. Sorry for
misleading you on this.

I just found it interesting that P4's KB contains an article that
directs users to another version which isn't this one.

-- 
Vitor Antunes
