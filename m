From: Dilip M <dilipm79@gmail.com>
Subject: Re: git log --graph
Date: Mon, 12 Oct 2009 08:31:59 +0530
Message-ID: <c94f8e120910112001l50f9332fs43d0762bbd9207a3@mail.gmail.com>
References: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com> 
	<fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 05:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxBGO-0006RO-0M
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 05:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbZJLDC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 23:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbZJLDCz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 23:02:55 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:61684 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZJLDCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 23:02:55 -0400
Received: by pxi9 with SMTP id 9so8245295pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=u5ZzTNULpzqtkPRa5GA58a3KeKP3l//1TeNy31aDWiA=;
        b=XGtgbURmnqMwtou/UgmOnKF4xnU7U2YPwnxRbWk8SU6q2ibIQFV7Jo4N7TP+ulQc9i
         K7rLmLkjAOZZqVv9gBCkqikqSWgvgKGTmxdglRK0vpyaQXO4+AUaF1xscxmN8YYMS5cK
         lYDYvQuKKhtituYx9VRvGVPBMvW+Le3Ouwm+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FR/O5r/JgrsS3VJroPgDwbjRDLbTCwvSWykEw3pq7r/+CnJ8gB+D04osaTlz7p+cIF
         WYcGdKxNi7Huhd7ZT8nbpEsyN7PkoFUT7i+YYq1PK6jAYcm8e/PEbdSq8KCszS3YCSKj
         ARX+mywp0zcFdIbLpfcCuqnjvKLJfVx/nsQao=
Received: by 10.140.191.12 with SMTP id o12mr378847rvf.163.1255316539056; Sun, 
	11 Oct 2009 20:02:19 -0700 (PDT)
In-Reply-To: <fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129971>

On Mon, Oct 12, 2009 at 12:05 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sun, Oct 11, 2009 at 20:27, Dilip M <dilipm79@gmail.com> wrote:
>> I am trying git log --graph. (has commits in two branches...). But
>> always see one line :(
>
> It'll show you the history of one branch at a time online, you won't
> get the demo-ed multiple lines unless the branch you're looking at
> contains merges.

Understood. it shows only when I have merged conflicts!

In case, it is a fast forward merge. It doesn't show. Which is good :)

Thanks to all.


-
Dilip
