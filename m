From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: renaming question
Date: Sun, 19 Aug 2007 22:37:43 +0200
Message-ID: <87mywn8dm0.fsf@mid.deneb.enyo.de>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm>
	<87vebbo0f1.fsf@mid.deneb.enyo.de>
	<03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>
	<85sl6fqr9n.fsf@lola.goethe.zz>
	<03bd01c7e295$976a2970$0600a8c0@ze4427wm>
	<85odh3qp8j.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 22:37:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMrWx-0000hl-W1
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 22:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbXHSUhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 16:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbXHSUhq
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 16:37:46 -0400
Received: from mail.enyo.de ([212.9.189.167]:4139 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbXHSUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 16:37:45 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1IMrWq-0006lg-Dt
	for git@vger.kernel.org; Sun, 19 Aug 2007 22:37:44 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1IMrWp-0003uI-Dc
	for git@vger.kernel.org; Sun, 19 Aug 2007 22:37:43 +0200
In-Reply-To: <85odh3qp8j.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	19 Aug 2007 21:49:16 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56145>

* David Kastrup:

>> Could you elaborate maybe with a rough example for generating
>> patches.

> git-format-patch -M

Or, for more control about what gets put into patch, git-diff -M.
(As I wrote, most of the relevant commands accept an -M switch.)
