From: Chuck Lever <cel@citi.umich.edu>
Subject: documentation issues
Date: Thu, 01 Dec 2005 15:28:53 -0500
Organization: Network Appliance, Inc.
Message-ID: <438F5D05.4080101@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020809030503060200070307"
X-From: git-owner@vger.kernel.org Thu Dec 01 21:31:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehv35-0002nI-0o
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 21:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVLAU2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 15:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVLAU2z
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 15:28:55 -0500
Received: from citi.umich.edu ([141.211.133.111]:31327 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932447AbVLAU2y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 15:28:54 -0500
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by citi.umich.edu (Postfix) with ESMTP id 15CF11BB85
	for <git@vger.kernel.org>; Thu,  1 Dec 2005 15:28:54 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13069>

This is a multi-part message in MIME format.
--------------020809030503060200070307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

i'd fix these myself, but i don't know what the right answers are.

in the man page for git-diff-index (posted here):

   http://www.kernel.org/pub/software/scm/git/docs/git-diff-tree.html

there are several references to "git-diff-tree" where it seems like 
"git-diff-index" is really meant.

also, git-diff-index supports a "-r" option, but that doesn't seem to be 
documented on this page.

--------------020809030503060200070307
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


--------------020809030503060200070307--
