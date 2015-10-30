From: Andrei Borzenkov <arvidjaar@gmail.com>
Subject: Anonymous commit (empty Author and Committer)
Date: Fri, 30 Oct 2015 17:26:00 +0300
Message-ID: <56337DF8.5050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, savannah-users@gnu.org
To: The development of GRUB 2 <grub-devel@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 15:26:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsAdB-0002BK-4F
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 15:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbbJ3O0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 10:26:08 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36008 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbJ3O0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 10:26:05 -0400
Received: by lbjm5 with SMTP id m5so51722198lbj.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=pkWL/StDSJsssRKPtlr/8lVdQ3fCyYO/P228dZA6aEw=;
        b=KRfthT3rmJAxATexa5QohEBMgrxiG4LS7v0ptlFVmcPOj05IjfXe+sCJ55EGpsj/DS
         6DHuP3/PiLzYIOTCj30CfJ4/Z6ZUvqnlogr5bNiCAiG+sr8Lzw83FNtEMyCSu9lbS7dA
         ioMrMRx5QgG3FKDLp5EynxJlRwhB38FWO0+I2liQZjKvwFv66PaS72YnKK6AXQTtaeYr
         ELFMXBl3xL7nJyQSPoTWTxEgYnWw86NxNkv+W7P3TIwhJZwcG7o474xM1N6zoN+jV7JT
         cwZG/aHlj2HgHZ7DNQ/Ax1/hLdduWtaM5W0feez57CYLbcsjobwfxRJsxlO586Jh0j1/
         urhA==
X-Received: by 10.112.11.231 with SMTP id t7mr4301921lbb.13.1446215162631;
        Fri, 30 Oct 2015 07:26:02 -0700 (PDT)
Received: from [192.168.1.41] (ppp91-76-25-247.pppoe.mtu-net.ru. [91.76.25.247])
        by smtp.gmail.com with ESMTPSA id zc3sm525492lbb.38.2015.10.30.07.26.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2015 07:26:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280486>

See 
http://git.savannah.gnu.org/cgit/grub.git/commit/?id=206676601eb853fc319df14cd3398fbdfde665ac

I was not even aware that this is possible. Is there anything on server 
side that can prevent it?

Would be good if commit were amended and force pushed to fix it.
