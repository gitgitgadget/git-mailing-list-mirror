From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Proposal for git stash rename
Date: Sun, 20 Jun 2010 10:54:43 +0000
Message-ID: <AANLkTimjEksHI4nlefqmNzdNiseVyMQcw312g2AHFQDZ@mail.gmail.com>
References: <20100620093142.GF24805@occam.hewgill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Greg Hewgill <greg@hewgill.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 12:54:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQIAw-0003Rw-Fj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 12:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab0FTKyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jun 2010 06:54:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40696 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756687Ab0FTKyo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jun 2010 06:54:44 -0400
Received: by iwn9 with SMTP id 9so2482850iwn.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=suu+vjbFjxlr6okGFGmPT3BqiwbwuEPJ8we3gDX/AtE=;
        b=FWl3ob6OS0hTzgZw4MlFeR3JEhpN30cYK++GVvun2l4ePdg+ZLsthaHSbFktSC71SG
         /6zmzvv+b+O9efoCVRTAWeoTZ0IYJYZZwNYQAR+ezovar1OvBqXZFps2rEXrR6RISawZ
         OCag7tWRXrb78IhklFTXgBcsoThFRsVgfhOuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F/OQCx0BHVIBP5T9CnV9VU1528QipNdT+1o6tS1yriY1eOGt7XUr2YkRVLv70tArIV
         BmG+wTjgFiympwlarfQxXQkwOjaXBZ0Yq5CMyyB2biVvWDMX9qLMRSf/kXI8mEpyFTw3
         /ID0/JEBqyPbJAzom28HzSL011bn0jzC5l2gM=
Received: by 10.231.148.130 with SMTP id p2mr4051365ibv.11.1277031283506; Sun, 
	20 Jun 2010 03:54:43 -0700 (PDT)
Received: by 10.231.158.195 with HTTP; Sun, 20 Jun 2010 03:54:43 -0700 (PDT)
In-Reply-To: <20100620093142.GF24805@occam.hewgill.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149393>

On Sun, Jun 20, 2010 at 09:31, Greg Hewgill <greg@hewgill.com> wrote:
> - Is this an appropriate approach to implementing this?
> - Is there a better way to do it?

No idea.

> - I have a mostly working patch now, but it needs cleanup. What's the
> =C2=A0next step?

It's good to post a WIP PATCH even if it needs cleanup, just as a
point for further discussion.
