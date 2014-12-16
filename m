From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] tests: make comment match the code
Date: Tue, 16 Dec 2014 14:09:59 -0500
Message-ID: <CAPig+cQ0s_oFk8J2QQXoY3OGpBCJzW7QKuWb0Qin06=qtq-uAQ@mail.gmail.com>
References: <1418719205-13832-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:10:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xVW-0001Xi-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbaLPTKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:10:00 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:63043 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaLPTJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:09:59 -0500
Received: by mail-yk0-f179.google.com with SMTP id 19so6161352ykq.24
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bV0yuCKYhsAEj0cHoK3bhS61U0d/OjLSiikqQPCU5Ic=;
        b=j52QcudCa85GzYwvDfKWvn/rDgOiG94RDN7EPBWJ0Y75wOMbeYni+q8oA1czLpqFD4
         QSUuNg+7VZDS6HkUsExMtoxIksj22GsiDxOfMCQJSOFQy0TvwzcQblXpMpaa4tAAkfTW
         A8+5j3ebfzuDiMq4fHHw+xFCxP2MH1driwyGuXg8uIm+aZYDqGQS50MMTsvmAqK/6l/b
         Wsc41UFR1A+UmwZkQnqDMc6Sc8ZqBTWQh+jbe8S/dqhXAEFhtNga3yk6GYjZ5s0Y1IfV
         RpImw4cHP9KZqH23Ar3CYO0X1GUwquRir/eeNKlu7ycfNUX86UWDVm+6Xm7BOpy5PRss
         VzFw==
X-Received: by 10.236.105.210 with SMTP id k58mr9646889yhg.52.1418756999185;
 Tue, 16 Dec 2014 11:09:59 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 16 Dec 2014 11:09:59 -0800 (PST)
In-Reply-To: <1418719205-13832-1-git-send-email-mail@eworm.de>
X-Google-Sender-Auth: oeyJ-zV32n_eBltpXwMrNTfOsv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261452>

On Tue, Dec 16, 2014 at 3:40 AM, Christian Hesse <mail@eworm.de> wrote:
> GnuPG homedir is generated on the fly and keys are imported from
> armored key file. Make commet match available key info and new key

s/commet/comment/

> generation procedure.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
