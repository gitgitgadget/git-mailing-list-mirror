From: dhruva <dhruvakm@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 12:46:30 +0530
Message-ID: <e3f230850810270016r53588f9duce6ede57a890ab89@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org>
	 <ee2a733e0810260805n35c3a637v4739dda938a22518@mail.gmail.com>
	 <200810261955.10536.jnareb@gmail.com>
	 <200810270120.55276.arne_bab@web.de>
	 <ee2a733e0810262115h705356dfmbc2237f8e88f3985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Arne Babenhauserheide" <arne_bab@web.de>, mercurial@selenic.com,
	git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 27 08:17:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuMME-00061P-SD
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 08:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbYJ0HQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 03:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYJ0HQd
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 03:16:33 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:63800 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYJ0HQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 03:16:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1072835tic.23
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HMiwy7PDz1aWWQX8/mmG+0C87ajYgeC/icTqXz0usyA=;
        b=hmROQjrDmcI976eNalN7T3hRzbv+u+XY0wU4UiQSl5Tcw+F7aTlvJd6ZEY/9RKYuPh
         v+UnmjrORzNpBXRQkCdFBSOI9yxdCDfAh6O3C+g+k/dH/c9WPugkNMDO3gZhA1X0Vq3v
         4br9He05YuASezS7NXbLmMYyGWubxwsHtHEws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AdQcKf5tdtks+rGCnOgPBltCrhzA/lYDRzcW/TFbeFSOuEcPm/4I+1z5rvXSZ07xb7
         TJtWdF4lLm1aqR4qbQIdbkNHrzOljNMjouseR0Wpe5xAS4U/b8uo2lJqtcSWpE2udOWb
         vtHY0ygyl1V/HmfhZD0owSDSxhGde2SgWmAyM=
Received: by 10.110.39.20 with SMTP id m20mr3229624tim.59.1225091790857;
        Mon, 27 Oct 2008 00:16:30 -0700 (PDT)
Received: by 10.110.93.2 with HTTP; Mon, 27 Oct 2008 00:16:30 -0700 (PDT)
In-Reply-To: <ee2a733e0810262115h705356dfmbc2237f8e88f3985@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99212>

Hello,

On Mon, Oct 27, 2008 at 9:45 AM, Leo Razoumov <slonik.az@gmail.com> wrote:
> (2) Hg forest extension is still not in the tree with outdated and
> incorrect documentation in the wiki. For me it was biggest reason to
> migrate from Hg to git.

There are a few extensions that ought to be part of main hg, I have
proposed rdiff and am still waiting to hear. Since hg depends a lot on
extensions to extend it (good design), commnly used or useful
extensions must be made part of mainstream at a steady pace.
Otherwise, new users who are not aware of existence of various
extensions will start comparing main hg with git. Since git has most
of the features in the core part, hence the comparisons will be not
apple to apple.

-dhruva

-- 
Contents reflect my personal views only!
