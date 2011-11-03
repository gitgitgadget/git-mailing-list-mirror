From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: How to make "git push/pull" work in non-clone repo?
Date: Thu, 3 Nov 2011 16:07:36 +0100
Message-ID: <CAH6sp9M1PxxHqKC-M0rtsEbdsmY1vBb_m_6G=266QkVtTDE=EQ@mail.gmail.com>
References: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Hong-Ming Su <halleyinvent@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 16:07:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLytK-0007H9-Vn
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 16:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab1KCPHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 11:07:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54077 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab1KCPHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 11:07:37 -0400
Received: by qabj40 with SMTP id j40so1158616qab.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+pSjoP/NIuKnu8LSdNcCpHWyj03n4TWeJe0iYEFHERE=;
        b=hpS3fwyXNpMP2euOfFpg5Twf5mgHG0X+jkyHs2pilLyqhfMpwW1wxOWC/IQr/C+NaZ
         rfuiz/+ok3le0VTAloFqSZie7K8zP2kWZYb//bjjsGygKqI7C9UJk7MbINMkQm470Xzy
         PMYvkg5HIGwNyFe2IOEVuVc47OAoPuPlRxBg0=
Received: by 10.224.202.8 with SMTP id fc8mr5005418qab.10.1320332856459; Thu,
 03 Nov 2011 08:07:36 -0700 (PDT)
Received: by 10.224.80.149 with HTTP; Thu, 3 Nov 2011 08:07:36 -0700 (PDT)
In-Reply-To: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184720>

Hi,

On Thu, Nov 3, 2011 at 3:59 PM, Hong-Ming Su <halleyinvent@gmail.com> wrote:

> I create a repo X with git init. After several commit in X, I clone a
> bare repo Y from X.
> I try to continue work in X, and push to/pull from Y. The command git
> push and git pull fails. I see the error message but I do not know
> which git command can fix that problem.

Care to tell us which commands you use and which errors you get? It
will give clues about how to help.


> Then I clone Z from Y. git push/pull works in Z.
> How to make "git push/pull" the same in X as in Z?

Same here.

Cheers,
Frans
