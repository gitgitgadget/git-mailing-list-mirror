From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v5] checkout: add --progress option
Date: Sun, 1 Nov 2015 13:17:45 -0600
Message-ID: <CAOc6etbNryps20wK1LNpb7UKfhwEWdS2FWwopgzusrb+ULf2kw@mail.gmail.com>
References: <1446401039-13848-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTE=vhFf-wf9qd4EMt8agi5SneQ3efKi1DCrArEsii5GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 20:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsy8U-00036j-Ox
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbbKATRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:17:46 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35173 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKATRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:17:46 -0500
Received: by pasz6 with SMTP id z6so124599105pas.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4hArkNOjsec3evwk5oMgulBlXt/J+omXeccqw2pNWWE=;
        b=YjDX3QDIZ5NxnMXXGGlp8wwJ94OPhh8hjgGM4IiYEauPDeNYGWMPl+zPSQrtYAsq+R
         klGGJW4dNEFGQSyap4Pg6kSV9yU/a/z6Wj+bhTrdIjDXhl3f+slEqBrlBlC4a9n1ch64
         bduH0FcbFCN7I6E07XCZ20f6wjUhGX4jLUSCesapO+T0sokiUJwZImrAhg5m0F7C1Ef6
         UmV2FKlQChbkYvDjoHT7xupO/ENE/VqUreLzQ/wB6VgCt3Fp35BeA+sQsBtxtIu7dUSE
         MgUujqc7s+KsWsnrqvKtXFQrFaXZ75N5Pynov/i36hzlfDUB6T6Rf/+QEG77isx+E4Ad
         BgFQ==
X-Received: by 10.68.57.208 with SMTP id k16mr22536262pbq.12.1446405465598;
 Sun, 01 Nov 2015 11:17:45 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 11:17:45 -0800 (PST)
In-Reply-To: <CAPig+cTE=vhFf-wf9qd4EMt8agi5SneQ3efKi1DCrArEsii5GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280654>

Oh, man... I'm sorry... I didn't notice them. Let me go over them to
see what we can do.

On Sun, Nov 1, 2015 at 1:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> I'll assume that you simply overlooked the remainder of my v4 review
> comments, so I'll merely provide a reference to them[1] rather than
> repeating myself. If that assumption is incorrect, please do have the
> courtesy to state that you disagree with review comments and to
> explain your position, otherwise reviewers will feel that their
> efforts are wasted.
