From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: builtin-status submodule summary
Date: Sat, 15 Mar 2008 01:45:15 +0800
Message-ID: <46dff0320803141045w5cf1506fw9ab676f041a4bd12@mail.gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
	 <46dff0320803140730jeef5808r7da67a103ce7b171@mail.gmail.com>
	 <7vprtxp8ew.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:46:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDyu-0001Fj-D9
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbYCNRpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbYCNRpS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:45:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:29585 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbYCNRpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:45:16 -0400
Received: by wx-out-0506.google.com with SMTP id h31so4396688wxd.4
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=w7u4ksI3VSK/qqEqmIzJLwc5LEO4SlGXzZcgK2ZwOUA=;
        b=m3Baa01sFkIMFDr9VzouLhNiYTxl+gfOo5AUYXZMMuAQMctpRyyBrYlbQ1hzjr80XCAXszkw/evLM4yc5mFDaWcwXZMj6K2emQy/iFyPqF2PdjrbdMieJVczVtX+cnIEZ105UF1vQxYsZz/WO49pUFUxoQscxoLrv+HUitVWhos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Frb5deG2yP+TATGK4ofqJSx84265WIl1GDq+2Htw3NFUc/WJ9/WptumP7i9b+n5UQRBqhPbaXEe2ocyDe+st9LbkfThVyg9CYZ4BX5wM4DA40i40KK6/uF4GS712Bk6asB7ovUOH+7NsLzs4LXGtXohTuE2dpbIqYFZ7qmTFims=
Received: by 10.100.12.1 with SMTP id 1mr23461335anl.5.1205516715635;
        Fri, 14 Mar 2008 10:45:15 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 14 Mar 2008 10:45:15 -0700 (PDT)
In-Reply-To: <7vprtxp8ew.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77265>

On Sat, Mar 15, 2008 at 12:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>  > So i think this series should go along with the submodule summary series.
>
>
>  Recall how many rounds "submodule summary" took to get into that state,
>  and how much time and effort were spent on it.  Use it as a yardstick to
>  guesstimate how much further effort and time will be needed to get the
>  changes to git-status into a reasonable shape.
>
>  It may happen eventually, but not before 1.5.5.
>
So i'll resend my patches considering suggestions from Johannes Sixt
after 1.5.5.



-- 
Ping Yin
