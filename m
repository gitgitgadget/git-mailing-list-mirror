From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 4/4] git-submodule summary: documentation
Date: Sun, 9 Mar 2008 21:12:57 +0800
Message-ID: <46dff0320803090612g5b334a16hac91cbf6864bb9da@mail.gmail.com>
References: <1204914439-23145-1-git-send-email-pkufranky@gmail.com>
	 <1204914439-23145-2-git-send-email-pkufranky@gmail.com>
	 <1204914439-23145-3-git-send-email-pkufranky@gmail.com>
	 <1204914439-23145-4-git-send-email-pkufranky@gmail.com>
	 <7vpru5v9mx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 14:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYLLO-0008J1-Fr
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 14:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbYCINM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 09:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbYCINM7
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 09:12:59 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:22539 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYCINM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 09:12:58 -0400
Received: by an-out-0708.google.com with SMTP id d31so357854and.103
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4JBjPEP1leg4dwz8kmfYsjdslBKJaBX/bBdTHTVOAUs=;
        b=nsCPU218slmSY4dU+Y9Azjz3TMKhpWbQPYYVEZ0lUHlj0snyRyLVbKSahtMdJihedA1A9UbsUPYAnVnD3+YSnAfUm34OaNBzz9XE+7bR4h+ZpLS2mVEDXe3G7Pa1V5f+Wvs3XQWOTtaacDI9KN1uHTjiYkPB0V1jR1GCFQyvD8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KMaXVUYqVUvrNh/Jte37vvflg8Ua+LyKsZTpIrFuKD2eXism1s62xKCJpjhyLJhjq+aaeq8JzODSwZLKQnZqYZoQzlYEmvOZKr+ctTGjlVN+sqLNBjMR4Y4ANpMfxQDBZPuOs4rV7w+1HQBSFzCLwbm/Tm3DNkHjVzJURTwP1DQ=
Received: by 10.100.121.12 with SMTP id t12mr8777950anc.113.1205068377687;
        Sun, 09 Mar 2008 06:12:57 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Sun, 9 Mar 2008 06:12:57 -0700 (PDT)
In-Reply-To: <7vpru5v9mx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76659>

On Sat, Mar 8, 2008 at 5:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I've replaced the previous series in 'pu' with this series and queued in
>  'pu', but with a few wording fixes.
>
>  I didn't closely look at the script itself yet.  I thinkthe series is
>  getting closer to a mergeable shape, but it needs tests.

I will send my tests tommorrow


>
>
>
>



-- 
Ping Yin
