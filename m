From: der Mouse <mouse@Rodents-Montreal.ORG>
Subject: Re: Errors in man git
Date: Wed, 8 Sep 2010 18:09:02 -0400 (EDT)
Message-ID: <201009082209.SAA08134@Sparkle.Rodents-Montreal.ORG>
References: <BLU0-SMTP666507C6D3E37A50B92431BB720@phx.gbl>
	<20100908233140.7d5df3ee@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 00:09:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtSpL-0007LJ-6N
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 00:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab0IHWJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 18:09:06 -0400
Received: from Sparkle.Rodents-Montreal.ORG ([216.46.5.7]:57028 "EHLO
	Sparkle.Rodents-Montreal.ORG" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756167Ab0IHWJF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 18:09:05 -0400
Received: (from mouse@localhost)
	by Sparkle.Rodents-Montreal.ORG (8.8.8/8.8.8) id SAA08134;
	Wed, 8 Sep 2010 18:09:02 -0400 (EDT)
X-Erik-Conspiracy: There is no Conspiracy - and if there were I wouldn't be part of it anyway.
X-Message-Flag: Microsoft: the company who gave us the botnet zombies.
X-Composition-Start-Date: Wed, 8 Sep 2010 18:07:24 -0400 (EDT)
In-Reply-To: <20100908233140.7d5df3ee@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155816>

> |   Main porcelain commands
> |       git-add(1)
> |           Add file contents to the index.

> Here, "git-add(1)" is written in one word because otherwise it's not
> a valid reference to another manpage.

That's always bothered me; I'd prefer to something more like

    Main porcelain commands
        git add (see git-add(1))
            Add file contents to the index.

/~\ The ASCII				  Mouse
\ / Ribbon Campaign
 X  Against HTML		mouse@rodents-montreal.org
/ \ Email!	     7D C8 61 52 5D E7 2D 39  4E F1 31 3E E8 B3 27 4B
