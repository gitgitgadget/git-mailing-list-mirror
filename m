From: Maximilien Noal <noal.maximilien@gmail.com>
Subject: Re: gitk : french translation
Date: Mon, 09 Nov 2009 00:11:38 +0100
Message-ID: <4AF7502A.9020903@gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com> <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com> <20091107025439.GC13724@vidovic> <9f50533b0911080955l606ea87aw4edd7b0bc926a25f@mail.gmail.com> <20091108214130.GA12931@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Emmanuel Trillaud <etrillaud@gmail.com>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Nov 09 00:11:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GvD-0000sF-E6
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 00:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbZKHXLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 18:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755713AbZKHXLg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 18:11:36 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61477 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbZKHXLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 18:11:36 -0500
Received: by ewy3 with SMTP id 3so2650918ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 15:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=zy87+a24u6PRuGUvrzjocJE2kTY8v5Lm8Fsj6VdcO2s=;
        b=eEAqVNVOmF8FaRIoL4duykI2tq5RiyDj4lAJGFhh5CrVsvoZcJVhGYiZJPWcrX6vaP
         G2thyASuHjx5fvMdmDBgwM6chLr9v9eju0udd2yD5Ptn4hLzQb3qKFvvbhZQ1Et4Nc95
         NPGTS3C1hhCynlz77aGbxC8NMu/+TXZ5RL4n8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=K21orZm4pAJfN3dJYGI93bOEJjojE8vf3SaN9HiFagsAi2739Ue7XOgYwz/O4H9A0s
         pGymYlahzaw6mq3zVdZU+cvFUbTWUCJpNyi6Cslneo0SXiWuK0lDUznWWJ11sZPi+qGQ
         sDqy316AtWsQZB3Cn5WZMDGevyvo1aqjpWxBE=
Received: by 10.213.0.218 with SMTP id 26mr2433449ebc.19.1257721900809;
        Sun, 08 Nov 2009 15:11:40 -0800 (PST)
Received: from ?192.168.1.20? (ABordeaux-257-1-59-234.w90-45.abo.wanadoo.fr [90.45.202.234])
        by mx.google.com with ESMTPS id 5sm4589384eyh.18.2009.11.08.15.11.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 15:11:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091108214130.GA12931@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132429>

Nicolas Sebrecht wrote :
>>> I disagree here. Words like "diff", "commit", "patch", etc should be
>>> kept as is. Translation of those terms make things harder for the users.
>> I agree with you when those terms refers to _commands_ names, but the
>> main goal of a
>> translation is to _translate_ and we have to make the best effort to
>> use french word if they _exist_
> 
> I don't think so. Here is _why_: the user-frienliness of a translated
> software comes from "how hard is it to connect a word with the
> underlying concept".
> 
> IOW, we want to have good words to refer to the _concepts_. In the
> computer science world (and more _specially_ for a SCM), those concepts
> are much more well-known with the english terms. Keeping english words
> help users to directly understand what it is about, without making the
> users have to search for "what the fucking translators are refering to
> here?".
Why not put the translation first, then the english word between () ?
At least for English words above that are not used by French devs "as 
is" (not like "diff") ?

That way, newbies to SCMs' concepts get the idea, and old SCM users 
don't have to translate back.

But if it isn't done _everywhere_ (and not used anywhere for words we 
don't want to translate because there's no need or no good translation, 
like "diff" for the first case, and "patch" for the second one), it will 
make the situation worse.

Just my two cents.
