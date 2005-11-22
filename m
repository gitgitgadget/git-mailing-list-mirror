From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: Diffs "from" working directory
Date: Tue, 22 Nov 2005 00:15:30 -0500
Organization: Network Appliance, Inc.
Message-ID: <4382A972.1010801@citi.umich.edu>
References: <200511201817.15780.blaisorblade@yahoo.it>	 <20051120174359.GA24177@fieldses.org>	 <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>	 <20051120205855.GA30346@fieldses.org>	 <4381287F.5080402@citi.umich.edu> <b0943d9e0511211328j7c062c07s@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060809000303070406060907"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 06:18:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQVY-0005vX-9m
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVKVFPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKVFPf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:15:35 -0500
Received: from citi.umich.edu ([141.211.133.111]:64569 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932253AbVKVFPc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 00:15:32 -0500
Received: from [10.58.52.182] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 94DDE1BC27;
	Tue, 22 Nov 2005 00:15:31 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511211328j7c062c07s@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12523>

This is a multi-part message in MIME format.
--------------060809000303070406060907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
>>btw, catalin, this was bruce's patch.  i'm not sure why i was listed as
>>the author (probably a mistake of mine when i imported his patch into my
>>repository).  ah well.
> 
> 
> My import command sets the author to the e-mail sender, which was you.
> Maybe this should be changed but I don't know which option is better.
> In the meantime, you can change the default e-mail template to set the
> From: line with to the author of the patch and maybe add a Reply-to:
> with your address.

for some reason i was under the impression that it would parse the 
Signed-off-by: fields in the patch description, and take the first one 
as the patch author.

--------------060809000303070406060907
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


--------------060809000303070406060907--
