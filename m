From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: git-svn: Internal error during fetch of mono repository
Date: Wed, 16 Jan 2008 18:23:05 +0530
Message-ID: <878x2qaq4u.fsf@hariville.hurrynot.org>
References: <478DDEED.8050906@web.de> <87d4s2qa93.fsf@hariville.hurrynot.org>
	<478DF4FE.8010204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 13:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF7mG-0001pE-NQ
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 13:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbYAPMxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 07:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYAPMxZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 07:53:25 -0500
Received: from main.gmane.org ([80.91.229.2]:35544 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbYAPMxY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 07:53:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JF7ld-0003mz-Bp
	for git@vger.kernel.org; Wed, 16 Jan 2008 12:53:17 +0000
Received: from 59.92.130.177 ([59.92.130.177])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 12:53:17 +0000
Received: from harinath by 59.92.130.177 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 12:53:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.130.177
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:u03Wgpe0nSUuhjOlXYatNRpAfwU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70663>

Hi,

Mark Junker <mjscod@web.de> writes:

> Raja R Harinath schrieb:
>
>> It's probably an issue with anonsvn.mono-project.com: maybe run out of
>> space on /tmp.  I remember someone else complaining about it on #mono
>> this morning.
>
> Did he get the same error message?

(01:25:24  IST) hubert_yub: when updating mono svn : 
(01:25:30  IST) hubert_yub: hubert@hublinux /home/hubert/mono $ svn up mono
(01:25:31  IST) hubert_yub: svn: Can't find a temporary directory
(01:28:21  IST) hubert_yub: on anonsvn

> Is his problem solved?

No idea :-)

- Hari
