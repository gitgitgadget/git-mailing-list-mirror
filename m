From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git diff is slow (--patience is fast)
Date: Tue, 9 Aug 2011 18:49:15 +0800
Message-ID: <CALUzUxpOR-YZh-GKzivyKVpff9ue-t3qEoNK4wGsZZjX_a1=-A@mail.gmail.com>
References: <loom.20110809T093124-847@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Aug 09 12:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqjs9-0008Kf-S7
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 12:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab1HIKtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 06:49:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46822 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab1HIKtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 06:49:16 -0400
Received: by fxh19 with SMTP id 19so6365075fxh.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NzmCrrmOGVi85vqwUrDVyBy83U6LHkIv67qqPIJ6lLM=;
        b=Q7fPcvYRqKxmRp91Z5zi72w3VEQ6JZev1IDMC1SJW9NyRbiyc61kAxkbBRDEkp4Tul
         1R8DCO5QoN3GMgTSZJtvCOu6ISQLP9lJIqFQIcrgQH29HFS9W1d06Pr7Qcx8jLWPHAZr
         RmHZiPJsI0JgJqTvOzLqmPettgRnrhvxGyqm4=
Received: by 10.223.1.135 with SMTP id 7mr1410515faf.46.1312886955197; Tue, 09
 Aug 2011 03:49:15 -0700 (PDT)
Received: by 10.223.102.135 with HTTP; Tue, 9 Aug 2011 03:49:15 -0700 (PDT)
In-Reply-To: <loom.20110809T093124-847@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179029>

On Tue, Aug 9, 2011 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> Warning, downloaded files are 7.5Mb each.

I'm having some speed issues. Is it possible to make your repo
publicly available (eg github)? Perhaps the compression git does for
its objects could help make downloads zippier.

-- 
Cheers,
Ray Chuan
