From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Mon, 14 Jun 2010 09:59:51 -0700
Message-ID: <AANLkTilGhVCWJ9NdFqZD7_XOmAlPz8Wy5TN4Qkqvf5yU@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<7vbpbeazy5.fsf@alter.siamese.dyndns.org>
	<AANLkTimFUGkYeZaXA7BqX8ghsHX_gGYRK69ScHMXbw2l@mail.gmail.com>
	<AANLkTimNdZO8-lesiGmGm2DeHdhAKbTwzjct-U5P5LLJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 19:00:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOD0x-0002y7-3C
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332Ab0FNQ7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:59:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43668 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0FNQ7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:59:53 -0400
Received: by wyb40 with SMTP id 40so4056039wyb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=33NrGtA90Xett2Xluuid7MI93nsCI1C0UFK2T+Ajbp8=;
        b=voP3/rIY5jmzpUBnkmV4NeIh2huUKHV2H9hHJOyXh8KNOCRS7AHcgOkRfL4+nVMxbm
         jdKL2t9UCSX9RZ0TikkW4RxB4QNi0BeayBCqutES+KEao3GMW33GPDSISG/VTlbRZtY7
         4+YL9izy2Uk/msWCsJCIxZrQvkdmAQeUBz1Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vndrU2MH3iWUmUdRu69+/FPqNxv1nHImkBzz9MRIjIXfXGDNXIFvC89+la0HWng7n+
         wtzUkEniehiOnvmQau3cfXd+sFS+4yIyLixdXXkmYknxZV34esMp5bC2IS5S3UjK/61M
         etLEIf9QumVD2zSQJ60cqvHNKM39PTkq+Z8C0=
Received: by 10.216.186.5 with SMTP id v5mr2419307wem.51.1276534791524; Mon, 
	14 Jun 2010 09:59:51 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Mon, 14 Jun 2010 09:59:51 -0700 (PDT)
In-Reply-To: <AANLkTimNdZO8-lesiGmGm2DeHdhAKbTwzjct-U5P5LLJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149127>

Hey,

On Mon, Jun 14, 2010 at 9:49 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
>
> I, for one, don't think "git help" is the place beginners go to when
> they first start off - I sure didn't.
>
> The goal of re-grouping and having a short list of commands is nice,
> and I see this as useful for people starting to use git, but not for
> people learning it.
>

I would still argue that 'git daemon' and friends are not what people
starting to use Git need to see.

Scott
