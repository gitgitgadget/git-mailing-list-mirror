From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/4] git-p4 test cleanup, commit time change
Date: Sun, 31 Jul 2011 17:01:12 +0100
Message-ID: <4E357C48.5090409@diamand.org>
References: <20110731003557.GA4867@arf.padd.com> <4E352535.4060804@diamand.org> <20110731134237.GA6564@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 18:01:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnYS9-0003n9-K9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 18:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab1GaQBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 12:01:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43586 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab1GaQBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 12:01:16 -0400
Received: by wwe5 with SMTP id 5so4900650wwe.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 09:01:15 -0700 (PDT)
Received: by 10.227.178.6 with SMTP id bk6mr2552627wbb.12.1312128075239;
        Sun, 31 Jul 2011 09:01:15 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id fo2sm3442765wbb.14.2011.07.31.09.01.13
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 09:01:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <20110731134237.GA6564@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178263>

On 31/07/11 14:42, Pete Wyckoff wrote:
> luke@diamand.org wrote on Sun, 31 Jul 2011 10:49 +0100:
>> One thing though - are you sure the p4d demo license only allows 2
>> users? I've only ever used the demo p4d for testing and it seems to
>> work fine (just tried again with version
>> P4D/LINUX26X86_64/2010.2/322263).
>
> You are so right.  I was using an older p4d (2009.1/222893) at
> home, and didn't even think about checking for updates.
>
> There was one line in patch 3 that should survive, just to add a
> "&&".  I've added your acks for the rest and will repost to show
> the current changes.

All looks good to me!

Luke
