From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Wed, 18 Jul 2007 10:50:15 +0200
Message-ID: <20070718085015.GK25037@cip.informatik.uni-erlangen.de>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de> <7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net> <20070717101527.GB7774@cip.informatik.uni-erlangen.de> <7vlkdeang0.fsf@assigned-by-dhcp.cox.net> <20070717202754.GB25037@cip.informatik.uni-erlangen.de> <469DC037.A7D69826@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 10:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB5Ej-0000F3-44
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 10:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbXGRIuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 04:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbXGRIuS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 04:50:18 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49186 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446AbXGRIuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 04:50:16 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 76A923F430; Wed, 18 Jul 2007 10:50:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <469DC037.A7D69826@eudaptics.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52843>

Hello,

> >                 alias elinks='echo DO *NOT* RUN ELINKS AS ROOT'

> And if you have a file NOTES in $pwd, it will tell you:
> DO NOTES RUN GIT AS ROOT

fixed.

	Thomas
