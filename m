From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v2 04/17] contrib: remove 'diffall'
Date: Fri, 9 May 2014 12:27:15 -0700
Message-ID: <CAFouethcivANTqnBH40v4ubUqRxuAnRsB_SRSMV=m-qGbax_OA@mail.gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
	<1399662703-355-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 21:27:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqS1-0007Do-7F
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbaEIT1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:27:17 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:51523 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202AbaEIT1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:27:15 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so5852597veb.29
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A5VLxIMOauIoUSg3Ia9X9nmuWcvvLy6p8oZDZI19XjM=;
        b=jVt3DlpOrSxYspsvb0/HBhfAtX9Q3C+LvDotG2W4hf1LdybhvzYBd2E2AblHzuT9dk
         pMDH38r87xKAWRbDLzOTta61hNJOZ1lsOGQ+3aHj3xxz025QndHkvJ+srPFgkwWF/ua6
         Bl3YCxgmGvVMHtGO0wyeGDpqM3OHg25Ean5eMICu4hNUxE3iv7owXnOgxHaei3sOB7eM
         bBTQqRWY1yA0n5oskAoY3icLzfIdAbRqaZJURlCU0NZ4QivX1udmf+18O3kjYW3i5A8A
         J8GHbwb42s74S+NVpWyiopVSvs4tMkzxjZ0PBWiKwglFzn7/dnMuECr23tm6V4GEl4Ct
         wBgw==
X-Received: by 10.221.44.73 with SMTP id uf9mr9778236vcb.9.1399663635235; Fri,
 09 May 2014 12:27:15 -0700 (PDT)
Received: by 10.220.95.207 with HTTP; Fri, 9 May 2014 12:27:15 -0700 (PDT)
In-Reply-To: <1399662703-355-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248632>

On Fri, May 9, 2014 at 12:11 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> There is no more need for this tool since the --dir-dirr option was
> introduced.

s/--dir-dirr/--dir-diff/
