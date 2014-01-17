From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [Question] Usercase about git clone
Date: Fri, 17 Jan 2014 23:53:15 +0800
Message-ID: <C4261F36-897A-4131-B76C-2E370AFBA63C@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wang Shilong <wangsl.fnst@cn.fujitsu.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 16:53:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4BjZ-0007wu-NT
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 16:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbaAQPxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 10:53:23 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:39282 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaAQPxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 10:53:21 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so4241962pbb.23
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 07:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=u6bEXwnujol1Fjr0J1aLxPkl68tEeGkeDPpxbcoINpA=;
        b=SkY666FFO2NLSOHoeerxS12UPdBUUnWM5Yl4VN9f211J75GDs6v8bi9z1/oqXwzb5G
         ITTl5vkELosThW8huRR9WuZvhsgWkgXekseF6d1Ymr8WJyE0UKjFFkpqMRBRrowYkLNO
         lMsduXxFPcw+h7OwUG9X5HymM4Nx8Y/YBF6rSgarv7voVwOYCBPQ31u3Jtz7rf6YH/CW
         Kl5lDotAbc8CQL9jPxB/20gHOsXwizNObbWWh6f3eg0GH4lS+8bDVWXZdYUydGurS1C9
         yveHgp7gQ0QUtEEJU5zCbg31UVUojVBd0mAFzHjr+DfiToFhjjVdGKXAbOWxK1Vd9Pen
         LMiA==
X-Received: by 10.68.66.103 with SMTP id e7mr2898393pbt.120.1389974000676;
        Fri, 17 Jan 2014 07:53:20 -0800 (PST)
Received: from [192.168.1.100] ([223.65.188.59])
        by mx.google.com with ESMTPSA id by1sm23767267pbd.25.2014.01.17.07.53.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 07:53:19 -0800 (PST)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240600>

Hello everyone,

I have a question about command 'git clone'
If i clone a repo from remote, and if i run command:

# git remote show origin

It will output origin's url, however, this is what i want,  i just want=
 to clone
codes, but keep everything else unchanged, for example branches and
they url=A1=AD.

How can i implement such functions by 'git clone'=A1=AD.I think this is=
 really
helpful because i really don't want to reset my branches' url every one=
=A1=AD

Really thanks for your time and response!

Thanks,
Wang

  