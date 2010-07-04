From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Sun, 4 Jul 2010 13:14:45 +0200
Message-ID: <201007041314.50591.jnareb@gmail.com>
References: <201007032158.57700.jnareb@gmail.com> <AANLkTimbpOEpi8QOqTOMav0whmLeHz3vQq_0KDnblRIK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Bainbridge <david.bainbridge@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 04 13:15:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVNAP-0004vI-WF
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 13:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab0GDLPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 07:15:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47535 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab0GDLPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 07:15:00 -0400
Received: by fxm14 with SMTP id 14so3122582fxm.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 04:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kpnLjyHLNZyxOxuaspHlxrAfsEgGE2nD/ElXhngrB1M=;
        b=AMcuBJ1pdQBOsK59mSbrKl67tOADK1PCunpMgfO+aFsx1euO5wCX2CfPJ82yqfRKWA
         OTrEdmBcbS9iANQXoonbQSHEQuhvLqC8zR+OoATiLSAPwMgsArVuY3bAhskKMbkxagDE
         8nkx84sYEkpFycqLMQqP/LSa5hEKBwclppJmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Li83+BCRsWNFJu+15njIJ8rxQpuavlq10GzZc0xx/JSjxPweaOZN27YJnWXMbEdd19
         GSkUkuaEdN3otYhTaM+41Pfhf+QFY3rivJyq9gDfxTPpHtrzgGJfaTTnRm8ECqQYFLhm
         t+MMLEsKO8yLjSaNBTkAAxAl2fvVlKsNr9Iic=
Received: by 10.223.115.194 with SMTP id j2mr1032286faq.60.1278242098613;
        Sun, 04 Jul 2010 04:14:58 -0700 (PDT)
Received: from [192.168.1.15] (abvt37.neoplus.adsl.tpnet.pl [83.8.217.37])
        by mx.google.com with ESMTPS id q8sm6320601faa.34.2010.07.04.04.14.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 04:14:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimbpOEpi8QOqTOMav0whmLeHz3vQq_0KDnblRIK@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150223>

On Sun, 4 July 2010, David Bainbridge wrote:

> First, as someone working in a company that is adopting Git can I say
> that I found the results of previous surveys useful? So I think that
> these surveys should continue :-)

Thank you very much for the words of encouragement.

> I think that the reduction of free text fields is good ... I am
> concerned that if I point several hundred users at the this survey and
> encourage them to respond that you should not get swamped!

I had idea of running some kind of natural text processing analyser
for analysis of free-form responses[1], but nothing came out of this
(currently).

[1]:http://stackoverflow.com/questions/887954/how-to-categorize-and-tabularize-free-form-answers-to-a-question-in-a-survey

> 
> The surveys are actually useful for making people more aware of what
> Git can do, and the other tools associated with Git, so this is
> something of bear in mind.

Well, this year there is no question about how often one uses specified
git commands.  In my opinion it made responding to survey too long, and
it was not balanced by people learning about new commands, I don't
think.

> Have you considered the question: 'How long have you been using Git?'.
> This combined the expertise level might yield some useful information,
> and could provide some weighting for the 'Getting started' questions
> too. There are some problems with the question in that it could be,
> say, 2 years intermittent use, or 2 years continuous use, and these
> are different, of course.

Well, such question was replaced by the question about one's own
proficiency in Git in 2009 survey (IIRC).

> > === 06. Rate your own proficiency with Git: ===
> > (single choice)
> >
> >  * 1. novice
> >  * 2. casual, needs advice
> >  * 3. everyday use
> >  * 4. can offer advice
> >  * 5. know it very well

The problem with question "How long have you been using Git?" (beside
what you have mentioned) is that it is hard to answer correctly / in
detail for longer times.

Perhaps something like this:

=== xx. How long have you been using Git? ===
(single choice, with other)

 * less than week
 * between a week and a month
 * a few months
 * a few years
 * duration (please give units)

What do you think?

> The demographic information is useful if you want to understand
> whether Git is (for example) considered less usable in countries where
> English is not the native language. But then if you want to know the
> native language of the user rather than where they live then perhaps
> this should be asked? (I was born in the UK, but now live in Sweden
> ... so I am perhaps more conscious of this!). Where you are born does
> not necessarily identify your native language either.

The problem with this question in the past was twofold: first, people
sometimes mistok it for question about _programming languages.  Second
should this question be about primary language / languages, or about
language ones prefer the computer to communicate with?
 
> Do you want to separate work usage and 'non-work' usage at all? The
> two experiences may be completely different. If I am working at home I
> can use what ever I want, and work how I want. This will probably not
> be the case in a corporate environment, so I would report one set of
> results for 'work' and another for 'non-work'. This could generate two
> survey returns for a single user. Is this intended?

Hmmmm... food for though.  It can be mentioned somewhere close to
beginning that one can fill this survey more than once (from different
computers if using default version with cookies) for different roles
one plays.  Perhaps with checkbox "additional role" (aka. "I have already
filed this survey" ;-))...
 

> Just a couple of thoughts :-)

Thanks a lot for your comments.  I appreciate it.

-- 
Jakub Narebski
Poland
