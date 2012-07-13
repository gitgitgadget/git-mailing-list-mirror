From: Yves Perron <yves.perron@modusfx.com>
Subject: Don't share anything but those files
Date: Fri, 13 Jul 2012 10:59:55 -0400
Message-ID: <500037EB.5030408@modusfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 17:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SphMb-000544-4B
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 17:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757980Ab2GMPA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 11:00:56 -0400
Received: from modusfx-142-218.cust.b2b2c.ca ([66.158.142.218]:21138 "EHLO
	modusfx.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757947Ab2GMPAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 11:00:50 -0400
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2012 11:00:49 EDT
Received: from [10.1.100.132] [10.1.100.132] by modusfx.com with ESMTP
  (SMTPD-11.5) id 725200005c0faa10; Fri, 13 Jul 2012 10:59:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201406>

Greetings everyone,

I'm wondering how to commit only selected files/folders on GIT, if even 
possible. Note, the ignore list is not a good option for me as I'd like 
to add a few files in a folder that contains many hundreds for instance.

Basically, I'm looking for a way to say, don't share anything but those 
files.

thx
