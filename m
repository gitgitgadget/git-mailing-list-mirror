From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: Trailing spaces in branchname (git-svn)
Date: Wed, 15 Jun 2011 16:38:15 +0200
Message-ID: <BANLkTikgF53tKbUsJJznENAiW8Smm5ePPA@mail.gmail.com>
References: <0014af8a-3b24-4398-88aa-7a3e460f2283@s11g2000yqh.googlegroups.com>
 <AANLkTinZnd0R8Rnv4kaiJAGP0qKEwgbU+nP=donmbEbp@mail.gmail.com>
 <12ada6de-4345-4259-b832-371a74df9775@l6g2000vbn.googlegroups.com>
 <BANLkTikaeXxRMJErAYy3-LSrvfNZXAbEEw@mail.gmail.com> <b8767de1-ab2c-4d2a-9024-9ad9b29c614d@j9g2000vbs.googlegroups.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Barthus <magnus.kallstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 16:39:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWrFF-0001xN-IP
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 16:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab1FOOi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 10:38:56 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62257 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246Ab1FOOi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 10:38:56 -0400
Received: by pzk9 with SMTP id 9so288433pzk.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2gQRUmHtlzH9LRneWMKvEAMI+4q6+K5+tdFkiDIeohw=;
        b=BcbgnAdJlhJ50SCe0qpx+OWUg5PVhF02EFotj+TSVDQEuhHNQex2/3NrJkqryFUCuQ
         BFRo+BnpCCwMrQCnK2j65oHbj5jPZRGceRv6MpWatjSrfBoVjBR4K2RvN4pGRngSeLPq
         254WPey7Q/8D4pjKGobAj4d2csL/4Q5Osdc1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=kk3e1Ib1uwXjXpYkfPqi+x+YE1LUx/2Kz4SkQI9gN0tL854Ff8TCUmaR+4+Cr1eOcY
         4qs5swg4HnpMtwkUun24w0zCOoKEeshDwDX+F/r/yxYdelfbD99/OP1et0wnUj4Y/XNb
         R0nv70G70bWTxEl+W/KePKOV7YniqTX3/+KRE=
Received: by 10.68.71.165 with SMTP id w5mr315422pbu.101.1308148735533; Wed,
 15 Jun 2011 07:38:55 -0700 (PDT)
Received: by 10.68.50.197 with HTTP; Wed, 15 Jun 2011 07:38:15 -0700 (PDT)
In-Reply-To: <b8767de1-ab2c-4d2a-9024-9ad9b29c614d@j9g2000vbs.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175836>

Again, please don't cull the CC-list. When replying, hit "reply all"
in your e-mail client.

Also, please don't top-post either. It makes it harder for others to
follow the discussion. I've corrected the quoting this time.

On Wed, Jun 15, 2011 at 4:12 PM, Barthus <magnus.kallstrom@gmail.com> w=
rote:
> On 15 Juni, 16:00, Erik Faye-Lund <kusmab...@gmail.com> wrote:
>> Please don't cull the CC-list.
>>
>> On Wed, Jun 15, 2011 at 3:38 PM, Barthus <magnus.kallst...@gmail.com=
> wrote:
>>
>> >> This kind of question is usually better to ask on the main Git ma=
iling
>> >> list, as it's not really Windows specific.
>>
>> > I found a similar (older) thread in the git-mailing-list, discussi=
ng
>> > the same issue. This led me to try cloning the same repository on =
a
>> > Linux-machine - with success. Linux (at least my distro - Ubuntu)
>> > handles trailing spaces in directory names.
>>
>> > Isn't this a msysgit-issue? (I just want to make sure that I don't
>> > spend my (and your) time in the wrong place)
>>
>> If it works on Linux then yes, it's probably a Git for Windows issue=
=2E
>>
>> Some quick testing reveals that paths can have a trailing space on
>> Linux, but not on Windows. It sounds to me like you need to modify t=
he
>> refname subroutine in git-svn.perl to escape this. Something like th=
is
>> seems to work for me:
>> ---8<---
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 7849cfc..7a44145 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -2126,6 +2126,9 @@ sub refname {
>> =A0 =A0 =A0 =A0 # @{ becomes %40{
>> =A0 =A0 =A0 =A0 $refname =3D~ s{\@\{}{%40\{}g;
>>
>> + =A0 =A0 =A0 # trailing space is not not allowed on Windows
>> + =A0 =A0 =A0 $refname =3D~ s{ $}{%20};
>> +
>> =A0 =A0 =A0 =A0 return $refname;
>> =A0}
>>
>> ---8<---
>> If it works for you, I'll submit a proper patch for it.
>
> Ok, thanks. I'll try as soon as possible (will be away for a few
> days...)
>

You might want to try this patch instead, as it deals with refnames
like "foo /bar" and "foo \bar" also:

diff --git a/git-svn.perl b/git-svn.perl
index 7849cfc..54894e4 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2126,6 +2126,9 @@ sub refname {
 	# @{ becomes %40{
 	$refname =3D~ s{\@\{}{%40\{}g;

+	# trailing space is not not allowed on Windows
+	$refname =3D~ s{ (?=3D/|\\|$)}{%20}g;
+
 	return $refname;
 }
