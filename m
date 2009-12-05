From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv3 0/3] git-gui: more robust handling of fancy repos
Date: Sat, 5 Dec 2009 14:15:15 -0800
Message-ID: <20091205221515.GH5610@spearce.org>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 23:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH2uT-0001wD-DL
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 23:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbZLEWPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 17:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbZLEWPN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 17:15:13 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:46719 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302AbZLEWPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 17:15:12 -0500
Received: by iwn1 with SMTP id 1so2324216iwn.33
        for <git@vger.kernel.org>; Sat, 05 Dec 2009 14:15:19 -0800 (PST)
Received: by 10.231.157.83 with SMTP id a19mr354838ibx.41.1260051318996;
        Sat, 05 Dec 2009 14:15:18 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm2223474iwn.3.2009.12.05.14.15.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Dec 2009 14:15:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134628>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> As promised a long time ago (March 30), version 3 of the small patchset
> to improve handling of repositories in git gui. The most significant
> change is the addition of the third patch.
...
> Giuseppe Bilotta (3):
>   git-gui: handle non-standard worktree locations
>   git-gui: handle bare repos correctly
>   git-gui: work from the .git dir
> 
>  git-gui/git-gui.sh |   88 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 73 insertions(+), 15 deletions(-)

Unfortunately this series doesn't apply to my tree, and I don't
have the blobs which are recorded in the index line, so I can't
easily 3-way merge it onto the current tip.

Would you be able to rebase it?

-- 
Shawn.
