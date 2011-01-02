From: "J.H." <warthog9@kernel.org>
Subject: Re: Web browser and Git wiki (kernel.org) not getting along....
Date: Sat, 01 Jan 2011 23:58:23 -0800
Message-ID: <4D20301F.5050002@kernel.org>
References: <1293941768.30849.32.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Jan 02 08:59:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZIr5-0007iP-Bo
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 08:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab1ABH7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 02:59:20 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:47138 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab1ABH6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 02:58:54 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id p027wNd0016136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sat, 1 Jan 2011 23:58:23 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <1293941768.30849.32.camel@drew-northup.unet.maine.edu>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sat, 01 Jan 2011 23:58:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164411>

On 01/01/2011 08:16 PM, Drew Northup wrote:
> Are any other Opera users getting this error when attempting to go to
> https://git.wiki.kernel.org ?

Known bug in Opera, the problem lies in how it handles wild card
certificates.  It is claimed to be fixed in the next version by another
user who has pushed the issue with Opera.

> "Unable to complete secure transaction
> 
> You tried to access the address
> https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools,
> which is currently unavailable. Please make sure that the web address
> (URL) is correctly spelled and punctuated, then try reloading the page.
> 
> Secure connection: fatal error (112) from server.
> 
> https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools
> 
> Transmission failure.
> ....."
> 
> I'm trying to figure out of this is a pure Opera problem or just a
> RedHat problem (ugh). (I'm also pretty darn sure that the server is up,
> as it loads up just fine in Firefox.....)

Pure Opera, it works fine from every other browser.

> Unless lots of other people on the list are interested I don't see the
> point in splattering replies back to it until (unless?) something
> interesting comes up, so this may be a case when culling the CC list is
> ok...

- John 'Warthog9' Hawley
Chief Kernel.org Administrator
