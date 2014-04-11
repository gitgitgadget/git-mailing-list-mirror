From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Our official home page and logo for the Git project
Date: Fri, 11 Apr 2014 13:56:00 -0500
Message-ID: <53483ac0be5d5_937adb308e2@nysa.notmuch>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
 <534578b2e22e2_af197d3081@nysa.notmuch>
 <CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
 <20140411114017.GC28858@sigill.intra.peff.net>
 <9D09EA38-1956-467F-88CF-9EA6F12F1CA0@quendi.de>
 <20140411132935.GA5871@nysa.casa.local>
 <D372C563-C59D-47A6-91A3-D2C6BB2164B1@quendi.de>
 <20140411152147.GA12161@nysa.casa.local>
 <40FDE1FF-780F-46E1-A5AA-57D53D6D1C87@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:06:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYgm9-0006F1-M5
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885AbaDKTGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:06:01 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:50320 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbaDKTGA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:06:00 -0400
Received: by mail-ob0-f175.google.com with SMTP id vb8so108148obc.6
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=pAarH+mjb7BlU+XIA4DutshsqCp95lpw0nBToL21jhk=;
        b=CA0zy0J/JOrfwJ1OciDOwknA1qqhbZlNOyuPmHFEgLQ+DSwF1VTYmEokutbQ+X5CwQ
         I7JwHYHO2+4LehJVp7SRGSqHISbNtUnDHFZyGR4Fzsgemy+ANakFXOjSs5DXjLTHqWEQ
         wGZNxqwPxtGwLb3fgm1aO0ava4pFOF/O7P2fAThdCgc0jbQz7lofhblcyb0D1tHVkYQA
         JC7V1bjvmXzzkZRPFlPGmpyBMzOh3Z4vIcSPmQUlr7RX/++6gGpj2pO/iIqn3AlBbWUB
         4eo/Nw4mz1i7Af+jtq2TU0iDDAefyHne3AJ1SBVa1/bnpZWGqmdNP68dAmkfug5rS0Wm
         vLEQ==
X-Received: by 10.182.2.72 with SMTP id 8mr21002882obs.21.1397243160506;
        Fri, 11 Apr 2014 12:06:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y10sm13702627obk.4.2014.04.11.12.05.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 12:05:59 -0700 (PDT)
In-Reply-To: <40FDE1FF-780F-46E1-A5AA-57D53D6D1C87@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246129>

Max Horn wrote:
> On 11.04.2014, at 17:21, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > Max Horn wrote:
> >> On 11.04.2014, at 15:29, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >>> Max Horn wrote:
> >>> 
> >>> You don't think red represent an oldness in Git? Whereas green
> >>> represents progress?
> >> 
> >> No, I don't think that.
> > 
> > Then you belong to the minority of Git users. Those of us that see
> > patches day and night, red is old, green is new.
> 
> Hasty generalization.

You don't know what a hasty generalization is. If you want me to explain it to
you, send me a personal e-mail, you are polluting the discussion enough as it
is.

> Come back when you have facts, as opposed to the illusion that you are the
> spokesperson of the (apparently silent) majority of Git users.

Facts:

1) A hunk that removed (-) is represented in red [1]
2) A hunk that added (+) is represented in green [1]
3) A file that is removed is represented in red [2]
4) A file that is added or modified is represented in green [2]
5) A test that fails is represented in red [3]
6) A test that succeeds is represented in green [3]
7) The current Git logo (accordo to some people) has "-" in red, "+" in green [4]

Given these facts, it's reasonable to assume that to the majority of Git users
red is old and bad, green is new and good.

[1] http://ubuntuone.com/0lxzuxY2b59OEdDK5EOvfi
[2] http://media.smashingmagazine.com/wp-content/uploads/2011/06/git1_4_git-status.gif
[3] http://felipec.org/git-tests.png
[4] https://plus.google.com/112500102483798323902/posts

-- 
Felipe Contreras
