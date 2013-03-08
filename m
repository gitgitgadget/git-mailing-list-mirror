From: John Stean <john.stean@lane15.co.uk>
Subject: question re tags
Date: Fri, 8 Mar 2013 15:16:03 +0000 (GMT)
Message-ID: <25720629.116.1362755762863.JavaMail.User@LANE15-HP>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 16:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDz2G-0003Ra-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 16:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262Ab3CHPQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 10:16:14 -0500
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:35756 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757836Ab3CHPQO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Mar 2013 10:16:14 -0500
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay07.hostedemail.com (Postfix) with SMTP id 5E7E02D2C79
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 15:16:11 +0000 (UTC)
X-Panda: scanned!
X-Session-Marker: 6A6F686E2E737465616E406C616E6531352E636F2E756B
X-Filterd-Recvd-Size: 820
Received: from localhost (host81-149-35-185.in-addr.btopenworld.com [81.149.35.185])
	(Authenticated sender: john.stean@lane15.co.uk)
	by omf06.hostedemail.com (Postfix) with ESMTPA
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 15:16:10 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217664>

Ive been tagging some commits using tortoise git , for example with "v1.0", "v1.1" etc. In tortoise git log the tag sits alongside the commit as I expect.
But when I do a git describe it outputs the first tag along with the latest commit. What am I doing wrong?
