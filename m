From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Wed, 15 Sep 2010 13:51:32 +0200
Message-ID: <4C90B344.6060002@drmicha.warpmail.net>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de> <201009151147.45314.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Stimming <stimming@tuhh.de>, jk@jk.gs, avarab@gmail.com,
	git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 15 13:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvqWU-0005aP-Nw
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 13:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab0IOLv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 07:51:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55332 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844Ab0IOLv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 07:51:29 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B29922B7;
	Wed, 15 Sep 2010 07:51:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 15 Sep 2010 07:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QxXqZjt9JVzNYiPA8Q+mKY9LMAk=; b=T2nbs2c3FKP4ErDgz+JuZflDlokGOF5lvASvSpieMzwl1AibadWJ9hNG0DR7ACabT0HZ5Em6D4fPkvOv2n3/Enh67kH1StYZcooZfD8V4O1Kx39mcQaLqVcOL1R+/0XDPLhrPCf4KtB0YoKw7znyG6iddpcDLZ5fMRYdjaKkI5o=
X-Sasl-enc: 8HjXP5zrEDOdfEjMCZZdjCmxp/nocIGKzmGn9Rr72u1H 1284551488
Received: from localhost.localdomain (p54858CAD.dip0.t-ipconnect.de [84.133.140.173])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 552FC5E2659;
	Wed, 15 Sep 2010 07:51:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <201009151147.45314.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156233>

Thomas Rast venit, vidit, dixit 15.09.2010 11:47:
> Hi Christian
> 
> Christian Stimming wrote:
>>
>> As you might guess, as the (initial) translator of git-gui I've been  
>> through this discussion before [1] and as you have noticed, I have  
>> decided to take a translation approach different from what you have  
>> recently discussed here. I deliberately tried to translate as much of  
>> the terms into German as possible. I do not agree about the importance  
>> of statements on this mailing list like "This translation translates  
>> too much terms - I cannot find the commands I'm used to". 
> [...]
>> Instead, a translation is for people who do neither know nor  
>> understand the English wording for the git concepts. For this target  
>> audience, the goal is to find a set of terms for the different git  
>> concepts which makes the concepts most easily accessible for their  
>> language. This may or may not include terms which are left at English  
>> words.
> 
> Maybe there should be two sets of translations then.
> 
> I'm only half serious, but the problem here is what I said earlier in
> the thread (referring to Jan's draft):
> 
> } In any case it roughly matches (or still stays slightly on the
> } more-German side of) the colloquial usage in my group, if that is
> } any indication.
> 
> "My group" is a bunch of CS researchers, so I can't say they fall
> outside the description above.  However, in our work we observe a very
> funny split between translating and keeping the terms in English:
> 
>   graph                               Graph
>   vertex                              Knoten
>   edge                                Kante
>   directed                            gerichtet
>   DAG (directed acyclic graph)        DAG
>   independent set                     independent set
>   cut (vertex, edge)                  cut (vertex, edge)
>   degree                              Grad
>   matching                            Matching
>   tree                                Baum
>   MST (minimum spanning tree)         MST (minimaler Spannbaum)
> 
> There are German terms for all the untranslated ones, but I rarely
> hear them in practical usage.  Books probably go for a full
> translation since they want to be normative (how should I know, it's
> been a while since I used a German book), but lectures stick to the
> half-translated version.

Any active graduate student or researcher is used to English articles
and books and doesn't need a translation at all, or could do completely
with a translated glossary.

I assume we do the (extensive!) translation work for people who could
not use Git without a translation. And that mandates translating as much
as possible (including man pages...).

As far as the various disciplines go, CS is always on the side of
importing more terms from English rather than translating. If we agree
that a group of CS researchers is the target I'm fine with it - but it
would imply backing out l10n ;)

Note that I don't want to create any bad feelings against the l10n
efforts. If it is done then I want it to be done right and not rushed, a
bad one does more harm than anything. I probably won't be contributing
to translations of commands, but I'm in for the glossary to help it have
a sound start.

Michael
