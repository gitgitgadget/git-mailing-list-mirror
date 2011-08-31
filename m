From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git bug reporting
Date: Wed, 31 Aug 2011 16:03:58 +0200
Message-ID: <CAGdFq_jtf9irk7mmikT2W8p5oEO-oUzy9Gq5c-s1xk-N3tSTKw@mail.gmail.com>
References: <20110829132052.0ad7a088@robyn.woti.com> <20110829192618.GF756@sigill.intra.peff.net>
 <7vpqjo54my.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Bryan Jacobs <bjacobs@woti.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 16:04:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QylPJ-0002fs-BA
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 16:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab1HaOEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 10:04:39 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45461 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1HaOEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 10:04:38 -0400
Received: by pzk37 with SMTP id 37so1365562pzk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GZAfujmnqVmyyNzRXycovbhlXpmk1eZAulmLI8/3kWE=;
        b=N3lDAckA93J0D5yEusL+p0IYLkcI8l8tSUgf3gHgpqNIMpwjZhpTQDA3D/WUOrJoMX
         hj0jCWwVgG7TP+Fea9DIu4y7WaReQRu86YTBOvMDTstrIEQBbQ7GvZABEOg46CvJAbEb
         qLy/i+ko6b5fHZqCAX0k/Eg+qhL3OaK6vhWh8=
Received: by 10.68.44.3 with SMTP id a3mr352444pbm.227.1314799478080; Wed, 31
 Aug 2011 07:04:38 -0700 (PDT)
Received: by 10.68.55.7 with HTTP; Wed, 31 Aug 2011 07:03:58 -0700 (PDT)
In-Reply-To: <7vpqjo54my.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180471>

Heya,

On Mon, Aug 29, 2011 at 22:44, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> In the meantime, I've updated:
>> ...
>
> Thanks. I've also made sure that the very first paragraph of "A note fromt
> he maintainer" talks about it (yes it already does).

While we're at it, should we also make sure that these places mention
Documentation/SubmittingPatches?

-- 
Cheers,

Sverre Rabbelier
