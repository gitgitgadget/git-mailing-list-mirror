From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: complete more options for 'git rebase'
Date: Tue, 27 Oct 2009 17:32:08 -0700
Message-ID: <20091028003208.GO10505@spearce.org>
References: <4AD98F72.1060901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bj??rn Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 01:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2wSY-0005wV-RA
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 01:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbZJ1AcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 20:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbZJ1AcF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 20:32:05 -0400
Received: from george.spearce.org ([209.20.77.23]:60103 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951AbZJ1AcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 20:32:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DBD54381D3; Wed, 28 Oct 2009 00:32:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4AD98F72.1060901@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131396>

Bj??rn Gustavsson <bgustavsson@gmail.com> wrote:
> Complete all long options for 'git rebase' except --no-verify
> (probably used very seldom) and the long options corresponding
> to -v, -q, and -f.
> 
> Signed-off-by: Bj??rn Gustavsson <bgustavsson@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> I am primarily interested in having the --whitespace= option completed,
> but while at it I have added completion for the other potentially useful
> long options.

Indeed, this would be nice.  :-)
 
-- 
Shawn.
