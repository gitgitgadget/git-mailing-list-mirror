From: Jeff Carr <jcarr@linuxmachines.com>
Subject: Re: kernel.org git web interface
Date: Fri, 12 Aug 2005 11:08:32 -0700
Message-ID: <42FCE5A0.4060706@linuxmachines.com>
References: <05BEHQE11@briare1.heliogroup.fr> <20050810162329.GA8574@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Hubert Tonneau <hubert.tonneau@fullpliant.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 20:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3dvy-0002lS-Lc
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 20:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVHLSGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 14:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVHLSGz
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 14:06:55 -0400
Received: from [64.71.148.162] ([64.71.148.162]:21206 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1750721AbVHLSGy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 14:06:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id C70B36EF4D;
	Fri, 12 Aug 2005 11:08:32 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04091-10; Fri, 12 Aug 2005 11:08:32 -0700 (PDT)
Received: from [192.168.36.10] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id 002476E4AB;
	Fri, 12 Aug 2005 11:08:31 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050810162329.GA8574@mars.ravnborg.org>
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> On Wed, Aug 10, 2005 at 03:59:02PM +0000, Hubert Tonneau wrote:
> 
>>The 'V' column on http://www.kernel.org/ is very convienient to review what
>>has changed in a new kernel (files list, then simple clic diff access to the
>>selected file).
>>
>>Now, the git changelog is also interesting (provides overall explaination),
>>but it's harder to use because the changes stream is so dense.
>>
>>So, what would be helpfull for reviewers is the ability to view the git
>>changelog of only the changes that touch a given file.
>>I mean when we select the 'V' column, have two links per modified file,
>>one displaying the diff has it currently does, and the other displaying
>>the git changes as 'C' column does, but filtered with only changes that
>>touch the selected file.

That would be useful. Maybe someone really ambitious would figure out a
way to use imagemagick to generate visual tiles that could be feed into
the google maps API. Then we could "fly" around the sources too.

Jeff
http://mapki.com/index.php?title=Add_Your_Own_Custom_Map
