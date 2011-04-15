From: madmarcos <fru574@my.utsa.edu>
Subject: capturing the packfile from git-upload-pack
Date: Thu, 14 Apr 2011 20:22:00 -0700 (PDT)
Message-ID: <1302837720729-6275146.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 05:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAZbk-0003M3-7n
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 05:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab1DODWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 23:22:01 -0400
Received: from sam.nabble.com ([216.139.236.26]:57447 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab1DODWB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 23:22:01 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QAZbc-0002MG-Nt
	for git@vger.kernel.org; Thu, 14 Apr 2011 20:22:00 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171583>

Hi folks,
is there a git command that can capture in a separate file the packfile that
is generated and transmitted from a "want"ed branch during the
git-upload-pack command? I need a good sample to study.
thanks!

--
View this message in context: http://git.661346.n2.nabble.com/capturing-the-packfile-from-git-upload-pack-tp6275146p6275146.html
Sent from the git mailing list archive at Nabble.com.
