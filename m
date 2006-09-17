From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Add [-s|--hash] option to Linus' show-ref.
Date: Sun, 17 Sep 2006 13:32:01 +0200
Message-ID: <200609171332.01123.chriscool@tuxfamily.org>
References: <20060917062024.c476e07d.chriscool@tuxfamily.org> <eeiskc$l5n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 13:26:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOums-0003In-6G
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 13:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWIQL0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 07:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWIQL0E
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 07:26:04 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:25228 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964944AbWIQL0C (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 07:26:02 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 1BA1354828;
	Sun, 17 Sep 2006 13:26:01 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.4
In-Reply-To: <eeiskc$l5n$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27186>

Jakub Narebski wrote:
> Christian Couder wrote:
> > With this option only the sha1 hash of the ref should
> > be printed.
>
> Could you please update manpage as well?

It seems to me that there is no man page for git-show-ref in next right now.

I could add one but I may not describe some part of it correctly.

Christian.
