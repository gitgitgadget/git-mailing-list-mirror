From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 15:37:58 -0400
Message-ID: <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
	 <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
	 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>
	 <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLY6-0004mW-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab0CRTiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 15:38:05 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:60204 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0CRTiB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:38:01 -0400
Received: by qw-out-2122.google.com with SMTP id 8so455860qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ulKuZ7g7tuS3Xq/kGDYmY1QS7hW3mD0fv5ncM6qarvs=;
        b=WBfkFPXuubBHJRa9S3/+/0lTeLUkSuH9SRcxrHK91K7MErgtQi1/juI5WlXkGZ2G11
         P2TLdXIFJ6PQQqMYsykI4iQDsBB4bNRxs3oN7anRWm9am6VfHjWRhUqN4sZJ3uSB/wBy
         28OugZw/V2ES66EtCZP7yYdcnmXGbH7jQVEWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IfQteHhcYUFhUsKl/sqpwyUyKfRqMocVXXucFNStHQohryxN/H8pJilW037yVfGyUh
         QONzoPrTDY68FqcfJj9a2j9TS03GswggnwhY/O0C1XWWllFY++2c5NWTGzVuCGet2z+f
         v/tJLePcnZaN9Uu+IatvDGkX2pYn79rqdfYpQ=
Received: by 10.229.235.1 with SMTP id ke1mr837074qcb.3.1268941078515; Thu, 18 
	Mar 2010 12:37:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142503>

On Thu, Mar 18, 2010 at 3:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 18 Mar 2010, Jon Smirl wrote:
>>
>> I happen to think that the concept of privacy and working on an open
>> source project are fairly incompatible. But apparently their are
>> people who think otherwise. =A0The use would be to reconstruct that
>> mailmap I made, but with the email addresses replaced with SHA1 hash=
es
>> of the email. No human would use the SHA1s, they're just there to
>> obscure the emails.
>
> I really see that as a bad thing, not a good thing. It's like enablin=
g
> some crazy shit and making it official.
>
> If you don't want to reveal your real name, use a fake address. Just =
don't
> expect anybody to want to work with you.

Go ahead and commit that .mailmap I made. It really cleans up the
statistics by fixing 500 errors is people's names. Just don't point
the ensuing flame war at me, your hide is tougher.

> The LAST thing we want is built-in git support for doing f*cking stup=
id
> things. =A0You can do stupid things with it on your own without us he=
lping
> and encouraging you.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>



--=20
Jon Smirl
jonsmirl@gmail.com
