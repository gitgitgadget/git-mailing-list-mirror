From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Fri, 18 May 2012 20:50:55 -0400
Message-ID: <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr> <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com> <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVXtC-0007f6-4I
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892Ab2ESAvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:51:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42242 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764Ab2ESAvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:51:16 -0400
Received: by dady13 with SMTP id y13so4479262dad.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 17:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yEB0+ksLyj0o+kdH3WbLcr88eVzBFv9HkPaCHc7PWOw=;
        b=lWBNteYtwSoiWoQRvWdhPtbBmrbtyxvDjrKiCNb9+QCn+5W0OnrHI/zSFOgG2UmSCa
         ZDz4bYBBoUzUNdS8NgCR39tBTb11qhfR+4LD14vK4aGT63Wt6MejUKXeS38y8bQBerZz
         j/UisFiVKdZR7b5zq1mxmgEIkbbYDtSrK7uKMjq/pfU6CJi/8GFnKHB32BGAbMrOrunB
         9CfMcgOC4V7IsJaps5yt/5N9uaXV0fBExbrfokHX/b55xBdehNhGpkoXNj+FlVlrF4XY
         nX24TNFs75PDwH6A2B2NPIVAGV/FpRsdYwy6G6PgnEsErgvGSDX/agrWaYMvXOAmnhyh
         uTJw==
Received: by 10.68.203.98 with SMTP id kp2mr44291398pbc.19.1337388675757; Fri,
 18 May 2012 17:51:15 -0700 (PDT)
Received: by 10.142.242.14 with HTTP; Fri, 18 May 2012 17:50:55 -0700 (PDT)
In-Reply-To: <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198002>

On Mon, May 7, 2012 at 1:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> the
> shipping/logistics term "to stage" does not cleanly translate to the
> language without unnecessary connotation that imply what is described is
> something the our "index" actually is _not_.

I agree with Felipe that "staging" is the most appropriate term for
"adding to the index" in git.  As a native English speaker, I have
never thought of "to stage" as relating to shipping in any way.  To
me, by far the most common usage is in real estate.  The seller of a
home "stages" it by setting up furniture and decorations to make the
home as appealing to prospective buyers as possible.  Just search on
Google for "home staging" and you will get plenty of hits.  This usage
clearly originates from theater but can be found in other contexts as
well.
