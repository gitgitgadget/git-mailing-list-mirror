From: Lahiru Perera <lahiru@providencesl.com>
Subject: Problem in pushing git
Date: Mon, 02 Mar 2009 13:01:27 +0530
Message-ID: <49AB8B4F.90006@providencesl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 08:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le2kY-0006P3-1Q
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 08:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbZCBHiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 02:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbZCBHiO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 02:38:14 -0500
Received: from mail40.opentransfer.com ([76.162.254.40]:54479 "HELO
	mail40.opentransfer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751743AbZCBHiN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 02:38:13 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2009 02:38:13 EST
Received: (qmail 19154 invoked by uid 399); 2 Mar 2009 07:31:29 -0000
Received: from unknown (HELO ?192.168.1.28?) (220.247.246.246)
  by mail.opentransfer.com with SMTP; 2 Mar 2009 07:31:29 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111909>

Hi Im Lahiru im very new to git...Im using linux mint and i have problem 
using git...

1. I have a server and i create a new repo on it..buy this command
 #mkdir test.git
 #cd test.git
 #vi lahiru "add a line in it"
 # git add .
 # git commit -m"first git"

2. And i went to a client and i clone the project..
 #git clone ssh://user@mydomain.com
 #cd test
 #edit  file"lahiru"
 #vi poojitha "add a line to poojitha"
 #git add .
 #git commit -m"add a line on lahiru"
 #git push origin master

all these i showed to u is the way i have created, clone and push the 
repo's.. my problem is when i finishing the pushing part the changer's 
are not save on the main repo means on the server if i typed it showed 
is as delete line...."git status"

y is this not saving?

 git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#    modified:   lahiru
#    deleted:    poojitha


Im finding a solution from last few month

Thks
Lahiru.

-- 
Lahiru Perera
System Administrator
Providence Network & Solutions (Pvt) Ltd.
No. 752/1, Dr.Danister De Silva Mawatha,
Colombo 09,
Sri Lanka.

Phones (work)	= +94 11 2698232, +94 11 5749575
Fax		= +94 11 2698232
E-mail 		= lahiru@providencesl.com
Web Page	= www.providencesl.com
Skype		= lahirucom
google		= lahirucom
yahoo		= malinban
