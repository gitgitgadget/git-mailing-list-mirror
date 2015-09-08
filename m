From: David A Cobb <superbiskit@cox.net>
Subject: Subdividing an existing Repository
Date: Mon, 7 Sep 2015 20:29:07 -0400
Message-ID: <55EE2BD3.1060300@cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080603030601040703070103"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 08 02:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ6mh-0002fl-Hu
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 02:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbIHA3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 20:29:11 -0400
Received: from eastrmfepo101.cox.net ([68.230.241.213]:45424 "EHLO
	eastrmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbIHA3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 20:29:09 -0400
Received: from eastrmimpo209 ([68.230.241.224]) by eastrmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20150908002908.YGAP17881.eastrmfepo101.cox.net@eastrmimpo209>
          for <git@vger.kernel.org>; Mon, 7 Sep 2015 20:29:08 -0400
Received: from [68.0.254.104] ([68.0.254.104])
	by eastrmimpo209 with cox
	id EQV71r00P2Fuz4c01QV8pf; Mon, 07 Sep 2015 20:29:08 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020203.55EE2BD4.004E,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=VIYDaazX c=1 sm=1
 a=E2TABC3fJca0I99Ic2bSGA==:17 a=kviXuzpPAAAA:8 a=hyqrqeEBUiV__V2nmykA:9
 a=QEXdDO2ut3YA:10 a=1XDyeEBUjsJ4qNLrmT0A:9 a=02YEsJ6dRIUA:10
 a=bUBOKfpOkEEA:10 a=c_6gVQAqz3wA:10 a=E2TABC3fJca0I99Ic2bSGA==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (CRAM-MD5)
 smtp.auth=superbiskit@cox.net
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:43.0) Gecko/20100101
 Thunderbird/43.0a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277480>

This is a multi-part message in MIME format.
--------------080603030601040703070103
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Several Repositories I'm interested in, e.g. MINGW-PACKAGES@GITHUB, 
contain multiple "products."  Usually, I'm only interested in one or two.
I want to have a local repo with, e.g. iodbc from MinGW-Packages as 
sub-moules.  I don't even need to keep local content for many of the 
other included products.  But, I need to keep synchronized with the 
upstream, so I don't want to destroy the meta-data that allows me to do 
that.

It's not certain at this point that I will ever be invited to push what 
I have done up the food chain.  Maybe it will always be a private fork.

I've looked at Subtrees and Submodules in the ProGit book.  I can see 
how to use an existing submodule, but not how to isolate one out of a 
larger body of code.

TIA

--------------080603030601040703070103
Content-Type: text/x-vcard; charset=utf-8;
 name="superbiskit.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="superbiskit.vcf"

begin:vcard
fn:David A Cobb
n:Cobb;David A
email;internet:superbiskit@cox.net
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------080603030601040703070103--
