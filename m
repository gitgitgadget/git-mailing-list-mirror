From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: implement suggestions made by perlcritic
Date: Wed, 27 Mar 2013 22:43:50 +0530
Message-ID: <CALkWK0mvcCODcZN0s=7YQAnpVA053bFrnCr0qugpBvSK=h6Usg@mail.gmail.com>
References: <1363869587-10462-1-git-send-email-artagnon@gmail.com>
 <7vd2usbwkn.fsf@alter.siamese.dyndns.org> <CALkWK0kkWAkiANL-vL-OthKSDkoU2b_Q68frkGc06QNG7RbSFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtvr-0003wV-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab3C0ROM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:14:12 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:45150 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3C0ROL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:14:11 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so7589601iac.33
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bjmIu611V6pr6dDhJmYg0BG9cidF5uA5UOmNgIWGlQo=;
        b=Eriay+MtNvj1UrMa7xjVsYAZp6zUMji7z47CGwYzWFy3841Mfe8wCM1gqiy8F2aXR2
         fw6gPBN/pRshvbvQ807885G/afjAlnfgEkxtOskJrh2JoYPdHaaOkPjEetDS+2YggOjm
         nO75V2p43OXON+79M/WzYMGGUVhjbv25gIs+HIguMMjtcWaBPS88Cie/juBNPJTYTV1M
         fuHn337LPINSBi5JbaT8HzPmKqdWzHpw7rhDQUCDxWJPLasTHrQe3zk2I2xtwzri5aTs
         prvqRB2HUwabmx3rr+MIOXIfTrcV0KwjmfLJR1qgdl/DMqW9Cfrm9fdTK9bc9G/bZidn
         BSrw==
X-Received: by 10.50.17.166 with SMTP id p6mr4797201igd.12.1364404450436; Wed,
 27 Mar 2013 10:14:10 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 27 Mar 2013 10:13:50 -0700 (PDT)
In-Reply-To: <CALkWK0kkWAkiANL-vL-OthKSDkoU2b_Q68frkGc06QNG7RbSFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219281>

Junio,

I don't see this queued in 'pu'.  Do you have any objections to the
patch, or did you just forget?

Thanks.
