From: Zakaria Itani <zak.itani@gmail.com>
Subject: Git Download Problem
Date: Sat, 20 Feb 2016 19:00:59 +0200
Message-ID: <CANmjEXCw3fexzb+UNxwx10sxuSCZq-EFRxmdsnTCHyy8PLUwCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 18:01:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXAud-0002vl-7N
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 18:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbcBTRBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 12:01:01 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33148 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbcBTRBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 12:01:00 -0500
Received: by mail-wm0-f48.google.com with SMTP id g62so106343354wme.0
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 09:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KuFCJU0k6V0mNLfacRCu/lWeLsp2vMwpaUff291DFak=;
        b=KYTLat6bI+eQe4LryNSSDUcPQxvt9AZ5xCgnSgKi9vKTY7HXRXM/E0xxgfEOWsa79M
         pzOGAkne8QhmkXsU2epGaDXMzHsS3D78D9xJiotIiq/nIiHPi+kMqgfbOLQkTbBMNpA4
         FhAZtxIwqhi/WoASB0h1vkrIgeI0wQIGt+a1VkYQHUyGfgxlet6/3UEfLnG1JX0nkDEg
         aI1d3LCuYAm4+Rb/+2tiiAlFUfzNKQXd9O2WZFFGWcHL8sad3ckChADKN10h6pPp16ew
         pLyoLkRR23QL6BQCF5XYQpzAMa6BAfB2nVhXliQDGRKRA57ngY5MyVRfM9CuJreAYWgT
         GuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=KuFCJU0k6V0mNLfacRCu/lWeLsp2vMwpaUff291DFak=;
        b=mr1MydfhtVrKVriPYKPR9tdAb5kaQVuUD1JWarLBYT0D955qCBuBiWwooFQBU480IO
         qvP0r/LqQb6X1gfQfPvlR/QpU2lwBLft4zFu+ftYBGOkV0KyhxpDZIQHOuT21jMOlHe4
         x5thL+3ZXekcnfqt3ZcmeEd18DxsF6tXDLki47ZCkF6XzIZaKjB1D6zbrPimdY8zQLmy
         dlw4HD42EbJ5HmfYK6ScIAThg9L4CXbOI9GnWzXwqd9RPQLa+YsLqHKihweE8IuWh7mO
         tZnCZTxEGvpqCoUxZ62dUnrFBbfsWm052f/o1eHmfO174IR+EDW3dewIutskrTWQMIj/
         Nasw==
X-Gm-Message-State: AG10YOSeU/sCp/TUsxF3a3F6iOOQ/oFe4kGaezdNkwtJc4nuS4gQUmY2JJRvhxPUJxmuZEwcIAjb4+LPwm+LHQ==
X-Received: by 10.28.225.8 with SMTP id y8mr3526915wmg.23.1455987659040; Sat,
 20 Feb 2016 09:00:59 -0800 (PST)
Received: by 10.27.189.195 with HTTP; Sat, 20 Feb 2016 09:00:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286786>

Hello,

After downloading version 2.6.4 of git for mac, i faced a problem
launching it where a message showed up saying
git-2.6.4-intel-universal-mavericks.dmg couldn't be opened since image
is not recognized. My mac's current version is Yosemite 10.10.3

I'd like to know how could I fix this problem, thank you in advance.
Zak.
