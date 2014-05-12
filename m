From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 02:42:17 -0500
Message-ID: <53707b5955034_2b5710592f8aa@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <CA+55aFwf9iAKxbvdPV9Up_T709KwBXJWW4g-F829CRQP4YkivQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Dusty Phillips <dusty@linux.ca>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Christophe Simonis <christophe@kn.gl>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 09:42:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjksX-0001UD-GT
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 09:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbaELHmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 03:42:25 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:54291 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbaELHmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 03:42:24 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so7677138oac.22
        for <git@vger.kernel.org>; Mon, 12 May 2014 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zyw1KYc2Z6Oddl2WUzfm87otVVckVsCZnoRw5MpFeno=;
        b=S3DF7XziD0mM128b8d6Ixi3y9BRCNzYaWifa5In+YtQoh1D/Cuo3hrQjiIcyvHDV/g
         ZAe2h91flwI6ni5/XfhI6dvB5+xiMB9GvUyBDcJtmJRZSXG7WJ+f8W6JGgxup5asjyhw
         DdJRegcD1k5lGgyGzQrqaMm08XPSQThhJrx742MaaL6v6Mbdye+Ud64MFpGbX5xK2xzj
         cJD17oXAgEFJNOfdG1ESJYIPF6u3odLXUq9cBadbmObH4t6HnHmZk4iQK1LM8oEBtfpx
         VOyXfSjTqd0OXOpRnaO/eFsFqrBnZGkjALdikApVMtgaByf5v3/oQTutNKqA/P1mh80p
         nJQQ==
X-Received: by 10.182.205.135 with SMTP id lg7mr31399627obc.32.1399880544370;
        Mon, 12 May 2014 00:42:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id fk10sm18938927obb.24.2014.05.12.00.42.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 00:42:23 -0700 (PDT)
In-Reply-To: <CA+55aFwf9iAKxbvdPV9Up_T709KwBXJWW4g-F829CRQP4YkivQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248691>

Linus Torvalds wrote:
> On May 12, 2014 8:35 AM, "Felipe Contreras" <felipe.contreras@gmail.com>
> wrote:
> >
> > This move is already
> > under way, but suddenly Junio changed his mind.
> 
> That "suddenly" wouldn't have anything to do with you being an ass and
> difficult as usual, arguing about everything and just generally being
> contrary?

No, here's where the thread started (A):
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248167

Here I wasn't being an ass:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248186

Here I wasn't being an ass either:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248171

Neither here:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248146

Nor here:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248195

Nor here:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248205

Not an ass here:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248213

And not here either:
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248236

Then Junio *suddenly* changed his mind (B):
http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248242

That is the sequence of mails (A..B) where I responded, and I wasn't an
ass in eithe one of those, so whatever made Junio change his mind
happened in that interum, and it wasn't me "being an ass".

I bet you made that statement without even botherting to read the
thread. Go on, read the thread, tell where exactly me "being an ass"
made Junio change his mind from A, to B.

Nah, you wouldn't do that, backing up your claims take time, and you are
not willing to spend time on this issue. Even if you were to try to back
up your claim, you couldn't, becasue it's not true. It's much easier to
just throw good sounding baseless claims and walk away.

> Felipe, stop this stupid blaming of everybody but yourself.

Show me evidence that this decision was my fault. Junio certainly hasn't
said so. You just have no idea what we are talking about.

> You make absolutely everything be this horrible disaster, you redefine
> words ("regression") to be whatever you need/want them to be to be

git-remote-hg and git-remote-bzr will likely break in Git v2.0 in certain
situations where they wouldn't in v1.9, or v1.8. Call it whatever you
want. I call that a regression.

> Seriously. Don't try to make this about Junio somehow being the problem.

So Junio is perfect. Got it.

If you don't have the time to actually read the rationale behind Junio's
decision, how would you even know he made the right one? You are just
blindly assuming he is right, and therefore he is not the problem.

What if he was wrong? Nah, that's impossible. Right?

-- 
Felipe Contreras
