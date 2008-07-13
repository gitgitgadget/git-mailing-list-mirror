From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/4] Proposed patches
Date: Sun, 13 Jul 2008 12:42:22 +0100
Message-ID: <b0943d9e0807130442k36a10747q7bcbd996cdc774dd@mail.gmail.com>
References: <20080713113853.18845.37686.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 13:43:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzz8-0006iQ-NK
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbYGMLmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbYGMLmY
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:42:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:29133 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYGMLmX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 07:42:23 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2647459waf.23
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QqXRFbPQw2T1z6A1M+pG47DWABcc5QIb/jpQCX9z4HM=;
        b=YQbt4VPPiEEPfKWDeEREXdXypjAtgq3/z8hMsmm7CEvByNvc5W++NAuEM5E88Y+2sG
         1Jgot0wxwv3VJHAHURefVQ9rF1HkT+8y7+N75+zhajxTqBLUvX7WIiPxBJMWctAzFr1e
         5V8JM5WJ4bSA5SoHSSYtbZm+idStQcCJkfFEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jhAZSzx+imoWvFbu3qkLT2nLDKMP5QyZdNiK3goJiqvHJsqYcCRd+MbbWeevYVN36I
         1gctTVjlxF0KeKP41c9t+wWfBftO2uRB5+BmYcf9hRjSDz86vMFNke5mTSNn4Han0hFd
         AbjlY/uqlPXpdgDUwjMqzc/RJyctZUe2CIm9Y=
Received: by 10.114.155.1 with SMTP id c1mr16417093wae.24.1215949342934;
        Sun, 13 Jul 2008 04:42:22 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 13 Jul 2008 04:42:22 -0700 (PDT)
In-Reply-To: <20080713113853.18845.37686.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88305>

2008/7/13 Catalin Marinas <catalin.marinas@gmail.com>:
> A new post of the proposed patches after implementing Karl's comments.

BTW, these are StGIT patches, I forgot to add the prefix in the subject line.

-- 
Catalin
