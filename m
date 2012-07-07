From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: congif spec in GIT
Date: Sat, 07 Jul 2012 11:53:31 +0200
Message-ID: <4FF8071B.6010407@dewire.com>
References: <4FF6D022.10801@itcnetworks.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Radu Manea <RManea@luxoft.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 11:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnRim-0007hq-F2
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 11:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab2GGJxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 05:53:52 -0400
Received: from mail.dewire.com ([83.140.172.130]:1571 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab2GGJxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 05:53:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E898D8FC96;
	Sat,  7 Jul 2012 11:53:48 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id la60RX9Raiqr; Sat,  7 Jul 2012 11:53:32 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h102n2fls33o828.telia.com [213.67.12.102])
	by dewire.com (Postfix) with ESMTP id 102308FC94;
	Sat,  7 Jul 2012 11:53:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120529 Thunderbird/13.0
In-Reply-To: <4FF6D022.10801@itcnetworks.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201160>

Radu Manea skrev 2012-07-06 13.46:
> Hi,
>
> Thank you for the detailed presentation posted on git.or.cz site.
>
> One question: is there any equivalent config spec file for GIT as is in ClearCase today?

Repo (http://source.android.com/source/version-control.html) is perhaps
the tool that is most similar in functionality to the config spec. It allows you
to perform operations over multiple repositories.

-- robin
