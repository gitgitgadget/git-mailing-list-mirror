From: Sam Vilain <sam@vilain.net>
Subject: Re: Fixing author/email fields in commit messages
Date: Mon, 20 Feb 2006 10:24:23 +1300
Message-ID: <43F8E207.9020306@vilain.net>
References: <43F8BCB1.2010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 22:24:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAw2l-0008PN-LH
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 22:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWBSVYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 16:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWBSVYd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 16:24:33 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:55714 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932252AbWBSVYc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2006 16:24:32 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 2D7C152F9; Mon, 20 Feb 2006 10:24:31 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id BAA71B47;
	Mon, 20 Feb 2006 10:24:24 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <43F8BCB1.2010701@gmail.com>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16452>

Jacob Kroon wrote:
> When I started my git repository for my project, I never setup 
> GIT_AUTHOR_NAME etc. correctly,
> so my commit messages used the default information, 
> "<jacob@skeletor.(none)>", "skeletor" being the
> hostname of the computer I'm working on. I'd like to change it so that 
> the messages will contain correct
> information about my e-mail and username. I noticed that this question 
> has been brought up here before
> and that the solution might be to use git-convert-objects, but that it 
> might need some modifications.
> 
> Has anyone come up with a working tool for this task ?

Perhaps "stg uncommit"

Sam.
