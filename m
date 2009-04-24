From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Manual pages (from archive): no hyphenation
Date: Fri, 24 Apr 2009 13:36:42 +0200
Message-ID: <49F1A44A.1080008@drmicha.warpmail.net>
References: <49F1BD06.32347.5FA078F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxJjf-0005Cx-1w
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 13:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZDXLgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 07:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbZDXLgx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 07:36:53 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49238 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751750AbZDXLgx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 07:36:53 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 45CBB31F419;
	Fri, 24 Apr 2009 07:36:52 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 24 Apr 2009 07:36:52 -0400
X-Sasl-enc: oTmCXg9/GjvLrBaIqv3F8LZprXOlNIkOrFgw70Ztm6tE 1240573011
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 35A3D4DF5C;
	Fri, 24 Apr 2009 07:36:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49F1BD06.32347.5FA078F@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117426>

Ulrich Windl venit, vidit, dixit 24.04.2009 13:22:
> Hello!
> 
> When using the manual pages that are shipped as archive, I noticed that some of 
> them look a bit ugly, mostly because of the lack of hyphenation. If that wasn't 
> intentional, could the proper commandy be added to the manual pages?

Do you mean line wrap by any chance ("Zeilenumbruch")? None of the
manual pages use hyphenation ("Silbentrennung").

> 
> Also I've noticed that a signle quote is displayed (on my UTF-8 system) as "Z with 
> an inverted roof" (i.e. a 'Z' with a vertically mirrored circumflex on top). That 
> slooks somewhat strange.

Which "archive" do you use? Where do you see the quote (if your system
displays a cech z)?

> 
> Furthermose  In oticed that there is no manual page for git-status in the archive.

Which...

Michael
