From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: use remote repository as webroot
Date: Tue, 02 Aug 2011 17:00:36 +0200
Message-ID: <4E381114.2070007@elegosoft.com>
References: <1312283829487-6644436.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: lunarnet76 <jeanbaptiste.verrey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 17:01:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoGSs-0004rv-Ql
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 17:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab1HBPA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 11:00:59 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:59744 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab1HBPA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 11:00:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 10811DE7CE;
	Tue,  2 Aug 2011 17:00:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fmPp2EG2btwi; Tue,  2 Aug 2011 17:00:51 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id D06D8DE0D2;
	Tue,  2 Aug 2011 17:00:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
In-Reply-To: <1312283829487-6644436.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178473>

On 08/02/2011 01:17 PM, lunarnet76 wrote:
> I have a small issue (I hope), I have a git repository in an apache folder
> accessed by http://ip/git, I can clone, pull push and stuff, but I don't get
> how to get the remote repository (http://ip/git) to update the files to the
> one I have just pushed!

This may help:

https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F

http://toroid.org/ams/git-website-howto
