From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: Yet another Git tutorial
Date: Thu, 01 May 2008 00:17:20 +0100
Message-ID: <4818FE00.1080209@manchester.ac.uk>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com> <1c5969370804281825m378b8714q809f13eb6192623@mail.gmail.com> <DCF8F30E-5D82-4AE8-BFE1-25065BC3517A@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Thu May 01 01:37:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrLrc-0003om-Tq
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 01:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbYD3Xgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbYD3Xgj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 19:36:39 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:42685 "HELO
	smtp1.betherenow.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756049AbYD3Xgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 19:36:38 -0400
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2008 19:36:28 EDT
Received: from [192.168.1.1] (87-194-245-197.bethere.co.uk [87.194.245.197])
	by smtp1.betherenow.co.uk (Postfix) with ESMTP id 1069A98062;
	Thu,  1 May 2008 00:17:18 +0100 (BST)
User-Agent: Thunderbird 1.5.0.14ubu (X11/20080306)
In-Reply-To: <DCF8F30E-5D82-4AE8-BFE1-25065BC3517A@newartisans.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80879>

John Wiegley wrote:
> I've applied nearly everyone's corrections and uploaded the new version 
> of the PDF.  Thanks again to everyone for such conscientious reading!
> 
>   http://www.newartisans.com/blog_files/git.from.bottom.up.php

Very good tutorial. I'm working through it to fill in gaps in my git 
knowledge (of which there are many - stash for instance, very cool).

On page 5 your second git cat-file example is incorrect I think. It 
should be:
$ git cat-file blob af5626b

i.e. you're missing the "blob" bit!

Cheers,
Rob
