From: sf <sf@b-i-t.de>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Tue, 27 Sep 2005 12:35:29 +0200
Message-ID: <43392071.7080202@b-i-t.de>
References: <20050926175204.GC9410@reactrix.com>
Reply-To: sf-git@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 27 12:40:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKCqm-0005Xn-Qh
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 12:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVI0KiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVI0KiO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 06:38:14 -0400
Received: from main.gmane.org ([80.91.229.2]:33734 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964891AbVI0KiN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 06:38:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EKCpH-00052Y-CW
	for git@vger.kernel.org; Tue, 27 Sep 2005 12:36:44 +0200
Received: from ip-213157000067.dialin.heagmedianet.de ([213.157.0.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 12:36:43 +0200
Received: from sf-git by ip-213157000067.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 12:36:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157000067.dialin.heagmedianet.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
In-Reply-To: <20050926175204.GC9410@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9391>

Nick Hengeveld wrote:
> Support for partial HTTP transfers - if a previous temp file is detected,
> read it in and start the HTTP transfer from where the previous left off.

Please read my recent posting:

	http://permalink.gmane.org/gmane.comp.version-control.git/8991.

Regards

	Stephan
