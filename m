From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 13:46:19 +0000
Message-ID: <AANLkTikVp6_FW0Eq-PHRjXDvWBChuMGfOUrfkxIdW6Y8@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri May 21 15:46:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFSYW-0002Zw-O0
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 15:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab0EUNqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 09:46:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49916 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab0EUNqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 09:46:22 -0400
Received: by gwaa20 with SMTP id a20so457721gwa.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TgHq4ygl+YaLpChl9Q9iumGjUH7msdt5hEhHxoeMrqU=;
        b=v7AISk2BxTupVXp6MyK8Co8NfKBj6zmHFFtPMIbdaImKRclixmohudkklqJ8L6m8lf
         r186QR5BuZFQPctfRnFd7oglQJfPIaSpDvBNfMEj/9OMYH/ruQ+EBL6cuk9rp168zwmT
         b5zHhlaEVE653LMzqCoa96RlH+eB5MXGw2nsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Vep8QTdLegXNaClzPeusahWbm7/dg6+C6k7dSj/pPsNe54ai5Bv7lSowN0QL7j7RLV
         T85iNDUfCXoSX6YMAYEKD0uvgssOB0VXGa/5vHww9YsqulAVjUEryeKgF/2cPak1ShEc
         HfkE6T779EmYdmuz300DKujvOsw4frkq2HtGQ=
Received: by 10.231.178.132 with SMTP id bm4mr1116765ibb.62.1274449580287; 
	Fri, 21 May 2010 06:46:20 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 06:46:19 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147453>

On Fri, May 21, 2010 at 12:59, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> Is there some way to make "git pull --ff-only" be the default?

Not with a config option, no.
