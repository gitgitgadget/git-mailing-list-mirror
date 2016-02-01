From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Git for Windows
Date: Mon, 1 Feb 2016 17:18:32 +0000
Message-ID: <CANkmNDc_g7GZsDwiPE7cQruhWkmmfYwaaMBnESXBFczQ0DG_gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 18:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQI7t-0001ix-N4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 18:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbcBARSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 12:18:54 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34352 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbcBARSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 12:18:53 -0500
Received: by mail-lb0-f169.google.com with SMTP id cl12so79024880lbc.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=I9B9HeLaf6VMAwNb4T73BBAXnXB2859hQJ9hfEcMv8g=;
        b=ULnYIZp5xmSJlTXgqn8qcL6a0XYEIadjxXMKi1Oet34pS6sKsoL5siYsJ9dgPg1mtM
         egD17a2FQpAIl1eWfUYAfhVz31RjJ49GzmG3jWv5szbQxyVuy5a9iA08S4bKe3PM7Ldy
         YUP+ifuAHJq/nC97xwDRjPPRLqD7q/7zr4ucFjGpsYlI7Bq0WZ9dbvOd5WIUOSgq0/0w
         Cv1UQw+9NTrKrWH4kqeIMiz7wqld9ZTvp2lP+b4em/YHYR4iPTLeUPWtWhsW+UsHSkHS
         cijPo9WHpKSiif8ylc43AjM7k0dt38+HI+TqHwtDdl862TFwAEwZppZ9kuwohxR0mxjN
         k+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=I9B9HeLaf6VMAwNb4T73BBAXnXB2859hQJ9hfEcMv8g=;
        b=QxkSIR+DzGPU/NKg5fBSC9qDqdeOFISI4UkuXpWYQ9SZJEiljKYAJa6J4TMTUMy/zC
         VNuRsB1+EayOcc8osj9uIghk9wjqXREyHcufPGmEqzy+VNQpNNWcM6mnc0HcHMhmDkz6
         0ncd0PrVNjidRI0xmI8hmoeU5vOWPFTNfjekT5zyRVYbE1+dD/z5FB6u+LpbpVr+SNIK
         9yIURju6n9WBWTtsMpRRLxPXbpH9nlhDXIyKVxWJYvCL1sEn1p1DAa73RIkcrXJTtfJa
         pBtbXoPuAEwEoNOqYDdiTCyYaBSaH84KYJFHkjsYH1K7CkDaI7fMopbcxVsPNlNtGH7J
         g/tg==
X-Gm-Message-State: AG10YORVb35jEdHySnwqFhsQUNTuVWwizPYfGtIqfnx3le6n/wUAlBwrrlsMySxSs0BVNCUNycMPJ2anutsG6Q==
X-Received: by 10.112.35.138 with SMTP id h10mr8869023lbj.6.1454347131910;
 Mon, 01 Feb 2016 09:18:51 -0800 (PST)
Received: by 10.25.207.195 with HTTP; Mon, 1 Feb 2016 09:18:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285202>

Hi,

I am using Windows 10 and am getting "The signature for
git-2.7.0-64-bit.exe is corrupt or invalid" !

Same for the 32bit version.

Regards,

Aaron
