From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/18] Explicitely assign local variable as undef and make
 a proper one-instruction-by- line indentation
Date: Thu, 6 Jun 2013 21:19:32 -0400
Message-ID: <CAPig+cSp4N-XXyv5+nobBmKcBYkuo++o1WDGuA2Vqi0HPo3Mmw@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-9-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 03:19:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UklL9-0006Zw-5j
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 03:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab3FGBTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 21:19:35 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:64366 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944Ab3FGBTe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 21:19:34 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so3664673lbd.6
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=REzLW66dYC/1pcB5WNXHJFRbYoq8YLCEfsRpFUHoaps=;
        b=x95I8NlPilRO7GMDQMWwx3/U1bAgHHcd+x0XM+D8piM4N/Bg8tXmCDTGyaCHcg5T2d
         hvz+v1Ni6Uuuimi+5YTXlwFAQBaTuScHipUBeAlH0fIhrPAALqF+SE47HR0LjICLujSQ
         w7euiIrDOFXhx8ddID7gu6+r+xAxEmO4v53mF8Xv02Fsrwgrdz1+c4DIVOwVAJJl8iyM
         vstKyl1/5VMaNv1TdiqVsMipLhTk9PBOqZVdYFRkKift08EGpOyEubs8GAFB0/u2RabA
         YdbEgCEnBNX/9c+uw3XeoLEZ5LfoU6sbzZIVcsi06vnV2Gtyw/vDrSOUAM0WB372h5tp
         sANQ==
X-Received: by 10.152.43.82 with SMTP id u18mr1360929lal.86.1370567973027;
 Thu, 06 Jun 2013 18:19:33 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 18:19:32 -0700 (PDT)
In-Reply-To: <1370547263-13558-9-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: WhwsCRNOOXJvIwntNvF0iTNDLRE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226575>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> [PATCH 08/18] Explicitely assign local variable as undef and make a p=
roper one-instruction-by- line indentation

s/Explicitely/Explicitly/
s/by- /by-/

> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
