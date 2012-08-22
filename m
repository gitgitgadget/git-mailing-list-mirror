From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Document the --done option.
Date: Wed, 22 Aug 2012 10:47:58 -0700
Message-ID: <CAGdFq_jTOY=+DJfuFdx8w8U-hQe9kFBLQDMaESpbeQKDafko2A@mail.gmail.com>
References: <20120822105705.GA30472@thyrsus.com> <7vobm2968x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4F39-0008CX-SM
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab2HVRst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:48:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34267 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab2HVRsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:48:39 -0400
Received: by obbuo13 with SMTP id uo13so1699255obb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mOQRZq8NaHzO/A5k3oBRfNRLgcFQI/vfUfWQ1R0j1XU=;
        b=wZ67nSZsCMNwP/MCrB9FsfCPESGMWguk0umwwh1VN1mu5ds93s01R6fXlY0zQC8fNM
         uPGLh2euoDUhD+ZpYcVjeAsEG2nWB1CUP1coA+8as+QR3HjcRz0uVQoznJcb/FAjjWMr
         KrScbthbNaZuMssscdHxyNbQ02DfbVVswGdg4XZ7iIYGLZUf2ZBUVs+U3K1+3dxtSPbz
         8lz/4z/kRFyWnI3g2E6uix80kWQ3NpFGkFmXWjCS4iTNsO0rccPsbpJludP5s/99+/Yh
         anm0tWUHLJIku6Mc8pmbuvUzlAWIyMVUIL1AhXbqyXtXA3FFpqXS7Qo9EeukQBCRZ7cI
         fdUw==
Received: by 10.182.37.41 with SMTP id v9mr16541726obj.23.1345657719063; Wed,
 22 Aug 2012 10:48:39 -0700 (PDT)
Received: by 10.76.85.65 with HTTP; Wed, 22 Aug 2012 10:47:58 -0700 (PDT)
In-Reply-To: <7vobm2968x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204048>

On Wed, Aug 22, 2012 at 10:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Eric S. Raymond" <esr@thyrsus.com> writes:
>
>> ---
>
> A forgotten Sign-off?
>
> Sverre, the text matches my understanding as well as what be56862
> (fast-import: introduce 'done' command, 2011-07-16) says it did.
> Ack?

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
