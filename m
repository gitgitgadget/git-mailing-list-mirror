From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCHv3 1/5] enter_repo: do not modify input
Date: Wed, 5 Oct 2011 15:02:03 +0100
Message-ID: <CA+39Oz7_uJpEG9QzmbzVKCkGG2EL-Uj4mmO=H2VeDbK4bgEXsA@mail.gmail.com>
References: <4E8C5D4A.7060900@cisco.com> <4E8C6233.8040906@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 16:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBS3K-00029v-5P
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 16:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934312Ab1JEOCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 10:02:24 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53052 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933879Ab1JEOCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 10:02:24 -0400
Received: by qyk30 with SMTP id 30so4320195qyk.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=6ce2amyQZe6qskxmR0K0s0J5L3lneAcSL3RoUOUTbs4=;
        b=ASqAvwUC9I5RoJ93/4bHUj8hZEtGGtynBYPiwBwOto3u9la4v/bBJbBv7l2UF0/+gQ
         BE1cp0sw2Tyl78DufyK6mlL7g59iN4uNznnh8GiWtLxCdGrJfZWJc2UJpYrpEtm6RDif
         m9gEw3nS1gLyZzLlDyUSMsLu806R+uBCyKnmg=
Received: by 10.229.66.160 with SMTP id n32mr749947qci.33.1317823343400; Wed,
 05 Oct 2011 07:02:23 -0700 (PDT)
Received: by 10.229.229.1 with HTTP; Wed, 5 Oct 2011 07:02:03 -0700 (PDT)
In-Reply-To: <4E8C6233.8040906@cisco.com>
X-Google-Sender-Auth: CJUhOoJEfGMpMjNE2FvFlJoff6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182849>

On 5 October 2011 14:57, Phil Hord <hordp@cisco.com> wrote:
> From: Erik Faye-Lund <kusmabite@gmail.com>
>
> entr_repo(..., 0) currently modifies the input to strip away

enter_repo???

-- Thomas Adam
