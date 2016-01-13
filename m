From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: say "commits" in the --depth option wording for
 git-clone
Date: Wed, 13 Jan 2016 19:22:31 +0100
Message-ID: <569695E7.4020704@gmail.com>
References: <n6j1cs$p4$1@ger.gmane.org> <568F7EDD.9020003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 19:23:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJQ4U-0007Vj-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 19:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbcAMSW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 13:22:58 -0500
Received: from plane.gmane.org ([80.91.229.3]:51419 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbcAMSW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 13:22:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aJQ4N-0007Ti-TA
	for git@vger.kernel.org; Wed, 13 Jan 2016 19:22:55 +0100
Received: from p548d69d8.dip0.t-ipconnect.de ([84.141.105.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 19:22:55 +0100
Received: from sschuberth by p548d69d8.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 19:22:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p548d69d8.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <568F7EDD.9020003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283960>

On 08.01.2016 10:18, Sebastian Schuberth wrote:

> It is not wrong to talk about "revisions" here, but in this context
> revisions are always commits, and that is how we already name it in the
> git-fetch docs. So align the docs by always referring to "commits".

Sorry for the missing sign-off, feel free to amend that in pu:

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

-- 
Sebastian Schuberth
