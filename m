From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 11:54:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> 
 <471476B7.5050105@users.sourceforge.net>  <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
  <47148F72.1090602@users.sourceforge.net>  <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
  <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
  <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> 
 <1192565900.6430.16.camel@athena>  <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
  <20071017015109.303760cc@localhost.localdomain> 
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> 
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> 
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <1192645509.6640.21.camel@athena>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tom Tobin <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiE2n-0005vf-DV
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 20:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbXJQSyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 14:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbXJQSyt
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 14:54:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57747 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753131AbXJQSys (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 14:54:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HIsBsV017490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 11:54:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HIsBCh002885;
	Wed, 17 Oct 2007 11:54:11 -0700
In-Reply-To: <1192645509.6640.21.camel@athena>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61407>



On Wed, 17 Oct 2007, Tom Tobin wrote:
>=20
> Or is "unix developers" code for "my sample size of one"?

Well, let's put it this way: that "sample" is the one that started the=20
project.

I got to pick the license. Are you going to argue about that too? I got=
 to=20
pick the way I wrote the code. Are you going to continue arguing about=20
that?

The fact is, I don't see the people arguing for spaces having actually=20
*done* anything for git. So why are you arguing?

> Interesting how you waver between "certain developers" and "me".  I'm
> convinced at this point that your argument comes down to "I can't use=
 my
> favorite text editor with all-spaces, therefore all-spaces sucks".

Umm. And I've *told* you that.

The whole point is:
 - every single damn editor out there can handle tabs.
 - it's the default
 - end of story.

What's so hard to understand?=20

> As for *disk space*?  When we can measure cheap drives in sizable
> fractions of *terabytes*, this simply isn't a serious argument.

That disk-space translates into memory usage too, and into just being=20
technically the *inferior* choice.

How hard is that to accept? If you have a choice between a technically=20
better solution, and a technically worse one, why are you arguing for t=
he=20
worse one?

> Yeah, can you believe some projects actually *survive* with an
> all-spaces indentation rule?  And ::gasp:: even *thrive*?

Hey, I=CD=84'm not saying that others shouldn't use spaces. I'm saying =
that=20
*git* should not, the same way the Linux kernel does not and will not.

Why? Because tabs are better. You (or anybody else) have simply never=20
given any argument against that very simple argument. You try to push a=
n=20
inferior solution.

> Problems have been outlined, but since everything for you comes down =
to
> "anything that comes between me and microemacs sucks", rational
> discussion breaks down.

Don't talk about "rational discussion", since you don't even *have* any=
=2E

The starting point for any rational decision would be to explain why=20
changing tabs to spaces would actually improve anything at all. And you=
=20
have yet to show *any* such argument, while I've shown arguments to the=
=20
reverse.

One big one being: the person who started the project and still actuall=
y=20
*does* something for it actually cares.

In contrast, your argument seems to be "I've not actually done anything=
,=20
but I want to paint the bikeshed pink".

		Linus
