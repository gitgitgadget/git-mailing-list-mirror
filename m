From: Kevin Stange <kevin@steadfast.net>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Thu, 31 May 2012 18:18:33 -0500
Message-ID: <4FC7FC49.4030503@steadfast.net>
References: <4FC7EFB7.4090704@steadfast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 01:18:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaEdc-0007iW-7z
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 01:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607Ab2EaXSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 19:18:36 -0400
Received: from staffmx.steadfast.net ([67.202.100.6]:52579 "EHLO
	staffmx.steadfast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758594Ab2EaXSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 19:18:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by staffmx.steadfast.net (Postfix) with ESMTP id B185E7C4001
	for <git@vger.kernel.org>; Thu, 31 May 2012 18:18:34 -0500 (CDT)
X-Virus-Scanned: amavisd-new at steadfast.net
Received: from staffmx.steadfast.net ([127.0.0.1])
	by localhost (staffmx.steadfast.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K1ESh+YZ9p-D for <git@vger.kernel.org>;
	Thu, 31 May 2012 18:18:34 -0500 (CDT)
Received: from ziyal.office.steadfast.net (unknown [IPv6:2607:f128:0:1:222:4dff:fe51:2ed5])
	by staffmx.steadfast.net (Postfix) with ESMTPSA id 189F07C4002
	for <git@vger.kernel.org>; Thu, 31 May 2012 18:18:34 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <4FC7EFB7.4090704@steadfast.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198953>

On 05/31/2012 05:24 PM, Kevin Stange wrote:
> Apologies for anything wrong I might have done here.  I'm not used to
> procedures for this sort of patch submission, or terribly familiar with
> the code base.  I'm seeking advice on whether this approach is sane or
> completely crazy, and I'm willing to adjust it to make it suitable for
> inclusion.

Of course, I failed to get my email client to send the patch unwrapped.  Only one line appears to have been affected, but I don't think this is a final patch.  I'll be sure to make a proper submission for any future patches I send.  Sorry!

-- 
Kevin Stange
Chief Technology Officer
Steadfast Networks
http://steadfast.net
Phone: 312-602-2689 ext. 203 | Fax: 312-602-2688 | Cell: 312-320-5867
