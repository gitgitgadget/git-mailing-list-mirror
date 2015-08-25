From: Gawade P <gawade.oefp@gmail.com>
Subject: git Dockerfile for ppc64le
Date: Tue, 25 Aug 2015 10:07:26 +0530
Message-ID: <CAPS4ckqWociyEmph-mr3Ncz8J5genGjGPNu+sHsSviG5AKwu0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 06:37:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU5zI-0001mU-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 06:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbbHYEh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 00:37:28 -0400
Received: from mail-wi0-f195.google.com ([209.85.212.195]:33111 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbbHYEh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 00:37:27 -0400
Received: by wius16 with SMTP id s16so621689wiu.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 21:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=YkyN7jy/emo56MaW1Zndsz96kWfXyfNubV67sr5Na74=;
        b=TZzSMEr3JNTVj95ysHJ5BXBRn/WrSpQzQIo2J5BBzRww25prtfLqZ19UknjmHwZPQh
         hQ2WjaA63i2YIOAyj0lEVKfysplcWh1rsQncAIJQabVNctoIv/ZmaqX8VBdIaaYdUsoI
         ctwOoPiOPEi2Zv2fj1lXkxZA1K2WIZgK8MSVNd8oYk0JQCKjmg3kdxD5S6mtGGVt40W3
         egqimtOvI807XLmD0qoNO9z66BExWzDDIncvLFOwzCIxizGbKfop0U/l2SKajVza1G7b
         Zp2PfMaE31a9s1xeTVFAozeaqbdwXPbUiKnkXiUIzLfurGJPCVVr1T8d7SvAsskRL/X8
         N52w==
X-Received: by 10.180.87.100 with SMTP id w4mr1251116wiz.17.1440477446540;
 Mon, 24 Aug 2015 21:37:26 -0700 (PDT)
Received: by 10.28.8.204 with HTTP; Mon, 24 Aug 2015 21:37:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276504>

 Hi All,

I have built and tested the latest version on git on multiple
distributions including Ubuntu 15.04 on the ppc64le architecture. I
have run the complete test suite and verified that there are no test
failures.

I have also written a dockerfile for this for Ubuntu 15.04 and wanted
to understand if there is any way I can contribute it to the git
community?

Any guidance on this would be great help. Thanks!

Regards,
Priya
