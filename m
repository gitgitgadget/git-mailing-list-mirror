From: Arnaud Bailly <abailly@oqube.com>
Subject: Problem adding a symlinkg
Date: Wed, 10 Feb 2010 22:17:40 -0800 (PST)
Message-ID: <1265869060330-4553010.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 07:17:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfSN1-0004lZ-W1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 07:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab0BKGRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 01:17:42 -0500
Received: from kuber.nabble.com ([216.139.236.158]:44804 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab0BKGRm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 01:17:42 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <abailly@oqube.com>)
	id 1NfSMu-0001TW-Au
	for git@vger.kernel.org; Wed, 10 Feb 2010 22:17:40 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139573>


Hello,
I am trying to add some symlink to git and got the following error:

error: readlink("protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so"): Invalid
argument
error: unable to index file protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so
fatal: adding files failed

I thought it was possible to add symlinks to git. What  am I doing wrong ?

THanks for your help
Arnaud
-- 
View this message in context: http://n2.nabble.com/Problem-adding-a-symlinkg-tp4553010p4553010.html
Sent from the git mailing list archive at Nabble.com.
