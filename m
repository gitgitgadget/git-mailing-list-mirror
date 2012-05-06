From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-scm.com refresh
Date: Sun, 06 May 2012 00:10:26 -0500
Message-ID: <4FA607C2.6030906@gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 07:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQtkX-0004Ei-Of
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 07:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab2EFFKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 01:10:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51411 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2EFFK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 01:10:29 -0400
Received: by obbtb18 with SMTP id tb18so6383742obb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 22:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=glzknzgG3+M26b69uHl0WE6LRLqZVGJyiZkzkm7CdR8=;
        b=FZZKG4kWdNCLmRAU2LZ9Q3ByGTtNq0y76a84dAeHLtnlVWIsef0KfrO6/X5xAjPR0W
         //axX0g8K1F65SLJvsgU1z3qy6WOW1K7i5V67bJ756PtMYAefjIIOeeGWtrzHXhrdMji
         B10Nd0CPSTmkYV3LNNnF8mekkU/tbbdaQfIRm9s7OshmvngHns8mjSS/U4qMNV5mu6EI
         3Ds2aH4Jn5tf5V7iCRC/UidgEPutNWyvaMy7VZSA9Ss6NdRNfKpLfkKf5xwrzucl5P1V
         xve2bEYGqflJ3JmFjciPO2vs3e4RwD/aOpRE0Ye0G4oxnKx/Ai2cX+DWC7h+RbGLZRmy
         imEw==
Received: by 10.60.8.97 with SMTP id q1mr15996462oea.29.1336281029079;
        Sat, 05 May 2012 22:10:29 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id bk8sm14386896obb.0.2012.05.05.22.10.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 22:10:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197148>

On 5/4/2012 6:29 PM, Scott Chacon wrote:
>
> I just shipped a big update to the git-scm.com website...
>
Thanks for the cool website, old and new!  :)

> * There is now permanent man page hosting here, for example:
> http://git-scm.com/docs/git-fsck.  You can also reference any older
> version of any command: http://git-scm.com/docs/git-fsck/1.5.5
>
IMO, I think the reference manual before the kernel.org crash was the 
best.  Back then, you first got a list of all the versions and you 
picked your version.  If I'm on version x I want to click on version x 
one time for the entire refman, not for every manpage.

I prefer the git.git make doc version of the html.  If you could have a 
'classic' view of the reference manual that would be great.  I'm not an 
expert on the make doc technologies, but if your version is harder to 
get working then a classic view would enable you to quickly and reliably 
publish updates while ironing out the enhanced version.

Also, the new format has *way* too much whitespace on the sides for the 
manpages.  (Progit also has too much whitespace -- was it like that 
before?)  The manpages are long enough without double column width in a 
single column.  ;)  The related topics is interesting.  I think this 
hybrid reference manual format should be called 'enhanced' or something. 
  I think its important to keep the official git reference manual 
clearly distinguished from supplemental material because some of the 
supplements are not correct (ie, [a]progit merge=ours).  I think the new 
hybrid format disguised as the reference manual will cause the newsgroup 
to get alot of questions about supplemental material confused with the 
reference manual pages.  They probably already spend too much time 
correcting my bum scoop posts as it is.  ;)

I'm not a website expert, but an option to pick a stylesheet that has a 
main theme color of blue, green, etc., as opposed to red-orange that 
would a big plus in keeping with the open source concept.  I'm not a 
visual brain scientist, but I think my aversion to staring at a 
red-orange website all the time has something to do with why walls are 
not normally painted red-orange either.  ;)

> * There are still a few asciidoc parsing issues that we're working on
> - if you find anything that's weird please report it at our issue
> tracker: https://github.com/github/gitscm-next/issues
>
git-rebase manpage is pretty hosed.  (when i tried to report on github 
it wanted me to signup.)

Footnotes:
a.  http://git-scm.com/book/en/Customizing-Git-Git-Attributes,
http://comments.gmane.org/gmane.comp.version-control.git/192798

v/r,
neal
