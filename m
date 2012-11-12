From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Tue, 13 Nov 2012 03:21:17 +0530
Message-ID: <CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com> <1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1vC-000235-1e
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2KLVvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 16:51:39 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57335 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab2KLVvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:51:38 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6759194oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 13:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hj6+WGuBf75tb5p/agBrglzi8Vme4EbEQ7F54DfveWQ=;
        b=QxWlv2WgKZ52pRC485sIUXnDxoKIDbhVcUHrPWzDWlTk89LC5aJXdnoYmCeGefYOFL
         zam/1Ec14WNC1ymE+BwwQDavVUzb18iMmAOPO+vrFTqzdv66Lj1d10/kf2KmVnBtBnE5
         OX3XIvxXe8Mv6f0fYHzfhCErdgr7dmZ2AVdagd7SfX/1fUghd3dV0rSy4q/hmGCHLx5U
         In/Hu/R9AMlcDDg2tYCP0kndkF0r9IEeBq9ehUWuKe5sOk/BPigMKcA+TAaTiCDToJMk
         sybi7JWyOICG3WjsAxv1hROgYvbXnvisFA4EuAZ5kYHdUFfpmEGupwfMzeX9AEUqnss7
         Pp6w==
Received: by 10.182.41.6 with SMTP id b6mr16499616obl.23.1352757097804; Mon,
 12 Nov 2012 13:51:37 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 13:51:17 -0800 (PST)
In-Reply-To: <1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209533>

Felipe Contreras wrote:
> cc-cmd is only per-file, and many times receipients get lost without
> seing the full patch series.

s/seing/seeing

> [...]

Looks good otherwise.

Ram
