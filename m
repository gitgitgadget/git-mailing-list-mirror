From: "Scott Chacon" <schacon@gmail.com>
Subject: git-scm.com
Date: Fri, 25 Jul 2008 10:35:43 -0700
Message-ID: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMRDi-000635-47
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbYGYRfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbYGYRfp
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:35:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:49655 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYGYRfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:35:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3517832rvb.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=nE8Ks+lIfiA7g3/0krnlrVHRNAAJ0s3y5R4ED3WUmOM=;
        b=NciVCnaT3gDnngs4W+Pa4n5HFEXFaAFfLcHhgEb/vNji74HwJU+slh3KmY2BW08rrv
         KezXjW4oQ0s6T6T9fFGBuFbBiJ0NZGZUFgaAgLVOn9KdXla1T+lhCHK+v60sISfeiJxN
         L+8kMbyVWbS1KOlgkb9hV5YuggDAAI0BN4B2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=clD9bCGJqSIOSOrngkJ25BNOM3+rGhz+GkPJp0sEXrACCwP4f+v8Ev3iRMSArG6WaT
         9G2XAwPgkDppK0+U7P8FHjP74zLKat1i9haFGzK6s08g2f0Ang2o29Wtmrvd5P24qhnG
         FTll3/DPpX088sMxc+TVMyj+32Cx9omvdg0ro=
Received: by 10.114.153.18 with SMTP id a18mr2288412wae.161.1217007343160;
        Fri, 25 Jul 2008 10:35:43 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 10:35:43 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90079>

Hey all,

A followup on the post I did a few days ago about Git documentation.
I forked Petr's git.or.cz site and put up a version that I think is a
bit more accessible and newbie-friendly at git-scm.com.  I had meant
to discuss this with Petr before posting it to you all, but I
published a blog post that got a bit more attention than I expected,
and I didn't want you all to think I didn't care about your opinion,
as some have already accused me of.

Anyhow, I'm discussing with Petr about where we want to go from here -
what changes he'd like to make, etc, but I obviously value your
opinion as well, so please let me know what you think.  The content
has barely changed, it's really just a usability overhaul.  I want to
make sure that whatever someone is looking for (especially someone
new), they can find in a few clicks and a few seconds.

Next, I will be working on the larger end-user documentation project,
which will linked to from the documentation page of this site, and
probably the main page too.  I'll keep this list updated as I go,
since people tend to think I don't care about the community when I try
not to waste your time. :)

Scott
