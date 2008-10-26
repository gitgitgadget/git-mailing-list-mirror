From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Sun, 26 Oct 2008 20:55:09 +0200
Message-ID: <200810261955.10536.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <e15351d00810260730t1552e04cqb057993581514f3b@mail.gmail.com> <ee2a733e0810260805n35c3a637v4739dda938a22518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Maxim Vuets" <maxim.vuets@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 26 19:56:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuAmy-0004st-Qb
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 19:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYJZSzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYJZSzX
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 14:55:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:12504 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbYJZSzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 14:55:21 -0400
Received: by ug-out-1314.google.com with SMTP id 39so81882ugf.37
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UeZUThFzrZZeOBrhhw9OqpMIE1x3w+x31q84IprtuRE=;
        b=pi5jP4aM90kW6ZZAGhslTQOkAkuOAltIkUVmvF/xgB+jvQa9oQZxgunmNunI2gY+sK
         V0A/TbFCuNlLY+myEfyQKyJfjm/LFEMfUQ3ACMX3yH+4jQyg5cJSE602dvbE4R2GBEDF
         6O+bKXVixFjEgFywB2oNqWIMP+ZizGuVN7hFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Cgt24IpenHVRy3G5Cw0KIaurgg64thlgKluTl/lMYNgOHw2P6ZmRxqrmXAAOA/EdUm
         Iqy1jIGE1h3+Je2qJBBa20VmJvbwhaA54nGcCYYxXg6F7mEe1FT8AiI2zVAYLPRtmyFc
         ozOi0s1eN8gXHCG8fQAdd9wTSqHwUpUjoKM+c=
Received: by 10.67.32.18 with SMTP id k18mr1587375ugj.26.1225047319738;
        Sun, 26 Oct 2008 11:55:19 -0700 (PDT)
Received: from ?192.168.1.11? (abxb216.neoplus.adsl.tpnet.pl [83.8.251.216])
        by mx.google.com with ESMTPS id k30sm3228283ugc.25.2008.10.26.11.55.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 11:55:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ee2a733e0810260805n35c3a637v4739dda938a22518@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99178>

I'm not sure if Mercurial mailing list is not subscribe only. Git isn't.

On Sun, 26 Oct 2008, Leo Razoumov wrote:
> On 10/26/08, Maxim Vuets <maxim.vuets@gmail.com> wrote:
>> On 26 Oct 2008 15:15:57 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>> 1. Documentation and ease of use.
>>>
>>>    Mercurial is supposedly better documented and easier to use; I
>>>    think this descends from the early days of Git, where it was not
>>>    very user friendly. IMHO Git has much improved since.  Mercurial
>>>    had 'hgbook' from the beginning; Git User's Manual is more recent.
>>
>> Also, there is http://book.git-scm.com/ that is similar to hgbook, I think.
>>
>>  Thanks for the comprarision!
> 
> I have been using Mercurial for about two years and am very
> comfortable with it.  Here are some cons and pros
> 
> Mercurial PROS:
> * Easier and more consistent UI. Newbie friendly.

I think that _might_ be example of "Worse is better" scenario, with Git
having UI which evolved rather than was designed, and therefore less
consistent.

Also if you are limiting to what is described in main chapters of
'hgbook', namely one branch (one "fork") per repository paradigm
everything is simpler.

> * Better documentation. IMHO, hgbook is by far better than
>   http://book.git-scm.com/

And probably better than "Git User's Manual". There are lot of various
git-related documentation: "Git Magic", "Git for Computer Scientists",
"Git from bottoms up"...

> * Windows support (personally, I do not care)

And I think it is not important for DragonflyBSD.

Besides git _has_ MS Windows support, in the form of Cygwin and in the
form of msysGit project. It is still not as full as Linux support (for
example git-svn comes to mind), but it is not bad.  Well, Mercurial
has TortiouseHg, while Git-Cheetah is in very early stages...

> 
> Mercurial CONS:
> * Less potential than git. Once Ted Tso even said that "git has more
>   legs than mercurial", see
>   http://thunk.org/tytso/blog/2007/03/24/git-and-hg/

I agree, and I think it is at least partially because of Git having
cleaner design, even if you have to understand more terms at first.

> * Hg is strictly an SCM system while GIT is a content addressable file
>   system that can be used in other ways, hence the name Global
>   Information Tracker (GIT)

Errr... I think you are mislead by tongue-in-cheek backronym, which was
created in the beginning, when git had very weak porcelain (i.e. SCM UI).

> * Recently, Hg development seems to have somewhat slowed down. To
>   simply put it, there is not enough room in the world for several
>   similar SCM systems. With git's pace and momentum the other SCMs
>   including Hg are fighting an uphill battle.

The competing _distributed_ version control systems left seems to be
Bazaar-NG (Ubuntu), Mercurial (OpenSolaris, Mozilla), Git (Linux kernel,
Freedesktop.org, Ruby on Rails people).  There are many IDEs, many
editors, many web browsers; there is Linux and there are *BSD; I hope
that Mercurial would continue to be developed, and not vanish in
obscurity like Arch and clones...

-- 
Jakub Narebski
Poland
