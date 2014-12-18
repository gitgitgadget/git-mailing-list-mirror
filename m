From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: confusion with some `git reset` commands
Date: Thu, 18 Dec 2014 15:09:33 +0300
Message-ID: <20141218150933.01825f2d6c827aa6eab99507@domain007.com>
References: <2055441.uOK6yH3IMG@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 13:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Ztu-0006Rd-Gw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 13:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbaLRMJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 07:09:41 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:50286 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbaLRMJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 07:09:40 -0500
Received: from tigra.domain007.com ([192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id sBIC9Xwf004723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Dec 2014 15:09:34 +0300
In-Reply-To: <2055441.uOK6yH3IMG@linux-wzza.site>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261523>

On Wed, 17 Dec 2014 01:09:08 +0630
Arup Rakshit <aruprakshit@rocketmail.com> wrote:

[...]
> But I am looking for any differences -
> 
> a) git reset --soft and git reset --keep
> b) git reset --hard and git reset --merge

Please consider reading
http://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified
