From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Our official home page and logo for the Git project
Date: Sat, 12 Apr 2014 09:02:40 -0500
Message-ID: <53494780bc447_c9914c730841@nysa.notmuch>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
 <534578b2e22e2_af197d3081@nysa.notmuch>
 <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
 <20140411114017.GC28858@sigill.intra.peff.net>
 <20140411132448.GA5845@nysa.casa.local>
 <20140412123419.GD14820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 16:13:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYygN-0006VN-W5
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 16:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbaDLOMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 10:12:44 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34168 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbaDLOMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 10:12:43 -0400
Received: by mail-ob0-f180.google.com with SMTP id wp4so358925obc.39
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qbtVwwdd2lq9JTLRMCAqheKdgHUvVIgjm3E3BYoaqo4=;
        b=GIhKp6TTjzbfT+0LEPAzSb8ZWE68xy9VE3GoovSTiXizQVD4vvTN5bnJ/sWwn4i2+r
         ylRtIajelnLq+Wh0pQx/wvB13yXkUlahayERGWuZJtgFd/Oy/epkEkhseJqWCuOe0yBb
         ZvsGmOOnlqhUaIpWAKdIlWKrPgWuUMrW8mhPQUWjHu4qnmY911r0xeFdfXABSemrh8Mx
         65W7PR3qXBD4FDSJkqSROSRU1zL/SBTtH7RNCMzsjLg5vsPGdRfMGqxkvJXKkrDAiA1n
         QtQlAoadv+3G8SSvZE69WzHLTFhBiW8wFFGrjt3Ol6tdW/9WMVoHLSWewKV/zRp0+iN3
         Zhkw==
X-Received: by 10.60.133.17 with SMTP id oy17mr2135167oeb.51.1397311962446;
        Sat, 12 Apr 2014 07:12:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm45475945oej.5.2014.04.12.07.12.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 07:12:40 -0700 (PDT)
In-Reply-To: <20140412123419.GD14820@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246172>

Jeff King wrote:
> On Fri, Apr 11, 2014 at 08:24:48AM -0500, Felipe Contreras wrote:
> 
> > I would actually like you (everyone) to be honest and answer this
> > question;
> > 
> > Have you actually analized the logo? Or are you just arguing against
> > change, because the logo is already used by git-scm.com, and related
> > stuff?
> 
> Is this rhetorical? If not...

It was, because I was pretty sure the answer was mostly the later.

> Yes, I really thought about the logo and like it.
> 
> Many of your complaints are about how git concepts map onto the logo
> (for instance, the direction of the graph nodes).  That is _one_ way of
> evaluating the logo.

There are many ways of evaluating the logo, and they are not exclusive.

> But there are other criteria, as well. For example, is the logo pleasing
> to the eye? Is it memorable and recognizable? Things like "pleasing" are
> subjective, but there are patterns across humanity. Graphic artists have
> studied this for some time and have guidelines for layouts, contrast,
> balance, proportionality, etc.

Yes, that is _also_ important, but so is the fact that the logo should have
correct Git concepts, because the main target audience for the logo is
programmers.

> For example, in the git-fc logo you mentioned, you rotated the logo from
> git-scm.com. I find it less visually pleasing than the original. It
> seems somehow more "wobbly" to me with the two branches sticking up.
> Now, that is my completely subjective opinion. I do not know very much
> about graphic design, and whether guidelines could help there, nor did I
> conduct any empirical research. So maybe it is just me, or maybe one
> design is universally more pleasing than the other.

I've been playing with different logos myself, trying to see if I can come up
with something different (rather than modifying the one done by GitHub). I've
yet to come with something that I think might be superior, but I think I might
be able to do more improvements now.

So I have to agree on this; the direction of the nodes in the current logo does
seem to be more aesthetically pleasing than my own.

However, you left the colour of the logo completely untouched by your analysis,
and the colour is extremely important.

> But I think that visual art considerations should be at least as
> important in a logo as whether the logo pedantically matches the tool's
> output.

*Both* are important, as are many other considerations.

In short my concern is that *if* we are to pick an official logo, we shouldn't
do it blindly, as it appears the logo done by GitHub wasn't reviewed at all by
the community. Fortunately as Junio clarified; this is not a discussion to
officialize the logo (albeit the title implying so).

-- 
Felipe Contreras
