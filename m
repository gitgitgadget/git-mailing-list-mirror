From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH next 2/2 v2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 09:13:02 +0200
Message-ID: <AANLkTimY0lMz32ZfxKMRF1YW0SFDNnDFUE3_dA5-Ki-6@mail.gmail.com>
References: <201006100040.54375.johan@herland.net> <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: johan@herland.net, git@vger.kernel.org, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 10 09:13:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMbxA-0001Md-4F
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab0FJHNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 03:13:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55055 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab0FJHNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 03:13:22 -0400
Received: by mail-gy0-f174.google.com with SMTP id 5so4484060gye.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=gI1j2QuRG1bH0aqczxLAEsyKHhpEKzWc2hd9fW7hYPg=;
        b=taNg68nCtUjSP2mm4jvFTZivTcIRa31FnXcl0UaUWPFhuQQFY5YikHzVR8YD9JQ2jO
         DrcU54baujANdbhlTK5x3XdFLqZPEraeSx6fCjGOmzG4sI/D6J11/CvKHzoLvFw2Fqmn
         EDlaa+/25KYI15JvvD104yEkLIw9NGGh2+jvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vKQYr8fH3jcma6WBGZjRVWLkv7KL8etQtuGPaYd6FT3/+ByTiUQXX/bksz4ayGI24D
         NWRAss8B87cPxMy1M5tJeynDX03xE4QpH3YlQXgPXTh5ffMgTblaCR06ziRW24mSqyAJ
         /8m6LJkTLD6G6bBsF3lqE2anr33Hjfgrjjd04=
Received: by 10.151.1.14 with SMTP id d14mr1457015ybi.103.1276154002119; Thu, 
	10 Jun 2010 00:13:22 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Thu, 10 Jun 2010 00:13:02 -0700 (PDT)
In-Reply-To: <5ep6Hc9Nl3QLKwV46xET5ZLhqo2uNlnUL1-nNsG9p2IWyX-odykArvT4ontRdeBUA9ouCPQGFwQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148834>

Heya,

On Thu, Jun 10, 2010 at 02:24, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Like this? ...

Assuming it does the right thing (can't test right now), yes :).

-- 
Cheers,

Sverre Rabbelier
