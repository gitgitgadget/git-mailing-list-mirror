From: "Draggs, Tori" <Tori.Draggs@Mercy.Net>
Subject: GIT Question
Date: Wed, 20 Jan 2016 21:28:59 +0000
Message-ID: <1E23015B9294604195E5EBA53602E115FCEE7D@WDC-VMAILBOXP25.smrcy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0Yb-0004g9-6m
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329AbcATVop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:44:45 -0500
Received: from WDC-WSMAIL01.mercy.net ([170.29.68.82]:58281 "EHLO mercy.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751034AbcATVoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 16:44:44 -0500
X-Greylist: delayed 942 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2016 16:44:43 EST
Received: from STL-VMAILHUBP04.smrcy.com (unknown [170.29.71.18])
	by Websense Email Security Gateway with ESMTPS id 77B342A751F6B
	for <git@vger.kernel.org>; Wed, 20 Jan 2016 15:28:59 -0600 (CST)
Received: from WDC-VMAILBOXP25.smrcy.com ([::1]) by STL-VMAILHUBP04.smrcy.com
 ([::1]) with mapi id 14.03.0266.001; Wed, 20 Jan 2016 15:29:00 -0600
Thread-Topic: GIT Question
Thread-Index: AdFTyZFAHIg8Y+CwSjy8gBRmO8kvHw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: jf8= AIG9 DzqM D6XI EeyZ Ef9N FVVT GN9I HrDS H+xV IH0q
 IIV5 J2HW LW+h MYxX
 MnxA;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{DA296E5B-856C-4B98-9F37-3F7E14026272};dABvAHIAaQAuAGQAcgBhAGcAZwBzAEAAbQBlAHIAYwB5AC4AbgBlAHQA;Wed,
 20 Jan 2016 21:28:56 GMT;RwBJAFQAIABRAHUAZQBzAHQAaQBvAG4A
x-cr-puzzleid: {DA296E5B-856C-4B98-9F37-3F7E14026272}
x-originating-ip: [10.9.72.142]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284473>

Specs:
MacBook Pro 
OS X Yosemite
2.6 GHz Intel Core i5, 8GN 1600 MHz DDR3

After selecting the Git option in a recent install of Visual Studio Code 2015 for MAC, my filesystem was removed. I can no longer access any of the local files stored on my machine. After researching many blogs/websites to no avail I am reaching out to you.  I contacted Apple Support who instructed me to contact the developers for GIT.
 
I am a struggling college student interested in a development career. After spending nearly a year to save up for my laptop - seeing everything gone after a few lines of code is more than devastating.  I am new to GIT and am overwhelmed by the breadth of information available.  If you could share your expertise and guide me to a resource that may address this issue I would be so very grateful.  This is my first real project and I was trying to get myself set up with Visual Studio Code 2015 for Mac.  I know that is not your concern, so getting back to my inquiry - specifically I am looking for information on rolling back a possible commit that removed my entire MacBook Pro file system. I have the .bash_history and am including it below. 

git
git status
git log
git rm
git rm -r
--r
git -r
--r git
git
git diff
git log
git status
git log -diff-filter=D -summary
git log -diff-filter=D -summary
git log -diff-filter=D -author=Parent -summary
gitcheckout <commit>~1 (I believe this is where things exploded)
git fsck -lost-found
ls  .git/lost-found/other
ls.git/lost-found/other
git fsck -lost-found ls .git/lost-found/other
git stash
git pull -rebase
git stash pop
git reflog
git checkout -b branch-name c3a4103
git fsck -lost-found ls unreachable
open .git/lost-found/other
cd .git/lost-found/othergit cat-file -p c3a4103
git rm -rf
git reset -hard
git resert -hard
--help
Help
Restore
--restore

--While there is more I don't believe it will assist with your investigation.  If the full file is needed, I would be more than happy to forward it to your attention.   




Thank you again for your time and expertise.  

Tori Draggs
Tori.draggs@mercy.net
Techgeek2013@gmail.com
Github: https://github.com/gnugal314 

This electronic mail and any attached documents are intended solely for the named addressee(s) and contain confidential information. If you are not an addressee, or responsible for delivering this email to an addressee, you have received this email in error and are notified that reading, copying, or disclosing this email is prohibited. If you received this email in error, immediately reply to the sender and delete the message completely from your computer system.
