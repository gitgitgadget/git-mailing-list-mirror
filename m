From: Scott Chacon <schacon@gmail.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 07:58:03 -0700
Message-ID: <CAP2yMaJz3-iX11vhbrTVasFD1zdwsdiDFKU7z7=an8pBoORk8w@mail.gmail.com>
References: <loom.20110921T002437-246@post.gmane.org>
	<CAFcyEtiexmE0WMif-eGHe5xMoYv7-8mdXos1qbQBH3g04z0sAg@mail.gmail.com>
	<CAGdFq_h0VqbZ5W3QVwoQWT63znhpePDFCRE+-n1TqPNztREwkA@mail.gmail.com>
	<F4C226A7-768D-4913-A6C1-12411FBA212C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Kyle Neath <kneath@gmail.com>,
	tom smitts <tomsmitts@ymail.com>, git@vger.kernel.org
To: Timothy Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 16:58:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6OFY-000893-Hc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 16:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1IUO6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Sep 2011 10:58:05 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37792 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1IUO6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 10:58:04 -0400
Received: by ywb5 with SMTP id 5so1197475ywb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1/ax1GTqB9Dnb1XbssuYdBicUaaKzMc81WBjtu0yN7k=;
        b=A4CJiP0pXGZSp5c0sB89xDdo6sJdFPIi2ZAkwDEj1+H+QNg3u+hbCy66cRpx8W9YSq
         cP8xL+TU5DOwmF88ZlUICAbgVPouOCEBJ0JEU6IPaTTLFLLt13Br6peOC49LXatj3+Np
         xVvwdvG00CBh8v9w5ynDu2OqGEJchPQ/z2Cxo=
Received: by 10.151.25.20 with SMTP id c20mr1060408ybj.253.1316617083140; Wed,
 21 Sep 2011 07:58:03 -0700 (PDT)
Received: by 10.150.212.13 with HTTP; Wed, 21 Sep 2011 07:58:03 -0700 (PDT)
In-Reply-To: <F4C226A7-768D-4913-A6C1-12411FBA212C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181848>

Hey,

On Wed, Sep 21, 2011 at 5:52 AM, Timothy Harper <timcharper@gmail.com> =
wrote:
>>> On Tue, Sep 20, 2011 at 3:40 PM, tom smitts <tomsmitts@ymail.com> w=
rote:
>>>> Do the git maintainers really think any mac users have
>>>> =C2=A0a clue which git install package to download? =C2=A0You
>>>> put some arcane chipset designation in the package
>>>> =C2=A0name!
>
> Good point, I'll update the description to include "32-bit" and "64-b=
it"

Honestly this doesn't help much.  I think the point is that these
numbers or machs are not in any of the docs or ads I can think of for
macs.  I feel pretty stupid admitting this to this list, but I
honestly don't know which macs are 32 bit - I assume the MBP is 64,
but if someone challenged me I'm not sure I could really defend it.

Not that I'm the smartest guy in the world, but I have been using *NIX
for a long damn time - it's just that Apple doesn't really use that as
much of a selling point - it's not like the old days when nerds like
us would buy the CPU at the store and it said "64-bit" on it - you buy
a mac, maybe you know it's a Core Duo or i5/i7 but how are you
supposed to know that means 64-bit?  I suppose a real geek would, and
maybe I've fallen out of that category somehow, but honestly chipset
has been so unimportant these days when compared to disk type and
speed (SSD, etc), memory size, etc - I just don't follow the
incremental improvements anymore.

Even I don't really keep up with the chipset specs to know - I can't
imagine anyone using the dmg installer instead of brew would have the
slightest idea what 64-bit even means.  And in our defense, the march
is nowhere on this entire tech spec page for a MBP:

http://www.apple.com/macbookpro/specs.html

So maybe you care enough to see that the chipset is an i7, so you
google it and end up on the intel i7 page:

http://www.intel.com/content/www/us/en/processors/core/core-i7-processo=
r.html

Nope, no march there either.  I had to specifically find the wikipedia
page for the processor which lists it:

http://en.wikipedia.org/wiki/Intel_Core#Core_i7

And 3/4 of the way down a huge page and only as a passing reference.

The point being - almost nobody that clicks on the DMG link from the
git-scm website is going to know what bit architecture they're running
on.


> Kyle, I'll put 32-bit and 64-bit in the description. Somebody mention=
ed linking to the featured download list as well in that issue, that's =
a good recommendation.
>

I link to the featured downloads from git-scm.com front page as the
huge mac icon - I assume that's where most people land when they're
looking for a mac installer. And on that page you have "Leopard" and
"Snow Leopard" on each download, which is WAY more common for people
to know.  What I should probably do is have a dropdown thingy on
git-scm that asks you what kind of mac you have and what OS you are
running (whatever I can't get from the browser info) and just
auto-download the right one so they never have to see the google
downloads page.  That would, however, take Google having an api or me
scraping that page, which I'll have to look into.

Scott
