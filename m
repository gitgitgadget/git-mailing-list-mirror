From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: implement idea firstly in script language?
Date: Thu, 31 Mar 2011 20:27:38 +0800
Message-ID: <AANLkTikq7iJt97Fq-TQH63RCrrvOJb348yhYDYW4qJL6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:27:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GyW-0007mN-5V
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab1CaM1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:27:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50262 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381Ab1CaM1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 08:27:38 -0400
Received: by iwn34 with SMTP id 34so2351902iwn.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=jykAQP69RrFXxBkbFhqZoXeHMIabIiqrhuWhbNXnhso=;
        b=lHomsNLEZshvUsi3TPdoAkAaQB+eXefiUeJru36FscFht7HNvbGRMMXQ0ecAfo0fu2
         Dd2ON5fKrlXttbNi/LES/xuIWCWVFLuMzKJkA5A+oiUEQHq3a0oN4lp52UCCxlOd2lcH
         7Sp93qKJtq2pmPNgvy9UUVuGzycQrSFYdNtHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kM8caYUgnTqjiPeC+0E3vqkNOmTDs4ZTtQSQdL/Fck8b1N4bPIOSy0C7nS6pmX+Zs3
         mLMDaBMBNcNp3jDPrOusozw8L6TiCHg88rO9iF5v3g6LCY8CdFOTmHLn99IDa3MyNDw0
         M0YOAhnh7zzt0xG2h3B5ZTKVv/+lTUSyes9j4=
Received: by 10.43.55.78 with SMTP id vx14mr3190666icb.410.1301574458308; Thu,
 31 Mar 2011 05:27:38 -0700 (PDT)
Received: by 10.42.165.200 with HTTP; Thu, 31 Mar 2011 05:27:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170482>

Hi,
i'm wondering to implement one idea during SOC, should i take time to
implement it firstly in script language(just to see whether it works
well)? And then rewrite it in C later?
Cheer
Di
