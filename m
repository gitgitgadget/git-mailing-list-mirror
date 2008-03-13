From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 0/7] git-submodule enhancements
Date: Fri, 14 Mar 2008 02:16:17 +0800
Message-ID: <46dff0320803131116k5a4caa84x658369c491f1a175@mail.gmail.com>
References: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 19:17:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrzA-0003I7-A2
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYCMSQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYCMSQV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:16:21 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:11188 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYCMSQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:16:20 -0400
Received: by an-out-0708.google.com with SMTP id d31so843566and.103
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=f+P/CAm0aAlZ1YESBV6uvZEDDOc42pIkADxxlOQYvMU=;
        b=oN/pv5ByFVTPmfvYlhsJwebRRFesYXtNLLFjUVtebLq/O2brGXiewfgwTf+ei0d6R86193WdxWyoygASF6N0cz1ES9az4rxB01H9UYzwinEP+aVhR3y2n/JFfkd4CK5U0DxooKHDbjhA5yuZszqV6MEcpMqBM77oB16KteRe5AY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SYMa/Wfw8Fa9XihdomiF29c6iZtbGm+6wQ3JNymteCNWzUt2QSmCC0/sZPiiogaf46mVmiRk1XKaW1DzTHhII4Brat7ur3YuIWqJJIi2sazeSqwN4vg4XBu3hW8edhxaciKE+/V5t8GTUAqiNmgYB0CI7Atlu3sOqs5nNKnuZao=
Received: by 10.100.96.9 with SMTP id t9mr20334009anb.102.1205432177592;
        Thu, 13 Mar 2008 11:16:17 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Thu, 13 Mar 2008 11:16:17 -0700 (PDT)
In-Reply-To: <1205431001-18590-1-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77123>

On Fri, Mar 14, 2008 at 1:56 AM, Ping Yin <pkufranky@gmail.com> wrote:
> This patch series do following enhancements for git-submodule
>
>   - Fall back on .gitmodules if info not found in $GIT_DIR/config
>   - multi-level module definition
>   - Don't die when command fails for one submodule

And it's built on next


-- 
Ping Yin
