From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Tue, 02 Jun 2015 10:22:36 +0200
Message-ID: <556D67CC.3000400@drmicha.warpmail.net>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com> <3813728.oJDPxEPYet@cs-pc> <CAGZ79kb01tODVL+iMNWvQdxwUZujy8fy0B3ZiNwODoJ5kadzvw@mail.gmail.com> <1749852.uCRPrjoCKZ@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, tr@thomasrast.ch,
	jk@jk.gs, phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com
To: Christian Stimming <stimming@tuhh.de>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 10:22:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzhTD-0001Sl-7P
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 10:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbbFBIWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 04:22:43 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60623 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751860AbbFBIWj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 04:22:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 0692420B69
	for <git@vger.kernel.org>; Tue,  2 Jun 2015 04:22:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 02 Jun 2015 04:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=fxEt+zlqaQk6jIck/XSpUzhEzgI=; b=MMty3t
	XJWizj8uuzUF7h/e17e3wEv7ejjYvXG9TyqEsog/Xa7BZPFilMTH92VKIj0Qs8vI
	tUrHNV5Urj8JL0o/e/8tWfzjlxcPGFYFtZpEivRjGRVWzDXz1AuaOZ07qL0RhZNf
	JMjLv75zzpsN35Frv1d9mlXKoXVKW3N4u30tM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=fxEt+zlqaQk6jIc
	k/XSpUzhEzgI=; b=mKoOHu6jCI5ADVWFr44EMIt4WRFKRzHv7H6VVmt4pDbe+cU
	BfBPOdNOERe7EHWwF2t3M8VP9HcrZLjrVNDf1I6hHnfSNnLyIf+Cc+KUnhIA20TY
	3BhMjWzZCl6FNe3ss8Xrn7+QeD/a8mOrzKbzpcjfU6yimI4tDim3w7Aa4kBI=
X-Sasl-enc: o782qGmLm/UAI4CJj9+MEUHwStowGU43lHMJW3NTkM7Q 1433233358
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A5A84C0001E;
	Tue,  2 Jun 2015 04:22:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1749852.uCRPrjoCKZ@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270507>

Christian Stimming venit, vidit, dixit 01.06.2015 22:00:
> Am Montag, 1. Juni 2015, 12:34:31 schrieb Stefan Beller:
>> On Mon, Jun 1, 2015 at 12:26 PM, Christian Stimming <stimming@tuhh.de> 
> wrote:
>>> "index" concept, my explanation routinely says "This concept is called
>>> 'index' but it has nothing to do with any associations you make with that
>>> word. Better remember this thingy as *** and replace the termin 'index'
>>> with *** every time you read about it." where "***" is my preferred
>>> translation. The facial expressions of the audience regarding "index"
>>> regularly confirm this approach as the better one. I never encountered
>>> anyone who says "Oh, but isn't 'index' a much better term for this than
>>> what you said..."
>>
>> So the *** is cut out here, or do you literally advise to think of a
>> black magic box here?
>> I'd be interested to know your preferred translation, maybe that can
>> be used instead of Staging-Area then?
> 
> Sorry for being unclear here: I left out the concrete word I use because you 
> might need to come up with your own choice in the command-line git 
> translation. The point of this remark is rather that almost any other term is 
> better than leaving "index" as a term as-is. The term that I use is only one 
> among probably many possibilities.
> 
> In case you still want to know my preferred German word, I stick to the 
> translations that are used in git-gui, mostly still proposed by myself in 
> (huh) 2008. http://repo.or.cz/w/git-gui.git/blob/HEAD:/po/glossary/de.po  
> There, "index" isn't used in the user interface anymore but rather "staging 
> area", and that's translated into German as "Bereitstellung". In my experience 
> this term works quite well for a German-speaking developer audience, even 
> though the term with its military background is only seldomly used or known. 
> But the word triggers some well-suited associations: partly "bereit" for the 
> next step, partly "Stellung" as some extra third place in addition to working 
> copy and repository. But that might very well be a different discussion than 
> what you need to discuss for command line git.
> 
> Regards,
> 
> Christian
> 

git-gui in German is unusable for any user who knows German and knows
the technical terms used in git but not the specific choices the git-gui
translator has made. It's a great example of how not to do a translation.

Also, a translation is really the wrong place to "correct" choices made
upstream in the main project. There it is index, not staging area (for a
good reason).

The purpose of a translation is to make it easier for non-native users
to use a tool by translating (parts of) the interface into their
language - not to make it more difficult for them to use the other parts.

Michael
