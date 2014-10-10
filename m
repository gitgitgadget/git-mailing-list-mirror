From: Cameron Smith <smithc11@rpi.edu>
Subject: git-log documentation formatting
Date: Fri, 10 Oct 2014 14:50:15 -0400
Message-ID: <54382A67.4070601@rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 20:58:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcfOE-0005Yz-GO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 20:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbaJJS6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 14:58:06 -0400
Received: from gateway.canit.rpi.edu ([128.113.2.229]:37718 "EHLO
	smtp9.server.rpi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaJJS6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 14:58:04 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Oct 2014 14:58:04 EDT
Received: from smtp-auth1.server.rpi.edu (route.canit.rpi.edu [128.113.2.231])
	by smtp9.server.rpi.edu (8.14.3/8.14.3/Debian-9.4) with ESMTP id s9AIo39j011918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 10 Oct 2014 14:50:03 -0400
Received: from smtp-auth1.server.rpi.edu (localhost [127.0.0.1])
	by smtp-auth1.server.rpi.edu (Postfix) with ESMTP id A0D7A58497
	for <git@vger.kernel.org>; Fri, 10 Oct 2014 14:50:02 -0400 (EDT)
Received: from [129.161.1.18] (ccni-09.dynamic2.rpi.edu [129.161.1.18])
	(using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: smithc11)
	by smtp-auth1.server.rpi.edu (Postfix) with ESMTPSA id 9072D58463
	for <git@vger.kernel.org>; Fri, 10 Oct 2014 14:50:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Virus-Scanned: ClamAV using ClamSMTP
X-Bayes-Prob: 0.0001 (Score 0, tokens from: outgoing, @@RPTN)
X-Spam-Score: 0.00 () [Hold at 10.10] 
X-CanIt-Incident-Id: 02N1uO3eR
X-CanIt-Geo: ip=129.161.1.18; country=US; region=Connecticut; city=Hartford; latitude=41.7637; longitude=-72.6851; http://maps.google.com/maps?q=41.7637,-72.6851&z=6
X-CanItPRO-Stream: outgoing
X-Canit-Stats-ID: Bayes signature not available
X-Scanned-By: CanIt (www . roaringpenguin . com) on 128.113.2.229
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-log documentation page
http://git-scm.com/docs/git-log
enters into a quoted block for the description of the "format:<string>" 
option and never exits.

-Cameron
