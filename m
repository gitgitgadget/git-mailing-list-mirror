From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: documentation issues
Date: Thu, 01 Dec 2005 17:06:21 -0500
Organization: Network Appliance, Inc.
Message-ID: <438F73DD.2000203@citi.umich.edu>
References: <438F5D05.4080101@citi.umich.edu> <7v64q8fqm8.fsf@assigned-by-dhcp.cox.net>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090800040201080304050605"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 23:08:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhwZO-0001DA-CJ
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 23:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVLAWGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 17:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVLAWGX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 17:06:23 -0500
Received: from citi.umich.edu ([141.211.133.111]:1034 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932514AbVLAWGW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 17:06:22 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id 0A5D81BACD;
	Thu,  1 Dec 2005 17:06:22 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64q8fqm8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13082>

This is a multi-part message in MIME format.
--------------090800040201080304050605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
>>also, git-diff-index supports a "-r" option, but that doesn't seem to be 
>>documented on this page.
> 
> 
> What Chris Shoemaker said is right.
> 
> But we could do this instead if you want.  I am neutral myself.

thanks for clarifying.

StGIT does use "git-diff-index -r" in git.__tree_status().  i think it 
can be safely removed.

--------------090800040201080304050605
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------090800040201080304050605--
