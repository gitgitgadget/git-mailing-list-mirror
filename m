From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: git-p4 under cygwin
Date: Tue, 3 Jan 2012 17:07:23 +0100
Message-ID: <CABYiQpmPO33d0UUMKoa5DNWLqeKyBtYJ0azoHS0hf8zPN4suLQ@mail.gmail.com>
References: <1325604726.49597.YahooMailClassic@web132101.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Paul Chown <pmchown@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 03 17:07:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri6ti-0008JR-5K
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 17:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab2ACQH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 11:07:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34618 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930Ab2ACQHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 11:07:25 -0500
Received: by eaad14 with SMTP id d14so8741716eaa.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N2OIfebWfY6m8kPO5x0eEgaDQLHq8jHWPXYiMy4IPrQ=;
        b=R7Oke5dl3Mhn8nPklvtKTOrZMEdl0Q1D8D8rbJMhHt+X8WujwNUHv8NxZb88iG0FEH
         eaEv/uPqn6R+aw06ocbAR4nRg24qxo/cKXfJiQlMrbw8RwkzC0UJKogdmRAaDn/Z3wvn
         92YE+tOxhADK4j1So7Q9n+Qd9mpCAIje7wXko=
Received: by 10.205.131.16 with SMTP id ho16mr11947489bkc.105.1325606843916;
 Tue, 03 Jan 2012 08:07:23 -0800 (PST)
Received: by 10.204.50.198 with HTTP; Tue, 3 Jan 2012 08:07:23 -0800 (PST)
In-Reply-To: <1325604726.49597.YahooMailClassic@web132101.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187868>

On Tue, Jan 3, 2012 at 4:32 PM, Paul Chown <pmchown@yahoo.co.uk> wrote:
> Path '/cygdrive/c/work/perforce/config_test\...' is not under client's root 'c:\work\perforce\config_test'.

Ah, sorry, I did not see this part of the error message when I first
replied. This does seem like a cygwin related problem. Not sure how
easy it is to solve. But as mentioned, msysgit works fine with git-p4.

- Thomas
