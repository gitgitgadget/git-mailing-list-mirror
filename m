From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout	or
 merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 15:23:35 -0700
Message-ID: <1209594215.25663.864.camel@work.sfbay.sun.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 00:20:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrKef-0007VR-0U
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 00:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761362AbYD3WTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760165AbYD3WTL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 18:19:11 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:58201 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759443AbYD3WTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 18:19:10 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3UMJ9cr008649
	for <git@vger.kernel.org>; Wed, 30 Apr 2008 15:19:09 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K0500G01SK11C00@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Wed, 30 Apr 2008 15:19:09 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0K0500C3ESNWX820@fe-sfbay-10.sun.com>; Wed,
 30 Apr 2008 15:19:08 -0700 (PDT)
In-reply-to: <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80876>

On Wed, 2008-04-30 at 17:48 -0400, Avery Pennarun wrote:
> It would be awesome if you could turn the fancy behaviour of this
> bundle into patches to git-submodule, for example, and then have your
> textmate macros call the modified git-submodule.  It might be a bit of
> an uphill battle to get the patches accepted into the release, but I
> think it's worth the effort, as git-submodule in its current state is
> just a non-starter for my group at least.

Doesn't the fact that the workflows around submodules tend to differ so
much call for different incarnations of git-submodule? IOW, wouldn't
it be ok to have an alternative to git-submodule somewhere in contrib?

Thanks,
Roman.
