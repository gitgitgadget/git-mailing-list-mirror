From: Rich Pixley <rich.pixley@palm.com>
Subject: git submodule delete?
Date: Wed, 09 May 2012 17:34:58 -0700
Message-ID: <4FAB0D32.3000503@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 10 02:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSHLe-0007dj-Ig
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 02:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab2EJAfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 20:35:04 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:58410 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2EJAfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 20:35:03 -0400
X-IronPort-AV: E=Sophos;i="4.75,561,1330934400"; 
   d="scan'208";a="13416090"
Received: from unknown (HELO ushqusdns3.palm.com) ([148.92.223.90])
  by smtp-relay2.palm.com with ESMTP; 09 May 2012 17:34:59 -0700
Received: from fuji-land.noir.com ([10.100.2.2])
	by ushqusdns3.palm.com (8.14.4/8.14.4) with ESMTP id q4A0YwUT030125;
	Wed, 9 May 2012 17:34:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197533>

How do I remove a submodule?

Put another way, I've made a commit pointing to a nonexistent submodule 
commit.  And the submodule commit is now lost.  Can I manually force the 
submodule commit to the previous value?  Or can I remove the submodule 
and re-add it with an existing value?

--rich
