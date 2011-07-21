From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: git log format specifier %d not showing colors like --decorate
Date: Thu, 21 Jul 2011 19:53:09 +0530
Message-ID: <CAMK1S_jq=Hc5LWr+oLO4K9f06LtyF4ZQfxQDqAO75vzma8f0pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 16:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qju9k-0001HX-JG
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 16:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345Ab1GUOXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 10:23:12 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44901 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1GUOXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 10:23:10 -0400
Received: by vxh35 with SMTP id 35so911434vxh.19
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=j8dGF+hOxVEZVUQ1L8rSvVbeKqkjfaRTJ628RBbpXuc=;
        b=Dp88xceFeoR3G0tE34wnRLTGJrJagdaJf6115+DYCm0PBkyHFt+ZLSjzBPNlwfFno6
         22FR5NRbHyJ0o/sptgblwP5QfLNls4qjSJ6Y6a51chUC1cWG/JbvpfpdwssEbxKdnO+b
         iZdP4UPo7Q/s+WYvHjG6apx+SjLNi23qLvVgA=
Received: by 10.52.173.235 with SMTP id bn11mr350530vdc.19.1311258189770; Thu,
 21 Jul 2011 07:23:09 -0700 (PDT)
Received: by 10.52.167.105 with HTTP; Thu, 21 Jul 2011 07:23:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This is a minor nit, but does anyone know of a way to make the %d
format specifier show colors the way --decorate does, (and then to
make it respect color.decorate.* config values, maybe)?

Thanks

-- 
Sitaram
