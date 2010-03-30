From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] Documentation/remote-helpers: Add invocation section
Date: Wed, 31 Mar 2010 00:58:22 +0530
Message-ID: <f3271551003301228i241f681mfa55f4ef871010fb@mail.gmail.com>
References: <f3271551003301218k4828c44id700b4865001baf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 21:28:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwh7K-0004Q8-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 21:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab0C3T2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 15:28:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44378 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab0C3T2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 15:28:44 -0400
Received: by gyg13 with SMTP id 13so2293989gyg.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=YJqPadN6MQRWy2cVPI/JnPjLdFwIG7r2/sNOlQbxIJ0=;
        b=sjdTQ1Lvs6ZR3zuQvgAZvYBEsnOLqh63MOoYPZPUophppRqMzvVeEH+y9E1Jqv4POa
         1gW2uzc7CdblmQIsgR1hsakx5Q1U3FEH17AXhyUfXD9wwsFJa1yY8AH3SISUJkq0KQem
         ox5BLyDjGro3sEESLhUiRjOu8ROiiAXLy4d5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rYiNQLVtL51joVDIT9UR0WP1bp+YSrwQKbG2aU3I8r3V+BsfUydZgb1NN+V/RvO8K4
         6BeLtWBlB4UAjY4lNHudep7jd8qRi7ALYxwjUtPD97IBcdzrCkfw1+JdRLxSobzH8WzQ
         kc78nu9o8jvgM0kaZZR73+v1TspNdix2zjSws=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 12:28:22 -0700 (PDT)
In-Reply-To: <f3271551003301218k4828c44id700b4865001baf9@mail.gmail.com>
Received: by 10.90.59.39 with SMTP id h39mr6014978aga.116.1269977323165; Tue, 
	30 Mar 2010 12:28:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143593>

Hi,

Oops, I just noticed that I've been forgetting to sign off on the last
few patches.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- Ram
