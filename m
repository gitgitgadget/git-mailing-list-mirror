From: "Felipe Oliveira Carvalho" <felipekde@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 10:33:22 -0200
Message-ID: <a2075f4c0810230533k46968637o2e087da24caa01b1@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 14:34:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KszOf-0000J5-49
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbYJWMdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 08:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYJWMdY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 08:33:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:17990 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbYJWMdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 08:33:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so321133rvb.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XxpqTo7byqb8e1GUZje5qoapa7MRKGD4bOkka5Qpi1k=;
        b=D2AUyTQ9ILcrXTSdE6VG/3zIzLCwop6ejvNxhSTVkQcX0We7aX19krTRqRDyMzI6Kl
         H0u1oacOKKS4txkeUcriOosA4y0sUWpf15MOyM/fm/9effnIttyrecQq+cNAir/sz0a/
         LGBERkVpNlzpZ49BdEi+1ePJzKdsS7NQNj564=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ODBKhcj8GQAd5YbCEJKB68g5AFitZUHHSBhFPPqeHbY+dj1g9UDv3OezaipreRu5Z6
         cZekMbdG3g/+63lieC4st6a7mndszi84E9X+XFed2G15Sf4xmEFpjXWKs6vXgqZsezZu
         H1ApPleVZSg4KMJnFc+OTOMBSKZiqNqW+RFRc=
Received: by 10.141.163.12 with SMTP id q12mr310656rvo.260.1224765203024;
        Thu, 23 Oct 2008 05:33:23 -0700 (PDT)
Received: by 10.141.116.9 with HTTP; Thu, 23 Oct 2008 05:33:22 -0700 (PDT)
In-Reply-To: <gdok16$vh2$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98955>

It sounds interesting. I have some single files that I would like to track
using git, zit seems to be a good solution.

--
Felipe
