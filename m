From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Is this an appropriate list for general git questions
Date: Sat, 27 Mar 2010 18:29:46 -0400
Message-ID: <32541b131003271529x6d6f8b03g18cbf9949d49a574@mail.gmail.com>
References: <5C4288BC-B87E-41CB-B3CB-90122098B7E9@newgeo.com> 
	<32541b131003211736t823ea8cye7ab4075fa8ccdd5@mail.gmail.com> 
	<0D0DD5C5-B535-49AC-B0A9-403C4FA5E193@newgeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Scott Haneda <talklists@newgeo.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NveWF-0004nc-41
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 23:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab0C0WaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 18:30:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55817 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0C0WaH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 18:30:07 -0400
Received: by gyg13 with SMTP id 13so737625gyg.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9Kj74Klx3HIM3J0+lHmSm+mD6+hfHu59tdwrgJGjZOA=;
        b=l9f3HClruW2Gq1BeqjPJliw+mRaa/67p292kBNwcuNJxlDS1hhfAz1GACcQbiuwX0R
         B/d2YNgn66sZkQEonFeAdjXqsW67ejfDAsEQ0IEyfzHPSTaX+zclX/r5Qkm1bPBrC7R/
         MIVzXX6bariUvVUMLDfUzGy7IqnGW7yIfNp0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bhexpSeStH7NZS+iHsYDqOkOFhT86hBMKKgyGSgQiBqoQkBe5oQt+lzUA3VMo/2IcE
         aCBw3uTPHkBbE7rvlCGPMDxtxJx4eEHSQxhgepXS9U7jZUyd3VOa1qerC9bScdQJIxA0
         sUBFcyKGbRD7CjkEn45P8vqof/zATngl4AUOk=
Received: by 10.151.51.17 with HTTP; Sat, 27 Mar 2010 15:29:46 -0700 (PDT)
In-Reply-To: <0D0DD5C5-B535-49AC-B0A9-403C4FA5E193@newgeo.com>
Received: by 10.150.141.2 with SMTP id o2mr1117403ybd.332.1269729006086; Sat, 
	27 Mar 2010 15:30:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143362>

On Sat, Mar 27, 2010 at 4:07 AM, Scott Haneda <talklists@newgeo.com> wr=
ote:
> On Mar 21, 2010, at 5:36 PM, Avery Pennarun wrote:
>> By the way, this mailing list accepts posts from non-subscribers, an=
d
>> it's the policy on the list to always cc: everyone who has replied t=
o
>> a message in that thread so far, including the original poster. =A0T=
he
>> idea is that you can ask a question about git without *having* to
>> subscribe to read all the other stuff. =A0But of course, reading som=
e of
>> the other stuff will make you a more competent git user pretty fast,
>> so it might be worth it anyway.
>
> Interesting, I have never once in 15+ years of mailing lists, seen a =
list work this
> way. =A0Pretty nice to not have to subscribe. =A0Amazing that there i=
s not spam all over this list.

I'm guessing they just use a good spam scanner.

>> You should probably look at getting a good book on version control.
>> You can find *these* using Google, including free online ones, now
>> that you know this is what you should do :)
>
> Ok, I will look into it. =A0I am really hoping there is a "4 command =
to using
> git" type of thing. =A0I think I even heard that Joel Spolsky guy sta=
te
> something along those lines; that he has gotten by with version contr=
ol
> on 4 commands. =A0I can not remember if it was git he was referring t=
o though.

No, it was mercurial.  As I recall, he then went on to decide that
trying to use it with only four commands wasn't the right approach and
you should actually learn about it, and wrote a series of tutorials.

It's generally agreed (though perhaps not among everyone on this list
:)) that mercurial is easier to learn at first than git.  However, in
my experience, once you've spent the time to learn how git works, you
also gain a lot more than with any other system.  It's ridiculously
powerful, in the same way that Unix is powerful.

Then again, if you're running on a Mac, there are some GUI-based git
tools available.  I've heard good things about GitX, though I haven't
tried it myself.

>> source code almost never *needs*
>> these resource forks: only finished products do, and those are usual=
ly
>> built *from* the source code. =A0As part of the build process, you a=
dd
>> the resource forks and xattrs onto the completed files.
>
> Yes, very true, except in the case of AppleScripts and Automator acti=
ons.
>=A0Which can be "compiled" and finished apps, but also can be raw sour=
ce files.
>=A0However, I believe that even those, being that they run in their ow=
n development
> environment, have resources and other attributes that have to be main=
tained.

As I understand it, almost everything in OS X avoids requiring
resource forks nowadays.  You'll probably be okay.

Have fun,

Avery
