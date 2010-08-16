From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Patch for git-completion.bash [SEC=UNCLASSIFIED]
Date: Mon, 16 Aug 2010 01:09:18 +0000
Message-ID: <AANLkTimGrrvz6myV=Fmioqh9=rt+Fh7qSSLcoma6Z-Bw@mail.gmail.com>
References: <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865@BOM-VMBX-HO.bom.gov.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "spearce@spearce.org" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Scurrah <D.Scurrah@bom.gov.au>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:09:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkoCb-0004uc-AI
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab0HPBJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 21:09:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37817 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0HPBJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 21:09:19 -0400
Received: by iwn7 with SMTP id 7so1117021iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=c2tHHZCYJx5RlJHsHrctjA9mupB+spLQ3Jll+ZLOflE=;
        b=MSgKaUNTxPgWkZFzYUl8iac9Rxh1E5p/MaXNU5c++4lcBup6fi3bjI+AZfQ7VbAxXB
         L46fGAS/Ie8T6hMh/G+e9j+v8B6donoRrGTtdmgrxRCvJtc93tgUliwFqnhTl+HevsM7
         agQfSd0zKuYu6PsHWnoLrcVdn+GeYbyEvmIpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lZ0A2E86AYaShw5rgkcTjiajo85uHvtK2PaKFoo2+Pve6NnXPXU+cWue3pr7d1UldC
         lpoCeCJOOmijVOpr5H9C2LNznFGoIsrB1y2Fa1K6m8vmwlccSLEpejU5SwDVS/xguqX+
         E7Ckbkqnd4JEuyuSa7V/9rQtdrJ8HxH7ns+5c=
Received: by 10.231.30.134 with SMTP id u6mr4984138ibc.121.1281920958975; Sun,
 15 Aug 2010 18:09:18 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 18:09:18 -0700 (PDT)
In-Reply-To: <0E3686EB9FA8AA409AFA0A25468DCE4301309C3DE865@BOM-VMBX-HO.bom.gov.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153638>

On Mon, Aug 16, 2010 at 00:53, David Scurrah <D.Scurrah@bom.gov.au> wrote:

Thanks for not sending a classified patch.

Have you seen the "[bash-completion] syntax error near unexpected
token '<' on line 123 in bash_completion.d/git" thread recently on
this list? It probably describes the problem you're having.
