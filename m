From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 1/2] Change old system name 'GIT' to 'Git'
Date: Sun, 20 Jan 2013 19:53:03 +0100
Message-ID: <kdheeh$ntf$1@ger.gmane.org>
References: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net> <379071741.1327695.1358589560822.JavaMail.ngmail@webmail24.arcor-online.net> <CAJDDKr5_AWFF6MR2Kwt5FzA0vaSE-wx8xFO3xcRnKZ168hXBrg@mail.gmail.com> <7vehhfn1r0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 19:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx01a-0004U0-F6
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab3ATSxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 13:53:25 -0500
Received: from plane.gmane.org ([80.91.229.3]:40037 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab3ATSxY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 13:53:24 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Tx01S-0004RH-NM
	for git@vger.kernel.org; Sun, 20 Jan 2013 19:53:38 +0100
Received: from dsdf-4db5faaa.pool.mediaways.net ([77.181.250.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 19:53:38 +0100
Received: from jojo by dsdf-4db5faaa.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 19:53:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5faaa.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214031>

Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> On Sat, Jan 19, 2013 at 1:59 AM, Thomas Ackermann
>> <th.acker@arcor.de> wrote:
>>> @@ -55,7 +55,7 @@ History Viewers
>>>
>>>     - *gitweb* (shipped with git-core)
>>>
>>> -   GITweb provides full-fledged web interface for GIT repositories.
>>> +   GITweb provides full-fledged web interface for Git repositories.
>>
>> What about GITweb?
>>
>>> diff --git a/Documentation/git-update-ref.txt
>>> b/Documentation/git-update-ref.txt index d377a35..0df13ff 100644
>>> --- a/Documentation/git-update-ref.txt
>>> +++ b/Documentation/git-update-ref.txt
>>> @@ -73,7 +73,7 @@ in ref value.  Log lines are formatted as:
>>>  Where "oldsha1" is the 40 character hexadecimal value previously
>>>  stored in <ref>, "newsha1" is the 40 character hexadecimal value of
>>>  <newvalue> and "committer" is the committer's name, email address
>>> -and date in the standard GIT committer ident format.
>>> +and date in the standard Git committer ident format.
>>
>> IMO some of these look nicer when everything is lowercase.
>> e.g. "standard git committer ident format".
>
> I do not think we ever intended to change the *name* of the
> software.
>
> In the early days, we wrote GIT in places where, if we were doing a
> fancier typography, we would have used drop-caps for the latter two
> (i.e. it is "Git" spelled in a font whose lower case alphabets have
> the same shape as upper case ones but are smaller).  So there were
> only "git" vs "Git".
>
> If I were to decide today to change the spellings, with an explicit
> purpose of making things more consistent across documentation, it
> may make sense to use even a simpler rule that is less error-prone
> for people who write new sentences that has to have the word.  How
> about treating it just like any other ordinary word?  That is, we
> say "git" (without double-quotes, of course), unless it comes at the
> beginning of a sentence?

Because then it could get confused with "git", the command? That would be 
lower case even at the beginning of a sentence, wouldn't it?

Bye, Jojo 
