From: devendra <dev@savarinetworks.com>
Subject: git-upload-archive help was not shown correctly
Date: Sat, 14 Jan 2012 19:10:16 +0530
Message-ID: <1326548416.5992.1.camel@devendra-Linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 15:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm49U-0002N4-Sf
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 15:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab2ANOAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 09:00:05 -0500
Received: from chost02.esudo.com ([65.49.35.222]:46900 "EHLO chost02.esudo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682Ab2ANOAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 09:00:04 -0500
X-Greylist: delayed 1181 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jan 2012 09:00:04 EST
Received: from [122.172.160.121] (helo=[192.168.1.2])
	by chost02.esudo.com with esmtpa (Exim 4.69)
	(envelope-from <dev@savarinetworks.com>)
	id 1Rm3qI-0005rz-9Q
	for git@vger.kernel.org; Sat, 14 Jan 2012 05:40:22 -0800
X-Mailer: Evolution 2.30.3 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chost02.esudo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - savarinetworks.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188568>

Hi git folks,

the command git-upload-archive is not properly showing usage info when
ran barely with out any args.

it shows some kind of unwanted garbage instead of showing a nice help
message.

The output is pasted here.

root@devendra-Linux:/home/devendra/git/Documentation#
git-upload-archive 
0008ACK
00000026 usage: git upload-archive <repo>
0031 git upload-archive: archiver died with errorfatal: sent error to
the client: git upload-archive: archiver died with error

my git latest version shows commit sha1 number
6db5c6e43dccb380ca6e9947777985eb11248c31.

Devendra.
