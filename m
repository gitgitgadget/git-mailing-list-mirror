From: luis <luis@tandvsolns.co.uk>
Subject: Re: windows git problem
Date: Mon, 12 Sep 2011 19:31:28 +0100
Organization: Test and Verification Solutions
Message-ID: <4E6E5000.3040203@tandvsolns.co.uk>
References: <4E6E42CE.80405@tandvsolns.co.uk> <CAMOZ1Bs6tGGJ8eZja0OaqtzK0imKt_NtiWOTgpLCaisvEXh2Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3BI7-0000G5-US
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 20:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1ILSba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 14:31:30 -0400
Received: from mx.123-reg.co.uk ([94.136.40.61]:37355 "EHLO mailex.mailcore.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab1ILSb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 14:31:29 -0400
Received: from cpc9-hawk13-2-0-cust261.aztw.cable.virginmedia.com ([94.169.69.6] helo=[192.168.0.105])
	by mail11.atlas.pipex.net with esmtpa (Exim 4.71)
	(envelope-from <luis@tandvsolns.co.uk>)
	id 1R3BI1-000301-37; Mon, 12 Sep 2011 19:31:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110809 Thunderbird/6.0
In-Reply-To: <CAMOZ1Bs6tGGJ8eZja0OaqtzK0imKt_NtiWOTgpLCaisvEXh2Rw@mail.gmail.com>
X-Mailcore-Auth: 10092836
X-Mailcore-Domain: 680355
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181233>

Exactly!

so the next time someone (in windows) does a commit, they remove the 
file or the folder contents!

On 12/09/11 19:05, Michael Witten wrote:
> On Mon, Sep 12, 2011 at 17:35, luis<luis@tandvsolns.co.uk>  wrote:
>> However when I checked out the project under windows (either clone or pull)
>> one or the other would disappear and it would be staged as removed.
>>
>> The surprising bit for me was not so much that windows could not cope with
>> the case sensitivity, but that git would stage the changes!
> It would be recorded in the index as a change ready to be committed
> (as though `git rm' had been used)?
>

-- 
Luis Gutierrez
Test and Verification Solutions (TVS)
skype: luis.tandv
