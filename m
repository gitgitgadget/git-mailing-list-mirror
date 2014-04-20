From: Richard Hansen <rhansen@bbn.com>
Subject: security vulnerability disclosure procedure?
Date: Sun, 20 Apr 2014 16:42:09 -0400
Message-ID: <53543121.3000808@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:07:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbyxZ-0001pz-0g
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbaDTVH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:07:29 -0400
Received: from smtp.bbn.com ([128.33.0.80]:14292 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaDTVH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:07:28 -0400
X-Greylist: delayed 1516 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Apr 2014 17:07:27 EDT
Received: from socket.bbn.com ([192.1.120.102]:40902)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WbyZ0-000OKw-77
	for git@vger.kernel.org; Sun, 20 Apr 2014 16:42:10 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D2D9940189
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246582>

Hi all,

I have discovered a minor security vulnerability.  I could send the
patch to the mailing list, but I wanted someone else to take a look
first just to make sure it's minor enough that folks will think it's OK
to publicly announce.

Who should I send the patch to?

Thanks,
Richard
