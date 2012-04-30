From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Branch to base i18n work on?
Date: Mon, 30 Apr 2012 12:51:59 +0200
Message-ID: <CACBZZX5M1X8oU7gh-BVnKrVP75+piXLbaimTCONrw-hWBqLnbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>,
	Xin Jiang <worldhello.net@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 12:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOoDT-0004e7-S0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 12:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab2D3KwW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 06:52:22 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50883 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2D3KwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 06:52:21 -0400
Received: by eekc41 with SMTP id c41so656517eek.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=X6eZNwVbyALYaRLwgXwjQgW69TLnOBfOqont8/A/z5M=;
        b=m1uYrLvSg2zy/197MGtzhd/4YVHmaE0XyanEQz/njjTT7iW2ZFkWkob2K7hMOudAig
         ZOHBQTICypvOnUMkKe7Hmdqwf3sbq+gtgUhZ6oT7MOcOJpl2KfYLOuBfhXnyrOWCgB/U
         +UnyKyfeafZ6kNCKJ1M0Cp86ybbSVmzkAKiwKXNL5B/VuPSZsYRMs2NwS05396pq8RvC
         57Ey9Tm8mMJe7b51EU62LeoFAgMo2onylFYZhGo6G35XcpdmjUrezAI/ojMAcxZpxXIo
         eYGWZHYqK5gchug4OKhDG5oImUVeEPjn8Rz7xdgu470JXrwU+sjkKfrmWhL40ka+1AJI
         Gzfw==
Received: by 10.14.127.5 with SMTP id c5mr4390607eei.120.1335783140164; Mon,
 30 Apr 2012 03:52:20 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Mon, 30 Apr 2012 03:51:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196553>

We have at least one series in flight to mark up more messages in Git f=
or i18n.

I'd like to do some work on this as well, but I don't want to
duplicate efforts, is there someone who's further ahead than pu/next
are so I can base my work on that instead of pu/next?

Nguy=E1=BB=85n, is there some repository I can pull your series from wi=
thout
trying to extract it from Junio's tree where it's been rebased with
other work?
