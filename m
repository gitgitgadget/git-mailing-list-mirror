From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/i18n: quote double-dash for AsciiDoc
Date: Wed, 29 Jun 2011 12:42:39 +0200
Message-ID: <BANLkTinRbw+mggfgP4s06jcn4SNzcE0byg@mail.gmail.com>
References: <20110628171748.GA11485@elie>
	<20110629053133.GB28690@elie>
	<20110629053648.GD28690@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 12:42:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbsEK-00061J-PE
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 12:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab1F2Kmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 06:42:43 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:45107 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab1F2Kmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 06:42:40 -0400
Received: by fxd18 with SMTP id 18so1103214fxd.11
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ch14MNL6n6xEgRKmD8/HT4XnNQV1IS/msGfeeVOR9TU=;
        b=FVQnTTEzkAWIsrkz4qyJHemd633oA1VEURzPhKxazIe8rch8uVg+TQQr75VOvPTPah
         QWOyBIAUurB/bDHT3EHZZS6nEJlx9JGLr1MMimzXmbCoYKPLVYBippc8cwYBFVu/iIAp
         0uoWGLQR6OnRaToEAH/lY5xFLsPQOFcd4LDRE=
Received: by 10.223.145.6 with SMTP id b6mr1075204fav.2.1309344159204; Wed, 29
 Jun 2011 03:42:39 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Wed, 29 Jun 2011 03:42:39 -0700 (PDT)
In-Reply-To: <20110629053648.GD28690@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176439>

On Wed, Jun 29, 2011 at 07:36, Jonathan Nieder <jrnieder@gmail.com> wrote:
> As explained in v1.7.3-rc0~13^2 (Work around em-dash handling in newer
> AsciiDoc, 2010-08-23), if double dashes in names of commands are not
> escaped, AsciiDoc renders them as em dashes.
>
> While fixing that, spell the command name as "git sh-i18n--envsubst"
> (2 words) instead of emphasizing the name of the binary (one
> hyphenated name) and format it in italics.

Thanks for fixing this, looks good to me.
