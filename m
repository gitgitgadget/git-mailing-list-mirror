From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: Diffs "from" working directory
Date: Sun, 20 Nov 2005 20:53:03 -0500
Organization: Network Appliance, Inc.
Message-ID: <4381287F.5080402@citi.umich.edu>
References: <200511201817.15780.blaisorblade@yahoo.it> <20051120174359.GA24177@fieldses.org> <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org> <20051120205855.GA30346@fieldses.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080503030902090001040809"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Blaisorblade <blaisorblade@yahoo.it>,
	Chuck Lever <cel@netapp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 02:53:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee0rs-00080z-2t
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 02:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKUBxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 20:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbVKUBxN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 20:53:13 -0500
Received: from citi.umich.edu ([141.211.133.111]:25385 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932154AbVKUBxM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 20:53:12 -0500
Received: from [10.58.52.63] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 93F961BBDB;
	Sun, 20 Nov 2005 20:53:04 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20051120205855.GA30346@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12416>

This is a multi-part message in MIME format.
--------------080503030902090001040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

J. Bruce Fields wrote:
> On Sun, Nov 20, 2005 at 10:13:32AM -0800, Linus Torvalds wrote:
> 
>>On Sun, 20 Nov 2005, J. Bruce Fields wrote:
>>
>>>That's a diff *to* the working directory.  My complaint was that there
>>>wasn't a convenient way to get a diff *from* the working directory.
>>
>>Something like
>>
>>	git diff -R -M -p
>>
>>should do it, no?
> 
> 
> A "-R" option to "stg diff" would be convenient, sure.--b.

that might be an even more intuitive way to dig out what is wanted.

btw, catalin, this was bruce's patch.  i'm not sure why i was listed as 
the author (probably a mistake of mine when i imported his patch into my 
repository).  ah well.

--------------080503030902090001040809
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------080503030902090001040809--
