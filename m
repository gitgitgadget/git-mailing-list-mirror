From: Yves Perron <yves.perron@modusfx.com>
Subject: Don't share anything but those files
Date: Fri, 13 Jul 2012 10:40:12 -0400
Message-ID: <5000334C.5030505@modusfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 17:00:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SphM1-00041C-4A
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 17:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947Ab2GMPAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 11:00:16 -0400
Received: from mx2.b2b2c.ca ([66.158.128.36]:41635 "EHLO mx2.b2b2c.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687Ab2GMPAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 11:00:15 -0400
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2012 11:00:15 EDT
Received: from modusfx.com (modusfx-142-218.cust.b2b2c.ca [66.158.142.218])
	by mx2.b2b2c.ca (8.14.4/8.14.4) with ESMTP id q6DEf7HX029074
	for <git@vger.kernel.org>; Fri, 13 Jul 2012 10:41:07 -0400
Received: from [10.1.100.132] [10.1.100.132] by modusfx.com with ESMTP
  (SMTPD-11.5) id d97000005bcda978; Fri, 13 Jul 2012 10:40:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201405>

Greetings everyone,

I'm wondering how to commit only selected files/folders on GIT, if even 
possible. Note, the ignore list is not a good option for me as I'd like 
to add a few files in a folder that contains many hundreds for instance.

Basically, I'm looking for a way to say, don't share anything but those 
files.

thx
