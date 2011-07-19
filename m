From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: newbie - missing file from untracked list
Date: Tue, 19 Jul 2011 20:51:24 +0200
Message-ID: <1311101484.18226.129.camel@oxylap>
References: <1311040156386-6597192.post@n2.nabble.com>
	 <4E24F275.3030906@gmail.com>  <1311095242970-6599506.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: govinda <govinda.webdnatalk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 20:51:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjFOI-0001na-5h
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 20:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1GSSv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 14:51:28 -0400
Received: from vserver.localhost.li ([85.214.46.152]:40784 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab1GSSv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 14:51:28 -0400
Received: from p5794cdfc.dip.t-dialin.net ([87.148.205.252]:43496 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QjFOA-0007ot-54; Tue, 19 Jul 2011 20:51:26 +0200
In-Reply-To: <1311095242970-6599506.post@n2.nabble.com>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177492>

On Di, 2011-07-19 at 10:07 -0700, govinda wrote:
> see, why is there what seems to be 2 consecutive alphabetical lists of file
> names? 
> The first one spans the files:
> ?? CSS/
> .
> .
> .
> ?? WelcometoNewVL.html
> 
> 
> ...while the second list spans the files:
> ?? _SS_Govinda_only.php
> .
> .
> .
> ?? upload_CORRECT.html
Well, this is actually just one sorted list. However, sorting is
case-sensitive.  When you look at the order of characters in the ASCII
table, capital letters come before the characters [ \ ] ^ _ `. Then the
small letters follow.

Bye,
 Chris
