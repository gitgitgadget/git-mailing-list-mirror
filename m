From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Fri, 1 Aug 2008 14:45:15 +0400
Message-ID: <37fcd2780808010345l755b83a5gff8a5aa350016ad5@mail.gmail.com>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	 <20080729170955.GK32184@machine.or.cz>
	 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
	 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
	 <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vy73j418t.fsf@gitster.siamese.dyndns.org> <4891A0D0.6060503@lyx.org>
	 <20080731225703.7be6f76e@neuron> <4892C042.20302@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Jan_Kr=FCger?=" <jk@jk.gs>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Scott Chacon" <schacon@gmail.com>, "Petr Baudis" <pasky@suse.cz>
To: "Abdelrazak Younes" <younes@lyx.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 12:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOs9L-00015t-MZ
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 12:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbYHAKpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 06:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbYHAKpR
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 06:45:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:36344 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYHAKpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 06:45:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1343579wfd.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gYoK084NPBst9hoo9szl63Sal4HPQ/0DXBEouBZ5ltk=;
        b=QC/st+OL5Bp3/JshUbToZenFALuP0dUf/PUWqftvI6T9ZJv6BpdCAb2G0AAY8P2i+y
         btbijlu6w3/CFaVm9SfJwsdNiFJ1lNKKjym6qyNX03OeV6A/dPLMANkUbQEEwLN11M6a
         IA1OqdQ/udU6sKWozH+2EZIlqGz1uy+cya2Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kzDJe6DefU0rfLk88U3I1+z8QjpjWE/DtAqFgJhxJO4UtnBVbyLg5ljous9R3uWKW4
         1K2c1F9kk6cPofizZc1PTO4FCNN/P7pBN57PVpVyd47ciT4sqEI5hXPnERjgQgSN2Yfg
         Y6vWcIuo58tUoatUk4Z8oXtZUf7I32Lqm0JmM=
Received: by 10.142.199.16 with SMTP id w16mr3689063wff.268.1217587515068;
        Fri, 01 Aug 2008 03:45:15 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Fri, 1 Aug 2008 03:45:15 -0700 (PDT)
In-Reply-To: <4892C042.20302@lyx.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91053>

On Fri, Aug 1, 2008 at 11:50 AM, Abdelrazak Younes <younes@lyx.org> wrote:
>
> AsciiDoc is indeed excellent if you want to write in a plain text editor.
> But LyX is easier to use and more porwerful :-)

What is really powerful is TeX. As to LyX, it is leaky abstraction over it.
I have never been able to use without ending up saying, it is so much easier
and much more powerful to use Latex than trying to do the same with LyX. Of
course, LyX looks much better nowadays than used to be, so I decided to give
it another try, and here is my fifteen minutes experience with it.

First, I tried to open FAQ.lyx that you attached to your previous email, and
here is what I see:

===
/tmp/FAW.lix is from a different version of LyX, but the lex2lex script failed
to covert it.
===

This is result was received with two LyX versions that I tried:
LyX Version 1.4.3 (21/09/2006)
LyX 1.5.5 (Sun, May 11, 2008)

Now, I see, that your FAQ was created with LyX 1.6.0svn, which is not released
yet. So, I hope that this issue will be correctly before it will be released.
Otherwise, anyone opening document with 1.6.0 will make it unaccessible to users
of previous versions.

Then I tried to use Formatted reference and everything looks okay until I tried
to generate DVI file, where I was welcome but the following error:
===
Paragraph ended before \@prettyref was complete.
===

What is \@prettyref? What is wrong with my paragraph? Actually, my paragraph is
fine, it is just when you use Formatted reference, you should know that it is
implemented using prettyref TeX package, which requires three letter prefix in
name of each label. Why did not LyX warn me about that? BTW, is really prettyref
is the best package for this job anyway? I remember some TeX experts recommended
some other packages for references.

Finally, I still have not figured out how to the same what AsciiDoc does:
Chapter #, $CHAPTER_NAME
It does not look like that LyX can produce references in this format.

The I tried to insert some verbatim text, and I cannot find the standard way
to do that in LyX. Sure, I can press CTRL-L and type in TeX:
\begin{verbatim}
        # git itself (approx. 10MB download):
$ git clone git://git.kernel.org/pub/scm/git/git.git
        # the linux kernel (approx. 150MB download):
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
\end{verbatim}

but I don't think that having a lot TeX code is going to help us with
having good formatted HTML version.

BTW, it is really annoying to see TeX code displayed in proportional
fonts and formatted with full adjustment. For instance, the last line
was displayed like this:

$                               git                              clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


Another rather surprising experience for those who got used to HTML:
Left-click on a reference produces its properties, while the right
click means to go to the label, and once you jump on it, there is
no way to jump back (at least, I was not able to find how to do that).

Well, I wrote all above only because I hope that LyX will continue to
improve. It looks much better now than before. Yet, I will rather stay
with plain text editors for now. Some of them are much more powerful
than Notepad :)


Dmitry
