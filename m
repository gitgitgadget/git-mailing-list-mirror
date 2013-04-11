From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] cherry-pick: make sure all input objects are commits
Date: Thu, 11 Apr 2013 18:57:40 +0530
Message-ID: <CALkWK0kj+At9-7=t=Vjh=WoAu_Xv2SOWM6+=eL5ySPYB3+ZEQQ@mail.gmail.com>
References: <20130403092704.GC21520@suse.cz> <7v38v1yn8o.fsf@alter.siamese.dyndns.org>
 <20130411092638.GA12770@suse.cz> <CALkWK0n6FjGbXTqiOT_O6NbB5h0DLaNWKCCTQAFSO_BL-pPdBA@mail.gmail.com>
 <20130411110324.GD12770@suse.cz> <CALkWK0kb+2KZLvRJDJb_VrNNs1k4grsfyFv0HfYv0Kr9v4sChQ@mail.gmail.com>
 <20130411130652.GG12770@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 11 15:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQHYG-0004lQ-I6
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 15:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935118Ab3DKN2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 09:28:22 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:49559 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933462Ab3DKN2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 09:28:20 -0400
Received: by mail-ia0-f181.google.com with SMTP id y25so451544iay.26
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WWFlBNE6X4cIPlQ5Tv3Zg5+SuRt6+qayn2AWJT/B4ng=;
        b=JOfpaVjbI3wOl1YFSyb1ouba+IG+PlyUviLd/PbsLPE69jQuuEYHvWNWvjoc8jJHjG
         bl9XVj/ct/aH3shQSSJ5bcVBu95wW5TS/9nKRDBV97PQPxL0pCtlsABFDTwEjX2vCHkz
         rfBIBJXsghK4p+AIieAQR5fe8eTb2wSu67SqxBhVtTRIZkBgGf+BUxHLVGXmtcyB5NQH
         /KfOqbfO+S92sXSoRQvU+0xOqz8r4OGnEgVk1XpyUtI1Bu471j2wyyVV0z4KZS116xTK
         jf/LlnrrXazLFw+spUWBAQH2b1/LgycztDCM1VtFRHZyg6oe+y8IazR7YWdzk5xbBRjB
         VY2w==
X-Received: by 10.50.117.3 with SMTP id ka3mr15434379igb.107.1365686900388;
 Thu, 11 Apr 2013 06:28:20 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 06:27:40 -0700 (PDT)
In-Reply-To: <20130411130652.GG12770@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220879>

Miklos Vajna wrote:
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>

This one looks good.  FWIW,

Reviewed-by: Ramkumar Ramachandra <artagnon@gmail.com>
