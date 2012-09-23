From: knittl <knittl89@googlemail.com>
Subject: Re: Message from 'git-rebase'; German translation
Date: Sun, 23 Sep 2012 17:36:08 +0200
Message-ID: <CACx-yZ25jXW482b3UQ=2LAvpFAfe+NRvnRA+QS6xmwmq6MgYvQ@mail.gmail.com>
References: <1527028.GPe6zkelBV@blacky> <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 17:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFoEa-0001ev-IV
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 17:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab2IWPga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2012 11:36:30 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44526 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab2IWPg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 11:36:29 -0400
Received: by wgbdr13 with SMTP id dr13so2941404wgb.1
        for <git@vger.kernel.org>; Sun, 23 Sep 2012 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KxuIxREIKMG9QiuWQ5vRJANreKtcWDkSwZCDaj6FdNM=;
        b=dOX2SQVvXuU3YmFDk81yzB2SScCXY0AjwL0aZXLe+aLfEuqWCMxxQWHK93FEXJ+Uj7
         qdRcxhoKkRO0ux93nEvoZEX3pgnsPBkc3tFvmyb9oRoDGdaIG0/QGnjY4ddudVp/I0fP
         hds5i37tyzs2/hpp1OoZ1E4Ufi+3ckOjsx9EunhojNnahPW4oLrbmeUdPXHjFahSlqDl
         YoDOyZPNgqxf4RqyQ1SAAcwTdtzAyNCc/CTjdQlFBP79ewnkY91ckTWToJkO2c5icVJ1
         9VHcWcXWdzByE1dOXd18uqC0FC6QlTjbGycc/OshNl+u5X40VGDOW4HW5FdewxgffcE0
         ZW3A==
Received: by 10.216.143.233 with SMTP id l83mr5903947wej.167.1348414588630;
 Sun, 23 Sep 2012 08:36:28 -0700 (PDT)
Received: by 10.194.22.198 with HTTP; Sun, 23 Sep 2012 08:36:08 -0700 (PDT)
In-Reply-To: <CAN0XMO+Dd9S7j9Ujudcy+O3GwwBX1CvRPQTYWxymmEu=2bg7ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206242>

Sharing my thoughts on this one, =85


On Sun, Sep 23, 2012 at 5:04 PM, Ralf Thielow <ralf.thielow@gmail.com> =
wrote:
> On Sat, Sep 22, 2012 at 11:57 PM, Sascha Cunz <sascha-ml@babbelbox.or=
g> wrote:
>> However, git-rebase just threw these two sentences at me (And though=
 i know
>> their meaning, i couldn't get the meaning from the message, it gave)=
=2E Both are
>> in context of starting a rebase while one is already in progress.
>>
>> first is:
>>
>> Original:
>> ... and I wonder if you are in the middle of another rebase.
>>
>> German git translation:
>> ... und es w=E4re verwunderlich, wenn ein Neuaufbau bereits im Gange=
 ist.
>>
>> And a re-translation back to English from my understanding as native=
 German
>> speaker:
>> ... and it would be astonishing (=3Di'd be surprised), if a rebase w=
as already
>> in progress.
>>
>
> We try to avoid translating terms like "I wonder if.." and similar as
> "ich wundere mich", because it's very unusual in German messages
> of computer programs. Translators should have the freedom to reword
> terms a bit to make a more optimal translation, but the meaning must
> not be lost, and I can't say that this is the case.
> Translate the term "in the middle of"  word-by-word would result in
> "in der Mitte eines", which can be interpreted as a place somewhere
> or that an action is in progress. To avoid a possible confusion, we
> decided to translate this term as "im Gange sein" ("be in progress") =
in
> the whole translation. I also think that "in der Mitte einer Zusammen=
f=FChrung
> sein" doesn't sound really good. It tends to mean a place, not an act=
ion.

What about a simple "Eventuell wird bereits ein andere
Neuaufbau/rebase ausgef=FChrt"?

And, iirc, "I wonder if" translates to "Ich frage mich, ob =85"

>> And second:
>>
>> Original:
>> I am stopping in case you still have something valuable there.
>>
>> German git translation:
>> Es wird angehalten, falls bereits etwas N=FCtzliches vorhanden ist.
>>
>> I wanted to point out that "etwas N=FCtzliches" is more "something u=
seful" that
>> "something valuable". But the more I thought about it, the more it s=
tarted to
>
> I've been thinking about possible different translations, and the onl=
y
> one I have in
> mind is "wertvoll". But translating "valuable" as "wertvoll" ("bereit=
s
> etwas Wertvolles
> vorhanden") sounds a bit like "we've found a treasure", instead of
> something which
> has a value in the meaning of content. I think having a translation
> which is more
> like "useful" than "valuable" does also hit the point of the message,
> doesn't it?

What about "wichtig"? I think that transfers the meaning pretty well.
"Es wird angehalten, um den Verlust wichtiger Infos zu vermeiden"
maybe?

I hope the above spends some inspiration :)

Cheers,
Daniel

--=20
typed with http://neo-layout.org
