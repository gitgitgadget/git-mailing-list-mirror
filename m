From: =?ISO-8859-1?Q?Dani=EBl_Gressmann?= <daniel@procura.nl>
Subject: Re: [RFD] How to better document the "two and three dots" format
Date: Mon, 01 Sep 2008 15:01:42 +0200
Message-ID: <48BBE7B6.9070709@procura.nl>
References: <4d8e3fd30809010543o1e1562c1s4466e191e782ddcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 15:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka9DQ-0001ms-IJ
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 15:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbYIANL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYIANL5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 09:11:57 -0400
Received: from procura.xs4all.nl ([82.95.216.29]:60330 "EHLO procura.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYIANL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 09:11:56 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Sep 2008 09:11:56 EDT
Received: from 127.0.0.1 (AVG SMTP 8.0.169 [270.6.14/1644]); Mon, 01 Sep 2008 15:01:48 +0200
Received: from [192.0.1.22] (pc12.procura.nl [192.0.1.22])
          by procura.nl with ESMTP (Mailtraq/2.12.1.2362) id PRCR892F6008;
          Mon, 01 Sep 2008 15:01:39 +0200
Received: from 127.0.0.1 (AVG SMTP 8.0.169 [270.6.14/1645]); Mon, 01 Sep 2008 15:01:42 +0200
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <4d8e3fd30809010543o1e1562c1s4466e191e782ddcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94583>

Paolo Ciarrocchi wrote:
> I think <3> should be changed in something like:
> <3> Changes between the tips of the topic and the master branch that
> occurred since when the topic
> branch was started off it.
I think it's a step in the proper direction. My take, as a newbie ;), at 
it would be more like:

<3> Changes between the current tip of the topic and the tip of master 
branch at the moment the topic branched off.

I think the ASCII art explains why I think that way.
> Can anybody come up with some ASCII art?
>   
ASCII art <1> or <2>:
--o--x
   \
    -x

ASCII art <3>:

--x---
   \
    -x

where the x marks the changes to be diffed

-- 
PROCURA B.V.

Tel: (072) 571 25 05
Fax: (072) 571 71 02

Email: daniel@procura.nl

PROCURA B.V. (statutair gevestigd in Heerhugowaard),
Handelsregister Kamer van Koophandel Noordwest-Holland: 37140650
 
