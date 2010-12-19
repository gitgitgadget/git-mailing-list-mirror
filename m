From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] am: Allow passing exclude and include args to apply
Date: Sun, 19 Dec 2010 17:13:13 +0000
Message-ID: <20101219171313.GI17034@vostochny.stro.at>
References: <1292775461-26762-1-git-send-email-max@stro.at> <AANLkTik5-oJYsfEoeYjy8E9v4T4_7VBsoGnqg7oXwnbC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	klibc@zytor.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 18:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUMoz-0004Rv-Ez
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 18:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab0LSRNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 12:13:16 -0500
Received: from vostochny.stro.at ([78.47.22.85]:45568 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137Ab0LSRNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 12:13:15 -0500
Received: by vostochny.stro.at (Postfix, from userid 1000)
	id 0E8A4C05D; Sun, 19 Dec 2010 17:13:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTik5-oJYsfEoeYjy8E9v4T4_7VBsoGnqg7oXwnbC@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163961>

On Sun, Dec 19, 2010 at 02:56:58PM -0200, Thiago Farina wrote:
> On Sun, Dec 19, 2010 at 2:17 PM, maximilian attems <max@stro.at> wrote:
> > When porting patches from dash git to klibc git,
> > where dash has a different directory structure those
> > switches are handy:
> > Exported with format-patch on dash side and used am
> > as import for klibc side.
> >
> 
> I don't know, but this commit message doesn't look good. Can you be
> more specific about what the patch does, and what it's trying to fix.

hmm, it does what the subject says. (:
have you ever used `git am'?

> Describing a use case is good, but in this case it isn't help me much
> (maybe for others the issue here is clear, but for my taste no).

when one wants to promote a specific new feature, it is much better to
come up with it's use case, as burden is on Maintainer to keep it working.

Please be more specific on what's missing? Your personal taste is
unknown to me and not of importance.

thank you.

-- 
maks
