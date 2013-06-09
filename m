From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Document .git/modules
Date: Sun, 9 Jun 2013 06:59:17 -0400
Message-ID: <CAPig+cTHFcvWyoQMConxRTgEz4pq4_3Y-abFp8xAPjsdHniQ8Q@mail.gmail.com>
References: <1370774269-3258-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 12:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UldLU-00055X-Lw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 12:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab3FIK7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 06:59:19 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:53534 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab3FIK7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 06:59:18 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so2675051lab.37
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=0jwjgBENKgSz9OQKbYd8AUmQu4gKuJqqwra5u3kARvA=;
        b=OUeJwP6f0PebcXcL6CLqz4J8WaRPRugMHW4+lgUNReVH8Yf5H4t1/5GBU7q6KVdPyq
         aLdrJXIQ/shODsUKlJ0gS61+efkPVwjGefiO332T5oDsROTBYghAqdGjw4+uu4wuALMo
         88mGlKtQ7bTFSwMdSgcRcDU5h+W0tZ+syOyH/TM75r6FdlBnr+HoSLitU1RE/OHbZA3O
         RQq3mkZaT4PbVVNDdJv7/cifYfXSOq9k53VAcM04ech95K30gsvd2iQ8FJ+oLx4EukPN
         U1yHRprtKouzmgi8sTC/fgs26TCFehYGfgW1C+uh/ghTOumgwOfOw126oiYP+44eHVbS
         FCQA==
X-Received: by 10.112.219.133 with SMTP id po5mr4351925lbc.80.1370775557232;
 Sun, 09 Jun 2013 03:59:17 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 03:59:17 -0700 (PDT)
In-Reply-To: <1370774269-3258-1-git-send-email-iveqy@iveqy.com>
X-Google-Sender-Auth: Uwkl01A1E4dHXJVGVGtaIZgoFxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226951>

On Sun, Jun 9, 2013 at 6:37 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> A note in the begging of this document describe the behavior already.

s/begging/beginning/
s/describe/describes/

> This patch just add where to find the repositories.

s/add/adds/

> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
