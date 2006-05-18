From: Yann Dirson <ydirson@altern.org>
Subject: tailor (Was: gateway status?)
Date: Fri, 19 May 2006 00:07:59 +0200
Message-ID: <20060518220759.GA6535@nowhere.earth>
References: <Pine.LNX.4.62.0605151122500.29452@qynat.qvtvafvgr.pbz> <46a038f90605160609u19a356ccx9467c32100731b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <dlang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 23:56:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgqTi-00062W-Pc
	for gcvg-git@gmane.org; Thu, 18 May 2006 23:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWERV4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWERV4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 17:56:16 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:15074 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932157AbWERV4P (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 17:56:15 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id A3EC32260D;
	Thu, 18 May 2006 23:56:14 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fgqf1-0002dj-R2; Fri, 19 May 2006 00:07:59 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90605160609u19a356ccx9467c32100731b9@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20306>

On Wed, May 17, 2006 at 01:09:19AM +1200, Martin Langhoff wrote:
> On 5/16/06, David Lang <dlang@digitalinsight.com> wrote:
> >I seem to remember seeing discussion of gateways to cvs/svn that would let
> >a project use a git repository and allow clients to use cvs/svn clients to
> >retreive data.
> 
> I suspect you might be thinking of git-cvsserver. The code has no
> known bugs, but is has only seen limited use by in-house dev teams.

Another tool that I don't see mentionned often here is tailor, which
has the ability to act as a gatway between git and a good selection of
other SCMs, including cvs and svn.  I have not yet tried it with git
though, so any comments from people having shaked it a bit would be
useful :)

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
