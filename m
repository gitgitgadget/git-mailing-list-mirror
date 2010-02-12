From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: Re: git-svn: Cannot lock the ref 'refs/remotes/tags/autotag_for_.'.
Date: Fri, 12 Feb 2010 16:41:20 +0200
Organization: Xorcom*
Message-ID: <20100212144119.GS3599@xorcom.com>
References: <20100209213929.GL3599@xorcom.com> <be6fef0d1002110036g2b13616bud0aa7c1a0cbcdb1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 16:09:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfx9B-0003yO-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 16:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756870Ab0BLPJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 10:09:06 -0500
Received: from local.xorcom.com ([62.90.10.53]:37054 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218Ab0BLPJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 10:09:04 -0500
Received: by local.xorcom.com (Postfix, from userid 1000)
	id 1914CC55C48; Fri, 12 Feb 2010 16:41:20 +0200 (IST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <be6fef0d1002110036g2b13616bud0aa7c1a0cbcdb1e@mail.gmail.com>
X-Forced-Service: Sadly Using Gmail [tm]
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139713>

On Thu, Feb 11, 2010 at 04:36:51PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Wed, Feb 10, 2010 at 5:39 AM, Tzafrir Cohen <tzafrir.cohen@xorcom.com> wrote:
> > Is there a way for me to skip some tags? I can avoid that specific tag.
> 
> have you tried --ignore-paths?

Sorry for the late reply. I don't follow this list (please CC me
replies).

Yes, I tried. See my other response in this thread. No luck so far. I
guess the next thing to try would be to ignore all of those autotags
(even though they are somewhat useful).

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
