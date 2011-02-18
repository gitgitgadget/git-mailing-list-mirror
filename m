From: "Alexey Feldgendler" <alexeyf@opera.com>
Subject: Re: Directory replaced with a file confuses cherry-pick
Date: Fri, 18 Feb 2011 15:49:10 +0100
Organization: Opera Software ASA
Message-ID: <op.vq3sr8w956e9f9@xman.eng.oslo.osa>
References: <op.vq3qtqtj56e9f9@xman.eng.oslo.osa>
 <201102181544.06045.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 15:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqRe3-0005AZ-7D
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 15:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab1BROtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 09:49:13 -0500
Received: from smtp.opera.com ([213.236.208.81]:35218 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106Ab1BROtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 09:49:12 -0500
Received: from xman.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1IEnA1W024478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 14:49:10 GMT
In-Reply-To: <201102181544.06045.johan@herland.net>
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167217>

On Fri, 18 Feb 2011 15:44:05 +0100, Johan Herland <johan@herland.net>  
wrote:

> Unable to reproduce. Here are the commands I used (please post yours):

I tried your exact script now, line by line, and it failed in the way I  
described.

> This should not be the case. Which Git version are you using?

git is from Debian testing, package version 1:1.7.2.3-2.2.


-- 
Alexey Feldgendler
Software Developer, Desktop Team, Opera Software ASA
[ICQ: 115226275] http://my.opera.com/feldgendler/
