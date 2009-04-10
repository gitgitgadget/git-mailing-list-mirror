From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Error Building 1.6.2.2 on Cygwin
Date: Fri, 10 Apr 2009 11:15:13 +0800
Message-ID: <be6fef0d0904092015o10457ca7u844fe868aae4de6b@mail.gmail.com>
References: <c115fd3c0904091210u398ea4bag62eac3a6deaffa5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 05:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls7EY-0005LE-IJ
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 05:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762039AbZDJDPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 23:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761849AbZDJDPQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 23:15:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:2815 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761743AbZDJDPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 23:15:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so890294rvb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 20:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y/8Pc1U4BSpEpfPEgmsNPiVZA0bsvCBVFaZlcSy4tpY=;
        b=mEZfaPohmNiE0J8olVUQA5ENqPXESdGRS1Bw1LW6i7Nz+LMIPIqZqM9mBfMFu6H9dV
         HKw2Mhvr+ns68RCokWmEb3RjJdZeU0VOuhv2uPhFwUdveH4nTFVNQwSpcSrLLhgZyo3I
         1Vzz2WYSgQ6V7G8HUlnmzcx58A5syY8vd9gh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IWug2Wa3aIDJa9FXdsD4sz7hr2NvTyqHOE7H9aZrJ92JtZnczcsiSVxzV1k2K0NU/p
         kCamaw2ZM4ZtFfgqo4leyM0T/VLRC/Mdj2zLD/w/0+ExMAZHQM3UJ1lajezI8HxUFU/k
         Kp8E0JoKLap27XglwwrqLfc8cc29My08z9B+o=
Received: by 10.114.192.3 with SMTP id p3mr1725987waf.25.1239333313975; Thu, 
	09 Apr 2009 20:15:13 -0700 (PDT)
In-Reply-To: <c115fd3c0904091210u398ea4bag62eac3a6deaffa5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116235>

Hi,

On Fri, Apr 10, 2009 at 3:10 AM, Tim Visher <tim.visher@gmail.com> wrote:
> cannot find -liconv

you need to get the libiconv package using the cygwin installer.

-- 
Cheers,
Ray Chuan
