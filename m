From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: clarify GMail section 
	and SMTP
Date: Tue, 25 May 2010 09:47:14 +0000
Message-ID: <AANLkTin3loPRUroTO6wIF4iCqqmrR7BDxAeJXtNcU_as@mail.gmail.com>
References: <20100525072240.GA20408@coredump.intra.peff.net>
	 <40abcf5e5337f974e70a7b0bd6279a630b35ce19.1274776132.git.git@drmicha.warpmail.net>
	 <20100525092548.GA32288@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 11:47:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqjI-00025h-25
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab0EYJrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:47:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47479 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756413Ab0EYJrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:47:15 -0400
Received: by iwn6 with SMTP id 6so4513075iwn.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=URK0bInhiyG3u79OxiDK0fVvUiy00CeH+0J+aq49aLQ=;
        b=htngHs8qmshgHi4IzkNdAto0plCBu4q6UKC3kxJU25M2s8YdSVz0UlOwE7FTBQXS4b
         DDwMGOrDkt5VdKYVGfrS/053jIuiRg7H9FjWAH8kBBoTZhZQ/hiuPqevVt1PA9fwxs0T
         SpNp8S3N5/8nF2PxLVP2n5h8/tPH46ZgQeo3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uStFuawF+YDmlMdlqmNKC7ujHNw/ZM46ddeLQb8U6sSGrhAhMdURMZTquUA3x87Afa
         +bgDiiaG5uZTxQWYsugFG3ZnQYK+uf4faYuQq5TyyfHRs2TSaF7p0O9kRGeu+NF5Pzyx
         3Ht15VaCKqi7Nxn5Ii9N+l/uAfRvE70YJO588=
Received: by 10.231.120.76 with SMTP id c12mr5128084ibr.92.1274780834176; Tue, 
	25 May 2010 02:47:14 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 25 May 2010 02:47:14 -0700 (PDT)
In-Reply-To: <20100525092548.GA32288@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147705>

On Tue, May 25, 2010 at 09:25, Jeff King <peff@peff.net> wrote:
> On Tue, May 25, 2010 at 10:30:13AM +0200, Michael J Gruber wrote:
>
>> We keep getting mangled submissions from GMail's web interface. Try to
>> be more proactive in SubmittingPatches by
>>
>> - pointing to MUA specific instructions early on,
>> - structuring the GMail section more clearly,
>> - putting send-email/SMTP before imap-send/IMAP.
>
> Like I said elsewhere in the thread, I do not use gmail, but from our
> prior discussion and what I have seen on the list, these seem like good
> changes to me.

I use GMail, and I think the SMTP instructions should come first,
these changes look good.
