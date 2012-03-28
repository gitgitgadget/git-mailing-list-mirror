From: Shivam Handa <Shivamhanda@gmail.com>
Subject: Gsoc 2012 idea -> a list based user interface for git
Date: Wed, 28 Mar 2012 14:59:48 +0000 (UTC)
Message-ID: <loom.20120328T163151-920@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 17:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCuQz-0002BD-Va
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab2C1PFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 11:05:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:42095 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab2C1PFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 11:05:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SCuQr-00025K-3c
	for git@vger.kernel.org; Wed, 28 Mar 2012 17:05:05 +0200
Received: from 180.149.52.42 ([180.149.52.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 17:05:05 +0200
Received: from Shivamhanda by 180.149.52.42 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 17:05:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 180.149.52.42 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.83 Safari/535.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194126>

Hi, 

I am second year student at IIT delhi.

sorry for the delay (had a few exams).
I am participating for Gsoc 2012 and I have an idea for the git community.

I personally feel that versioning is a technology which is useful in general 
work space and not only large projects. 

but currently it is restricted to the use of programs,

My idea is to create a Groupware based on git, 

The key features of the groupware (could be) ->

. list based interface ( gmail style) . tagging of files without creating there 
copies( for example a particular file can be common within two of your works , 
and  copies would only be required if one of them is changing.
Sym links would be interesting


. compiling and file management can be done from within the interface.
. You can run python scripts on a list of files

. branches can be just another list and branching would be just adding files to 
a new list from other list .

. currenlty git allows all files to be downloaded but in large projects some 
files are not open, you dont have the permission to access there code, hence 
these file can be kept encrypted and at the time of compilation the util will 
decode a temp copy of the file for use.

This is a small idea, and I would be glad to hear from all of the memebers about 
it.

Shivam Handa
shivamhanda@gmail.com
