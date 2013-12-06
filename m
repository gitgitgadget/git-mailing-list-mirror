From: Muzaffer Tolga Ozses <tolga@ozses.net>
Subject: Git reports
Date: Fri, 6 Dec 2013 18:51:47 +0200
Message-ID: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 17:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voyd9-0000JH-VE
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 17:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024Ab3LFQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 11:51:51 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64319 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3LFQvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 11:51:51 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so1244547wib.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 08:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=binxy0Qj9jLpibBIdcqZfpxHdjMbwfmzna8q+CAdovA=;
        b=KkaaWl6ZxNgAIZhvNjgwqJjNd0MfBPix8mVTWGVaONq5YO0EuTbeT/MZLtcLqphuEu
         LpnhhGY3nnQHUe9K+Dtp2EEJkfzLP7JtdkwM/jFe3Ye02IzEhzRfyqbWE2q2iuCKBZS3
         /otYjB+QKaHojHVHOjFjLBlJjXLuBf+9y8Zobp13mN3ZxQPRPfUvJKc4NLpo0jHxgG0m
         FC1wyUqgYidAL63bqFUWOugYTHttt6+zdYuQUhKI7pcqMPIcog+9cQwneb8uzKYnUGHE
         FXFsV3ECkUuok9vv+/eBXLFhRNfGC2o74DMwe39zuT9e6esh5PF01vTTqv82Scytxm78
         DdzQ==
X-Gm-Message-State: ALoCoQk0cwSLFN778v+NT9rwmbnL6H6te0bBNTJablcf9XsQRfANWIIsgStT5JufQoIU6hLJcY7Z
X-Received: by 10.180.108.42 with SMTP id hh10mr3346091wib.15.1386348707467;
 Fri, 06 Dec 2013 08:51:47 -0800 (PST)
Received: by 10.216.174.70 with HTTP; Fri, 6 Dec 2013 08:51:47 -0800 (PST)
X-Originating-IP: [46.196.57.29]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238933>

Hi,

On another git server, I get reports like
Cloning into 'tcmb'...
remote: Counting objects: 704, done.
remote: Compressing objects: 100% (574/574), done.
remote: Total 704 (delta 369), reused 107 (delta 60)
Receiving objects: 100% (704/704), 129.99 KiB | 23 KiB/s, done.
Resolving deltas: 100% (369/369), done.

whereas I don't get those with my own. What could I be doing wrong?

Regards,
mto
