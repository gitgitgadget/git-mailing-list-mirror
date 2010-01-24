From: =?ISO-8859-1?Q?Andr=E9_Harms?= <andre.harms@kuhlsolutions.de>
Subject: Re: Modern Git GUI
Date: Sun, 24 Jan 2010 21:43:31 +0100
Organization: 
Message-ID: <e39c1dcf1001241243r38b187b1tcb44b607b7cba8d9@mail.gmail.com>
References: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
	 <vpq636resro.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 24 21:44:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ9KK-0001Be-AR
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 21:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab0AXUnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 15:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900Ab0AXUne
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 15:43:34 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42177 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab0AXUne convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 15:43:34 -0500
Received: by bwz19 with SMTP id 19so2229669bwz.28
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=m6qIVzE33RWi23ftYqnXWC/z+DU0yxDemzOAte72fKA=;
        b=oK3OO3PJfZUF/zAnqJG1YL43Tv2ueGo+RC9nvVrX7M3x8ICt0rC42sXNg2Gdh9kDZr
         rkwwbJ2uxr2GxLp4L/pQCN/5iAx3CWvlL9PdlP8FU6hhQjoaqpu8aoFblo3Y9MIjZIGm
         gSGsa3GV6IP9hOaHBMzbOEvodOLq/31qrk8sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=HxItXyK36ngUOq2vyA2gXRDxy5Ipo5oEx+rOFK20n9VnnLMX2KCTJjVnno/1XP9Cep
         zdUUH3VTO1IX0bzjlf2uq1m3QcnVANdpixOevPkKR/8nDN8jT1/S6VetPhWAxmpxsVGJ
         vV0A89KqGlFO9N7UH0f9KqtaYtGRZ1lZsdvZ8=
Received: by 10.204.8.151 with SMTP id h23mr3140605bkh.194.1264365812113; Sun, 
	24 Jan 2010 12:43:32 -0800 (PST)
In-Reply-To: <vpq636resro.fsf@bauges.imag.fr>
X-Google-Sender-Auth: 230733293ec7eaa2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137918>

2010/1/24 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Andr=E9 Harms <andre.harms@kuhlsolutions.de> writes:
>
>> So I thought about developing a new kind of GUI for Git that looks
>> modern and attractive
>
> Every once in a while, someone comes and says "Git GUIs aren't as goo=
d
> as I'd expect, I'll write my own". The result is that we have a myria=
d
> of GUIs (see
> http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Grap=
hical_Interfaces ),
> many of them being half-finished and/or abandonned. I don't believe
> adding yet-another-one is going to improve the situation, and
> pick-one-and-improve-it is IMHO a much better approach.

Basically I agree with you. And I think you're right that yet another
one won't improve the situation immediately.
I've to admin, that I didn't think about that very much. So I have to
rethink my plan. But my concept is different than the one of other
GUIs.

>> (you know... some eye-candy stuff) and that is easy to use.
>
> I use mostly the command-line, so I couldn't make a detailed review o=
f
> the existing, but tools like git-cola and a few others sound "modern"
> to me (Qt4 & co).
>
> If you decide to go on with your project, either you want to carry it
> out alone, or you'll have to convince other developers to join. In th=
e
> second case, a good starting point would be to explain why the other
> GUI are not good enough, and why you can't just contribute to them.

If I decide to go on anyhow, I'll work those things out clearly.
Thanks for the tip.
In my opinion other GUIs aren't intuitve for first-time users and
aren't as good for experienced users as the command-line. But a GUI
_can_ be helpful for experienced users as well. So there's a hole that
can be filled. And my concept is based on a hybrid GUI that also
offers a command-line for experienced users. So actions that are made
with the built in command-line (console) are visualized. That also
might be good for beginners who like to use the command-line but are
afraid of using it.
If I go on I'll probably use Clutter as GUI toolkit. With it one is
able to create real good looking GUIs (though it's not a guarantor for
a good GUI).

Thanks for your opinion.
