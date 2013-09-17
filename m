From: Michele Paoli <Michele.Paoli@i-med.ac.at>
Subject: little suggestion for revert/checkout
Date: Tue, 17 Sep 2013 10:38:22 +0200
Message-ID: <523814FE.2030801@i-med.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 10:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLr78-0001jO-VF
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 10:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab3IQI61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 04:58:27 -0400
Received: from mx.i-med.ac.at ([193.171.76.21]:47503 "EHLO mx.i-med.ac.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab3IQI60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 04:58:26 -0400
X-Greylist: delayed 1185 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2013 04:58:26 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx.i-med.ac.at (Postfix) with ESMTP id 89B3652CB58
	for <git@vger.kernel.org>; Tue, 17 Sep 2013 10:38:36 +0200 (CEST)
Received: from mx.i-med.ac.at ([127.0.0.1])
 by localhost (mx.i-med.ac.at [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06388-07 for <git@vger.kernel.org>;
 Tue, 17 Sep 2013 10:38:35 +0200 (CEST)
Received: from mail1.i-med.ac.at (mail1.i-med.ac.at [172.16.11.17])
	by mx.i-med.ac.at (Postfix) with ESMTP id 5145452C8FC
	for <git@vger.kernel.org>; Tue, 17 Sep 2013 10:38:35 +0200 (CEST)
Received: from [192.168.40.231] (unknown [192.168.40.231])
	by mail1.i-med.ac.at (Postfix) with ESMTP id 0552F31801A
	for <git@vger.kernel.org>; Tue, 17 Sep 2013 10:38:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-Virus-Scanned: amavisd-new at i-med.ac.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234864>

hi

I like your "crash curse"  http://git.or.cz/course/svn.html

(sorry for my bad English)

a little suggestion for revert/checkout
svn revert -R .    <--->  git checkout <id> '*'

best regards

Michele Paoli

-- 
-----------------------------------------------
Dott. Michele Paoli
Innsbruck Medical University
IT-Services
Medicent
Innrain 143, 4th fl.
phone: ++43(0)512 9003 71025
fax: ++43(0)512 9003 73021
e-mail: michele.paoli@i-med.ac.at
url: http://www.i-med.ac.at/itservices
