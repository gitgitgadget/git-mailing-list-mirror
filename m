From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Tue, 17 Feb 2009 11:53:52 -0700
Message-ID: <alpine.LNX.2.00.0902171152270.21161@suse104.zenez.com>
References: <20090217011256.GA23314@spearce.org>  <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>  <20090217151838.GI18525@spearce.org> <8c9a060902170813ie8f5bc1gfed53e4f31f64c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:04:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVFE-0002F1-JN
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbZBQTDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753269AbZBQTDH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:03:07 -0500
Received: from suse104.zenez.com ([198.60.105.164]:54673 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbZBQTDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:03:06 -0500
X-Greylist: delayed 552 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 14:03:05 EST
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id DE8C57B81CE; Tue, 17 Feb 2009 11:53:52 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id CEAAB93984A;
	Tue, 17 Feb 2009 11:53:52 -0700 (MST)
In-Reply-To: <8c9a060902170813ie8f5bc1gfed53e4f31f64c23@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110438>

On Tue, 17 Feb 2009, Jacob Helwig wrote:
> On Tue, Feb 17, 2009 at 07:18, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Gerrit is known to not work in Internet Explorer.  As an open source
>> developer, my primary desktop system runs Linux.  My portable laptops
>> all run Mac OS X, because its shiny.  I have no system capable of
>> running Internet Explorer, nor do I desire to send dollars towards
>> Redmond in order to obtain an OS license in order to do so.
>>
>> Something is busted in the IE AJAX code used by Gerrit Code Review.
>> I'm guessing that instead of making the data available to the AJAX
>> callback, IE wants to save it as a file on disk.  No clue why.
>> And due to the lack of IE, I am unable to debug the problem myself.
>> I am waiting for someone who really cares about using IE to debug
>> it and contribute the patch back.
>>
>
> I've found IEs4Linux helpful for debugging IE-only issues under Linux.
>
> http://www.tatanka.com.br/ies4linux/page/Main_Page
>
> I don't recall, off hand, if it'll provide IE 7 (and the site isn't
> working for me right now, so I can't confirm this).  It does provide
> IE 5.0, 5.5, and 6.0, however.

You can get IE 7 if you go to the advanced option and choose it.  They say 
it is experimental.  I find it works well for when I have to test IE.  I 
only test IE 6 and IE 7 to make sure web pages work in them as well.

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
