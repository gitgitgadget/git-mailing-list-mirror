From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] cherry-pick -x: always insert an empty line
Date: Thu, 23 Feb 2012 09:56:48 +0100
Message-ID: <4F45FF50.3090009@gmail.com>
References: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Raible <raible@nextest.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 09:57:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0UUE-0006rI-6T
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 09:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab2BWI5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 03:57:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:49639 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322Ab2BWI47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 03:56:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S0UTx-0006ee-VO
	for git@vger.kernel.org; Thu, 23 Feb 2012 09:56:57 +0100
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 09:56:57 +0100
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 09:56:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191335>

On 18.02.2012 22:14, Beat Bolli wrote:

> This patch fixes this buglet by always inserting an empty line before
> the added line.

Thanks for this! Not having an empty line there has annoyed me, too, 
several times.

-- 
Sebastian Schuberth
