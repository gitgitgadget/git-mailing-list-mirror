From: Mihamina Rakotomandimby <mihamina@rktmb.org>
Subject: bare vs non-bare <1.7 then >=1.7 ?
Date: Thu, 08 Nov 2012 13:11:30 +0300
Message-ID: <509B8552.4080303@rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Issues <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 11:11:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWP5T-0003r7-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 11:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab2KHKLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 05:11:38 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47725 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2KHKLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 05:11:37 -0500
X-Originating-IP: 217.70.178.144
Received: from mfilter16-d.gandi.net (mfilter16-d.gandi.net [217.70.178.144])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 1A392172099
	for <git@vger.kernel.org>; Thu,  8 Nov 2012 11:11:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter16-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter16-d.gandi.net (mfilter16-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id UNccYUWK5Cns for <git@vger.kernel.org>;
	Thu,  8 Nov 2012 11:11:34 +0100 (CET)
X-Originating-IP: 41.190.237.66
Received: from [192.168.0.141] (ip-41-190-237-66.orange.mg [41.190.237.66])
	(Authenticated sender: out@rktmb.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 531751720CC
	for <git@vger.kernel.org>; Thu,  8 Nov 2012 11:11:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121029 Thunderbird/16.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209152>

Hi all,

We're on the way to have our first project using Git.
We're currently mostly using Hg (90%) & SVN (10%).

When experimenting in order to train some colleagues, I saw that If I 
clone a repository, I couldn't push to it because it was a non-bare one.
Searchin for some explanations, I found this ressource:
http://www.bitflop.com/document/111

It's told to be reliable information for Git < v1.7.

What would be different for Git > 1.7 so that I could be up to date with 
the facts?

Thank you.

-- 
RMA.
