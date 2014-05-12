From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 12:13:10 -0500
Message-ID: <5371012674244_222d1297308d1@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <53709788.2050201@alum.mit.edu>
 <5370a47bee98c_139611a92fc29@nysa.notmuch>
 <5370B920.2060506@alum.mit.edu>
 <5370beb4b2483_168f13a72fc57@nysa.notmuch>
 <5370D015.10300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 19:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjtxV-0000Sd-TK
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 19:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759263AbaELRYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 13:24:09 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35975 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759217AbaELRYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 13:24:07 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so8592914obc.32
        for <git@vger.kernel.org>; Mon, 12 May 2014 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=fuZtmulSCWKvOSiAq3TgSIL7JNFz3vr1dYp52ODC4vg=;
        b=R3DjpbytWQEi2v468CK5sVUrS/qqrUq6irThVxAOZlgga9/ngFxzb9iM0/aSwx1s6H
         zhZSMF2zLPjz5ilMWmWL+kBjC3f0oGwK/cAvAkYP0JjsIHEwemKDYoNHeXWwhysG1YBq
         4goBxJRPoADXYAUckJRrE6c3Ydbbk2KbIWPDRuhCW6OfpeMp9BLxXWuLcekIh9TonpPz
         E5waCF0uU/FxOCIK92WAQyyhqV76z4svhLBbAlKUBn9A3RsruVmlKMEeM6Gd/opMiaLV
         7/i10F2JbEhgZn4fCOwnINxni4Kh5SgnYEF6GpgEF6GD6/cENHzx0ZTWZJzr3jL+en6K
         iLEQ==
X-Received: by 10.60.231.134 with SMTP id tg6mr5341959oec.84.1399915446634;
        Mon, 12 May 2014 10:24:06 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm50767014oej.5.2014.05.12.10.24.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 10:24:06 -0700 (PDT)
In-Reply-To: <5370D015.10300@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248714>

Michael Haggerty wrote:
> On 05/12/2014 02:29 PM, Felipe Contreras wrote:
> > Michael Haggerty wrote:
> > [...]
> >> 2. Moving git-remote-hg into the core would require you to continue your
> >>    presence on the Git mailing list.
> > 
> > That is another red herring. Moving them back to the contrib/ area which
> > is what Junio proposed would also require my presence on the list. Is
> > that what you want?
> 
> No, actually my preference is that git-remote-hg be separated from the
> Git project altogether, for the reasons that I stated earlier.

Exactly. So your point 2. is completely irrelevant to the contrb/ vs.
core debate.

-- 
Felipe Contreras
