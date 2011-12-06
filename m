From: Luke Diamand <luke@diamand.org>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 06 Dec 2011 21:12:17 +0000
Message-ID: <4EDE8531.8090406@diamand.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:12:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2Iz-0000Tq-It
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab1LFVL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:11:57 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51400 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1LFVL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:11:56 -0500
Received: by bkbzv3 with SMTP id zv3so4001322bkb.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 13:11:55 -0800 (PST)
Received: by 10.180.80.162 with SMTP id s2mr19553450wix.27.1323205915220;
        Tue, 06 Dec 2011 13:11:55 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id m25sm35456991wbp.6.2011.12.06.13.11.51
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 13:11:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186385>

On 06/12/11 05:01, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' (proposed updates) while commits prefixed with '+' are in
> 'next'.
>


>
> Will merge to 'next'.
>
> * ld/p4-labels-branches (2011-11-30) 4 commits
>   - git-p4: importing labels should cope with missing owner
>   - git-p4: add test for p4 labels
>   - git-p4: cope with labels with empty descriptions
>   - git-p4: handle p4 branches and labels containing shell chars
>
> I understand this has been retracted---please correct me otherwise.
> Will discard, expecting a reroll.

Yes, discard this one and I'll re-roll it with fixes for the other label 
issues.

Thanks
Luke
