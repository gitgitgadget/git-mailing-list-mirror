From: Andreas Ericsson <ae@op5.se>
Subject: Re: did anyone see my message re "git smart http server ..."?
Date: Sat, 18 Sep 2010 10:36:55 +0200
Message-ID: <4C947A27.6070102@op5.se>
References: <AANLkTikz8eKkXt7hsnR5nunq3Z8Ub5nvetctUsa1vOto@mail.gmail.com> <20100918032351.GA30282@LK-Perkele-V2.elisa-laajakaista.fi> <AANLkTi=-k_qWW2LuUGrq8U_8_cMLYVrMy6j5_s9zkyf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 18 10:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwsvQ-0007oy-4r
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 10:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab0IRIhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 04:37:04 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:48467 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755158Ab0IRIhB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 04:37:01 -0400
Received: from source ([209.85.215.49]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJR6KeZVcCrpomtdGz7O7lHenI4SDhaW@postini.com; Sat, 18 Sep 2010 01:37:01 PDT
Received: by ewy9 with SMTP id 9so1572336ewy.36
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 01:36:57 -0700 (PDT)
Received: by 10.213.108.194 with SMTP id g2mr651665ebp.2.1284799016861;
        Sat, 18 Sep 2010 01:36:56 -0700 (PDT)
Received: from clix.int.op5.se (fw1-sth-pio.op5.com [109.228.142.130])
        by mx.google.com with ESMTPS id u9sm7201165eeh.5.2010.09.18.01.36.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Sep 2010 01:36:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6 ThunderGit/0.1a
In-Reply-To: <AANLkTi=-k_qWW2LuUGrq8U_8_cMLYVrMy6j5_s9zkyf6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156437>

On 09/18/2010 05:26 AM, Miles Bader wrote:
> On Sat, Sep 18, 2010 at 12:23 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi>  wrote:
>> On Sat, Sep 18, 2010 at 11:18:20AM +0900, Miles Bader wrote:
>>> I sent a message to the git mailing list yesterday, with the subject line:
>>>
>>>    Subject:  git "smart http" server vs. http redirects
>>>
>>> Did anyone see my message?  Is there some kind of spam filtering on
>>> the list that might have eaten it...?
>>
>> I searched my own git mailbox, no match.
>>
>> The most important filter on mailinglist is that all messages even
>> containing HTML part are junked. There are also some forbidden words
>> (and word combinations) that cause message to be dropped.
> 
> yay.  Nothing like ad-hoc spam filters that silently drop messages!
> 

Replying to spam is actually worse, since it's impossible to know the
real source address of email. Many spammers used spamfilters to send
spam when the filters used to reply to spam.

Nowadays one usually gets a "here's some spam I'm not sure about" mail
every once in a while, but that's obviously not going to work for a
mailing list.

> My message contained some examples of an http output stream, i dunno
> maybe it's unhappy with some of that...
> 
> So... what is one supposed to do in this situation?  Randomly delete
> parts of the message and resend it until something gets through?
> 

Rephrase it, and possibly get rid of pasted output. I'm sure you've
seen enough spam to know what triggers spamfilters. Removing 'smart',
and especially 'git smart' from the subject line would probably be a
good idea. Levenshtein distance does matter, and 1 is not very far.
It's so very convenient to concatenate with just about anything if
you want to sell something to someone.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
