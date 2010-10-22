From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git as an sfc member project
Date: Fri, 22 Oct 2010 13:59:37 -0700
Message-ID: <AANLkTim7gC6ckrN-yFGyT4KgPz2v9B+UqLBZj7GzaMpK@mail.gmail.com>
References: <20101022183027.GA12124@sigill.intra.peff.net> <AANLkTi=6tvmTAfdyL-sKBsq+4OpFaQpZWT66ANESNapj@mail.gmail.com>
 <20101022193512.GB13059@sigill.intra.peff.net> <AANLkTim0EH0Qvwe6NHMBt831jHZV85=TSAx8k2ABnTdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:00:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Oid-0001le-Ec
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab0JVU77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 16:59:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43210 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0JVU76 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 16:59:58 -0400
Received: by yxn35 with SMTP id 35so1023564yxn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g1F6EfDsgQ+OyqwsglFG7jNtfk1JOISbfUPvv/cTnjE=;
        b=axEuav0uCa8B+r73BQq7RMZ5eKKXY5WanpSK3udy/zHhEpfqdCZA+RrpQDGyJiAep4
         bPlHArTxxT77qCAQQRa4vRfDPhGirHCaMDoVSx9jQJsLtf6eVWnwyYLlsr+404po6uCr
         XQ5cyeoV/Mb8s1Kw/lc4UX3KvzWfFDYAsFBnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I0v5JmGYSvJwajhaS/VU8AUAIDAsg6M2EGcDNfNRUkRyyNFe1YeuGOXFc4AQp3pXby
         ONvRmEe5WeMBPaBUTTy4HTzb3BCYssz+eBcneq71XzHkTNXJenLAf8/gkxEteTsNnSSK
         0W92cQQti9P0vR6vpuRhC19CdMwqgDxkq8t04=
Received: by 10.150.177.7 with SMTP id z7mr6798638ybe.433.1287781197800; Fri,
 22 Oct 2010 13:59:57 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 13:59:37 -0700 (PDT)
In-Reply-To: <AANLkTim0EH0Qvwe6NHMBt831jHZV85=TSAx8k2ABnTdd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159748>

Heya,

On Fri, Oct 22, 2010 at 12:19, Shawn Pearce <spearce@spearce.org> wrote=
:
> I think a committee of at least 3 people and at most 5, any of whom
> can be a benevolent SFC liasion, is fine. =C2=A0As far as selection g=
oes,
> the committee can elect or remove a member through a majority vote,
> and should base its decisions based on surviving contributions to the
> code base, but shouldn't be tied to that (just in case someone
> contributes a lot of good code and then becomes a jerk).

Sounds good. Something like Junio (Duh), Shawn (based on commit
count), Peff (Handled GSoC money last year), and Jonathan Nieder
(based on list activity)?

On Fri, Oct 22, 2010 at 13:06, Shawn Pearce <spearce@spearce.org> wrote=
:
> OK, 10% does seem reasonable given they are saving us the taxes... or=
 more. =C2=A0:-)

LGTM.

--=20
Cheers,

Sverre Rabbelier
