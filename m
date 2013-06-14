From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] pull: clarify the large && { ... } form
Date: Fri, 14 Jun 2013 16:17:21 +0530
Message-ID: <CALkWK0=_K8-drmpkEGkWE3h0fvm=RsQPu3gaDY6Nhkyg2mRHDg@mail.gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
 <1371200178-9927-3-git-send-email-artagnon@gmail.com> <vpqr4g5kqht.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 14 12:48:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnRY8-0002bc-A5
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 12:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab3FNKsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 06:48:03 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54046 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab3FNKsC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 06:48:02 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so1015606iec.21
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CHlN3sb/di4AzUBgha0v4IOuzAmx7O1c3v6Tt9A8q5U=;
        b=ZMHw7e+HWhEVe2JvMm7KHdNE/fNgBmxmD5+I6/gadXLWwitj6Y9HGjR1mFLUr5xvY/
         kHWAbX1IF8+zQ7/lTMbzT5BzjN4NMQTyVOlg1CUBNFNU85SqGSVn6c5Y4jkmQXS2junG
         gw31jgJvSusmJsCp6k64UXOu/8lMsHsDHwOMpB/LBxN6lJV4LHtpQCQC7gyB1MVQ79go
         kunptyZ3ngXY4bgbxharrVPB5VzE290iLhhX9X8XmdnaTi3QOS4u/0Y/hSq/IfF+E25D
         8Klej7uz5bzFz0qt6UyrysPZQ8GVIzLHr+Nxo3h/b6vUMBt1oBKAIcK8z/EXYSvjNGNH
         UYMg==
X-Received: by 10.50.25.194 with SMTP id e2mr752065igg.111.1371206881656; Fri,
 14 Jun 2013 03:48:01 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 03:47:21 -0700 (PDT)
In-Reply-To: <vpqr4g5kqht.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227810>

Matthieu Moy wrote:
> Use a newline, not a ';'.

Thanks.
