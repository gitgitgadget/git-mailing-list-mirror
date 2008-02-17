From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Feb 2008 16:48:36 +0100
Message-ID: <1203263316.6601.3.camel@futex>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
	 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
	 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
	 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 17:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQm1X-0002WH-NH
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 17:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515AbYBQQDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 11:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbYBQQDz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 11:03:55 -0500
Received: from mail20.bluewin.ch ([195.186.19.65]:46285 "EHLO
	mail20.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbYBQQDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 11:03:54 -0500
X-Greylist: delayed 877 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2008 11:03:53 EST
Received: from futex.feinheit.ch (85.0.173.202) by mail20.bluewin.ch (Bluewin 7.3.121)
        id 476BDF9700CB2F20; Sun, 17 Feb 2008 15:48:36 +0000
Received: (nullmailer pid 13533 invoked by uid 1000);
	Sun, 17 Feb 2008 15:48:36 -0000
In-Reply-To: <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.21.90 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74137>

On Sat, 2008-02-16 at 19:59 -0800, Junio C Hamano wrote:
> [...]

What about color.ui? I am still interested in a single central
configuration variable to enable colored output from git. I know that I
sent a proposal patch at a bad time.

Here is the last patch I sent to the list:

http://permalink.gmane.org/gmane.comp.version-control.git/70055
