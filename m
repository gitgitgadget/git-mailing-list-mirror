From: Mike Hommey <mh@glandium.org>
Subject: (Remaining) problems with the http backend ?
Date: Thu, 17 Jul 2008 10:04:20 +0200
Organization: glandium.org
Message-ID: <20080717080419.GA23489@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 10:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJOUd-0008Ui-W5
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 10:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbYGQIEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbYGQIEe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:04:34 -0400
Received: from vuizook.err.no ([194.24.252.247]:45833 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbYGQIEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:04:33 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KJOTQ-0002sR-8n
	for git@vger.kernel.org; Thu, 17 Jul 2008 10:04:30 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1KJOTM-0006Pj-R3
	for git@vger.kernel.org; Thu, 17 Jul 2008 10:04:20 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88815>

Hi list,

Except for the typical known stuff such as bad error reporting, people
forgetting to run git update-server-info and lack of support for
packed-refs, are there any other known issues with the http backend ?

Mike

PS: Answers to this post will be used to fill my GIT-HTTP-TODO list.
