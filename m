From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 15:28:44 -0600
Message-ID: <20140214212844.GE743@foghorn.codeweavers.com>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
 <20140214194436.GB743@foghorn.codeweavers.com>
 <xmqq4n41ihgi.fsf@gitster.dls.corp.google.com>
 <20140214205038.GC743@foghorn.codeweavers.com>
 <xmqqr475h06n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Eikum <aeikum@codeweavers.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 22:29:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQJu-0002Ps-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbaBNV2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:28:47 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:33864 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbaBNV2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:28:46 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>)
	id 1WEQJR-0007qo-Hy; Fri, 14 Feb 2014 15:28:45 -0600
Content-Disposition: inline
In-Reply-To: <xmqqr475h06n.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242148>

On Fri, Feb 14, 2014 at 01:08:32PM -0800, Junio C Hamano wrote:
> Andrew Eikum <aeikum@codeweavers.com> writes:
> 
> > My worry is having "2." hang around for another decade or longer. I'd
> > rather see X.0.0 denote a major feature release (currently represented
> > as 1.X.0), with X.Y.0 for minor enhancements and X.Y.Z for bugfix.
> 
> We need three categories: (1) potentially incompatible, (2) feature,
> (3) fixes-only.  We have been doing two levels of features by having
> both second and third numbers and we are flattening by removing the
> second one.
> 
> > It seems reasonable to expect fewer backwards incompatible changes in
> > the future as Git has become more mature. This reduces the utility of
> > reserving X.0.0 for major backwards incompatible changes, especially
> > considering it's already been eight years for the first increment.
> 
> We are not done yet, far from it.  If we can stay at 2.X longer,
> that is a very good thing.
> 

Okay, fair enough. Thanks for explaining :)

Andrew
