From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] t3040 (subprojects-basic): modernize style
Date: Sat, 10 Dec 2011 00:02:39 +0530
Message-ID: <CALkWK0nDtdzsqVZQ9F8w8oWQZp__EXo5_LDEpPmiRBfx=J6Rhw@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-3-git-send-email-artagnon@gmail.com> <20111208163448.GA2394@elie.hsd1.il.comcast.net>
 <CALkWK0nbp465915ysrBXi46mur1dutBDtPNjwW=RdyPV03crzg@mail.gmail.com> <7vd3bxfvob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 19:33:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5Fs-00087x-21
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 19:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab1LISdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 13:33:03 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47469 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab1LISdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 13:33:01 -0500
Received: by wgbdr13 with SMTP id dr13so6166635wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 10:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QEeYYiPedF37Cv3W2XaTXnyQXs/dqgoE3vt7+HiSRms=;
        b=pgfY3iK10meCXmkOF+6icDtR2we2p0rODsUtZPw/NKeVfJAhP/lrM767qXU76PgY2I
         7QjDTNNVH5XlNOaapf3X57AFMdb4sG9jv95TWwy9Lt/j6iR/LAoiTVqnY/jNTysn8vUC
         xiYz3I+fUWzxW7/9ty9VkY15qknoiYRze5SGE=
Received: by 10.227.60.14 with SMTP id n14mr7581826wbh.5.1323455580384; Fri,
 09 Dec 2011 10:33:00 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 10:32:39 -0800 (PST)
In-Reply-To: <7vd3bxfvob.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186659>

Hi Junio,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>> Right, fixed.
>
> Does the "fixed" mean "I fixed it locally; please expect to see it in the
> next re-roll?"

Yes, it means exactly that :)
I respond/ archive the review emails as soon as I fix the
corresponding issue locally -- it's the only way to make sure that I
don't miss anything (although I miss a few comments despite that).

-- Ram
