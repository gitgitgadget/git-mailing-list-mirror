From: ib@wupperonline.de (Ingo Brueckl)
Subject: question concerning branches
Date: Wed, 19 Aug 2009 21:45:00 +0200
Message-ID: <4a8c51f5@wupperonline.de>
References: <m33a7noc3u.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdr7W-0002Br-Ho
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbZHSTqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZHSTqq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:46:46 -0400
Received: from smtp.tal.de ([81.92.1.5]:35579 "EHLO smtp.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbZHSTqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:46:45 -0400
Received: from ib (i528C3684.versanet.de [82.140.54.132])
	by smtp.tal.de (Postfix) with SMTP id 61D3FAC2718;
	Wed, 19 Aug 2009 21:46:46 +0200 (CEST)
X-Mailer: blueMail 1.4 (SlipDoor 2.2)
In-Reply-To: <m33a7noc3u.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126577>

Jakub Narebski <jnareb@gmail.com> writes:

> You finish old work (or stash it away), _then_ you begin new work.

Ok, this helps me a little bit to understand.

The branches aren't designed to split my work, but rather something to
collect the different parts of my work.

But as software development often is something where you are coding on
several issues at the same time which can't be committed immediately, it
sounds that 'stash' is the developer's best friend.

Ingo
